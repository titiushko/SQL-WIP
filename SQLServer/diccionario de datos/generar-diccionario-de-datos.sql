/*
http://consejosdelguru.blogspot.com/2011/09/generar-diccionario-de-datos-sql-server.html
*/

/*
para systypes and xusertype <= 256)
Creado por Adán Salvador Aguilera Campos
Aguascalientes, Mexico
Basado en gran parte en el trabajo hecho por el Ing. Ely Michael Núñez
26/08/2011
*/
SET NOCOUNT ON
/*
------------------------------------------------------------------------------
 Variables y tablas temporales
*/
DECLARE @dbname sysname
DECLARE @name sysname
DECLARE @tabla sysname
DECLARE @uid smallint
DECLARE @usuario sysname
DECLARE @fecha nvarchar(11)
DECLARE @cmd nvarchar(600)
DECLARE @low nvarchar(11)
DECLARE @cont int
DECLARE @total int
SET @cont = 0
SET @total = 0

CREATE TABLE #Base (
  ident smallint,
  base sysname
)
----------------------------------------------------------------
/*Del script de diccionario de datos*/

/* Declares for databases variables */
DECLARE @db_name2 sysname
DECLARE @dbid smallint
DECLARE @db_filename nvarchar(520)
DECLARE @db_crdate datetime
DECLARE @db_size nvarchar(20)

/* Declares for databases files variables */
DECLARE @f_name nchar(256)
DECLARE @f_filename nchar(520)
DECLARE @f_size int
DECLARE @f_groupname sysname

/* Declares for tables variables */
DECLARE @id int
DECLARE @table_name sysname
DECLARE @xtype char(2)
DECLARE @crdate datetime
DECLARE @refdate datetime


-----------------------PRUEBA para syscolumns--------

CREATE TABLE #pk (
  TABLE_QUALIFIER varchar(100),
  TABLE_OWNER varchar(100),
  TABLE_NAME varchar(100),
  COLUMN_NAME varchar(100),
  KEY_SEQ smallint,
  PK_NAME varchar(100)
)

CREATE TABLE #columnas (
  TABLE_QUALIFIER sysname,
  TABLE_OWNER sysname,
  TABLE_NAME sysname,
  COLUMN_NAME sysname,
  DATA_TYPE smallint,
  TYPO varchar(100),
  PREC int,
  LENGTH int,
  SCALE smallint,
  RADIX smallint,
  NULLABLE smallint,
  REMARKS varchar(254),
  COLUMN_DEF nvarchar(3000),
  SQL_DATA_TYPE smallint,
  SQL_DATETIME_SUB smallint,
  CHAR_OCTET_LENGTH int,
  ORDINAL_POSITION int,
  IS_NULLABLE varchar(254),
  SS_DATA_TYPE tinyint
)
/*select column_name,typo, column_def,length,is_nullable,column_name
into @column_name, @column_type, @cdefault, @prec, @isnullable, @pk
*/----------------------------------------------------------

/* Declares for columns variables*/
DECLARE @llave sysname
DECLARE @column_name sysname
DECLARE @column_type varchar(13)
DECLARE @cdefault nvarchar(3000)
DECLARE @prec int
DECLARE @isnullable varchar(254)
DECLARE @nulo AS varchar(3)
DECLARE @pk sysname


------------------------------------------------------------------------------
/* Dado que se tienen que extraer datos de dos tablas diferentes se tiene
** que requerir al uso de tablas temporales para crear las descripciones
*
*/
/*
**  Se crea #Base a partir de sysdatabases
    para identificar las bases de datos registradas en el servidor y se descartan
    las que son de SQL Server
*/
INSERT INTO #Base (base, ident)
  SELECT
    name,
    dbid
  FROM master.dbo.sysdatabases
  WHERE (@dbname IS NULL
  OR name = @dbname)
  AND name <> 'master'
  AND name <> 'tempdb'
  AND name <> 'model'
  AND name <> 'msdb'
  AND name <> 'pubs'
  AND name <> 'Northwind'


/*
** Se busca cuales bases están accesibles para el usuario
** y las que no las elimina de #Base
*/

DECLARE ms_crs_c1 CURSOR FOR
SELECT
  DB_NAME(ident)
FROM #Base
OPEN ms_crs_c1
FETCH ms_crs_c1 INTO @name
WHILE @@fetch_status >= 0
BEGIN
  IF (HAS_DBACCESS(@name) <> 1)
  BEGIN
    DELETE #Base
    WHERE CURRENT OF ms_crs_c1
    RAISERROR (15622, -1, -1, @name)
  END
  FETCH ms_crs_c1 INTO @name
END
DEALLOCATE ms_crs_c1
/*
**  Se utiliza @curdbid para recorrer los identificadores de BD
**  en #Base para construir las otras dos tablas temporales, se construyen sus caracteristicas
**  @ErrorSave1 se utiliza para manejar errores
*/
PRINT '<html>'
PRINT '<head><title>'
PRINT '           Diccionario de Datos'
PRINT '</title>'
PRINT '<style type="text/css">'
PRINT '<!--'
PRINT '           .style5 {color: #CCCCCC; font-weight: bold; }'
PRINT '           .style6 {color: #0000CC}'
PRINT '           .style7 {color: #000066}'
PRINT '-->'
PRINT '</style>'
PRINT '</head>'
PRINT '<body>'
PRINT '     <table>                
            <tr>       
                  <td colspan="7">
                        <h1><strong><span class="style7">Servidor: </span>' + @@servername + '</strong></h1>
                  </td>
            </tr>
      </table>'


DECLARE @curdbid smallint
SELECT
  @curdbid = MIN(ident)
FROM #Base
WHILE @curdbid IS NOT NULL
BEGIN
  SET @name = DB_NAME(@curdbid)
  SELECT
    @db_name2 = name,
    @dbid = dbid,
    @db_filename = filename,
    @db_crdate = crdate
  FROM master..sysdatabases
  WHERE dbid = DB_ID(@name)
  SELECT
    @low = CONVERT(varchar(11), low)
  FROM master.dbo.spt_values
  WHERE type = N'E'
  AND number = 1

  SELECT
    @cmd = '(select str(convert(dec(15),sum(size))* ' + @low + '/ 1048576,10,2)+ N'' MB'' from '
    + QUOTENAME(@name, N'[') + N'.dbo.sysfiles)'
  /*set @cmd= '@db_size = (select str(convert(dec(15),sum(size))* ' + @low + '/ 1048576,10,2)+ N'' MB'' from '
                                           + quotename(@name, N'[') + N'.dbo.sysfiles) '
  */
  PRINT '     <div>'
  PRINT '           <hr noshade="noshade"/>'
  PRINT '           <table >'
  PRINT '                 <tr>
                        <td colspan="7"><strong><span class="style7">Nombre de Base de Datos: </span></strong>' + @name
  PRINT '                      </td>
                  </tr>'
  PRINT '                 <tr>
                        <td colspan="7"><strong><span class="style7">Ruta del archivo: </span></strong>' + @db_filename
  PRINT '                      </td>
                  </tr>'
  PRINT '                 <tr>
                        <td colspan="7"><strong><span class="style7">Fecha de creación: </span></strong>' + CONVERT(varchar, @db_crdate)
  PRINT '                      </td>
                  </tr>'
  PRINT '                 <tr>
                        <td colspan="7"><strong><span class="style7">Tamaño: </span></strong>'
  EXEC (@cmd)
  PRINT '                      </td>
                  </tr>
                  '


  SELECT
    @cmd = 'Use "' + @name + '"' + CHAR(13) + ' 
      declare files_cursor cursor for         
      select name, filename, isnull((select groupname from sysfilegroups b where b.groupid = a.groupid),''N/A'')
            from sysfiles a'
  EXEC (@cmd)



  OPEN files_cursor
  FETCH NEXT FROM files_cursor
  INTO @f_name, @f_filename, @f_groupname
  PRINT '                 <tr>
                        <td colspan="7">
                             <ul>'

  WHILE @@fetch_status = 0
  BEGIN

    PRINT '                                  <li>
                                         <b>' + @f_name + '</b>
                                         <br/>
                                         - Archivo: ' + @f_filename + '<br/>                 
                                         - Tipo: ' + @f_groupname + '
                                   </li>'

    FETCH NEXT FROM files_cursor
    INTO @f_name, @f_filename, @f_groupname

  END
  PRINT '                            </ul>
                        </td>
                  </tr>
            </table>
            <hr />'
  PRINT '     </div>'


  CLOSE files_cursor
  DEALLOCATE files_cursor

  SELECT
    @cmd = 'Use "' + @name + '"' + CHAR(13) + '       
            declare table_cursor cursor for
            select id, name, xtype, crdate, refdate from sysobjects where xtype = ''u''
      '
  EXEC (@cmd)
  OPEN table_cursor

  FETCH NEXT FROM table_cursor
  INTO @id, @table_name, @xtype, @crdate, @refdate

  WHILE @@fetch_status = 0
  BEGIN
    SET @cont = @cont + 1


    SELECT
      @cmd = 'Use "' + @name + '"' + CHAR(13) + '       
                  declare total_cr cursor for
                  select count(*) from sysobjects where xtype = ''u''
            '
    EXEC (@cmd)


    OPEN total_cr

    FETCH NEXT FROM total_cr
    INTO @total

    WHILE @@fetch_status = 0
    BEGIN

      FETCH NEXT FROM total_cr
      INTO @total
    END
    CLOSE total_cr
    DEALLOCATE total_cr
    PRINT '     <div style="margin-left:5%;">
            <table >
                  <tr>'
    IF (@cont > 1)
    BEGIN
      PRINT '<br/>'
    END
    PRINT
    '
                        <td>
                        </td>
                        <td colspan="1" style="border:1px solid black">
                             <b>Tabla</b> ' + CONVERT(varchar, @cont) + ' de ' + CONVERT(varchar, @total) + '
                        </td>
                        <td colspan="1" style="border:1px solid black">
                             <b>B.D. </b>' + @name + '
                        </td>                 
                        <td colspan="4" style="border:1px solid black">     
                             <span class="style6">Fecha de creación: ' + CONVERT(varchar, @crdate) + '</span>
                        </td>
                  </tr>
                  <tr>
                        <td>
                        </td>
                        <td colspan="6" style="font-weight:bold; font-size: 16px; border:1px solid black">
                              Nombre de tabla: ' + @table_name + '
                        </td>                 
                  </tr>
            </table>'
    PRINT '           <table cellpadding="2" cellspacing="0">'-- bordercolor="#CCCCCC">'

    PRINT '                 <tr>'-- bordercolor="#0066CC">'
    /*          print '     <tr bordercolor="#0066CC" bgcolor="#cc9300">'
    */
    PRINT '           <td style="border:none">
                        </td>                 
                        <td bgcolor="#0066CC"><span class="style5">Nombre de campo</span></td>'
    PRINT '                      <td bgcolor="#0066CC"><span class="style5">Llave primaria </span></td>'
    PRINT '                      <td bgcolor="#0066CC"><span class="style5">Tipo de columna</span></td>'
    PRINT '                      <td bgcolor="#0066CC"><span class="style5">Valor por Default</span></td>'
    PRINT '                      <td bgcolor="#0066CC"><span class="style5">Longitud</span></td>'
    PRINT '                      <td bgcolor="#0066CC"><span class="style5">Valores nulos</span></td>'
    PRINT '                </tr>'

    SELECT
      @cmd = ' delete #columnas Use "' + @name + '"' + CHAR(13) + '
                  insert into #columnas EXEC sp_columns "' + @table_name + '"'
    EXEC (@cmd)

    SELECT
      @cmd = 'delete #pk Use "' + @name + '"' + CHAR(13) + '
                  exec sp_pkeys "' + @table_name + '"'
    INSERT INTO #pk EXEC (@cmd)


    SELECT
      @cmd = 'update #columnas set REMARKS= '''' '
    EXEC (@cmd)

    SELECT
      @cmd = 'Use "' + @name + '"' + CHAR(13) + '
                  declare llaves cursor for
                        select column_name
                        from #pk'
    EXEC (@cmd)
    OPEN llaves
    FETCH NEXT FROM llaves
    INTO @llave
    WHILE @@fetch_status = 0
    BEGIN
      SELECT
        @cmd = 'update #columnas set remarks= ''X'' where column_name= ''' + @llave + ''''
      EXEC (@cmd)
      FETCH NEXT FROM llaves
      INTO @llave
    END
    CLOSE llaves
    DEALLOCATE llaves



    SELECT
      @cmd = 'Use "' + @name + '"' + CHAR(13) + '
                  declare columns_cursor cursor for
                        select column_name,typo, isnull(column_def,'' ''),length,is_nullable,remarks
                        from #columnas'
    EXEC (@cmd)
    OPEN columns_cursor
    FETCH NEXT FROM columns_cursor
    INTO @column_name, @column_type, @cdefault, @prec, @isnullable, @pk


    /*select @cmd= 'Use "' + @name + '"'+char(13)+'
          declare columns_cursor cursor for
                select name, type = (select top 1 name from systypes b where b.xtype = a.xtype and b.xusertype = a.xusertype),
                     cdefault, isnull(prec,0) as prec, isnullable,
                     pk = isnull((select top 1 ''PK'' from sysobjects where xtype = ''u'' and parent_obj = id),''No tiene'')
                from syscolumns a where id = ' + convert(varchar,@id)
         
   
    exec (@cmd)
    open columns_cursor

    fetch next from columns_cursor
          into @column_name, @column_type, @cdefault, @prec, @isnullable, @pk
*/
    WHILE @@fetch_status = 0
    BEGIN
      PRINT '                 <tr>
                        <td>
                        </td>'
      PRINT '                      <td style="border:1px solid black;">' + @column_name + '</td>'
      PRINT '                      <td style="text-align:center; border:1px solid black;">' + @pk + '</td>'
      PRINT '                      <td style="border:1px solid black">' + ISNULL(@column_type, 'varchar') + '</td>'
      PRINT '                      <td style="text-align:center; border:1px solid black;">' + CONVERT(varchar, @cdefault) + '</td>'
      PRINT '                      <td style="text-align:center; border:1px solid black;">' + CONVERT(varchar, @prec) + '</td>'
      PRINT '                      <td style="text-align:center; border:1px solid black;">' + @isnullable + '</td>'
      PRINT '                 </tr>'
      /*if (@isnullable=0)
      begin
            set @nulo='No'
      end
      if (@isnullable=1)
      begin
            set @nulo='Si'
      end
*/


      FETCH NEXT FROM columns_cursor
      INTO @column_name, @column_type, @cdefault, @prec, @isnullable, @pk

    END

    PRINT '           <tr style="border:none">
                        </tr>
                        </table>'
    PRINT '     </div>'

    CLOSE columns_cursor
    DEALLOCATE columns_cursor
    /**/
    FETCH NEXT FROM table_cursor
    INTO @id, @table_name, @xtype, @crdate, @refdate

  END
  CLOSE table_cursor
  DEALLOCATE table_cursor

  ----------------------------------------------------------
  /*
  ** Buscamos el siguiente identificador de BD
  */ SET @cont = 0
  SELECT
    @curdbid = MIN(ident)
  FROM #Base
  WHERE ident > @curdbid
END
PRINT '     </body>'
PRINT '</html>'

/* obtener el resultado
-----------------------------------------------------------------
select base, nombre, usuario, num_filas, fecha
from #resul
order by base, nombre
-----------------------------------------------------------------
*/

DROP TABLE #base
DROP TABLE #columnas
DROP TABLE #pk