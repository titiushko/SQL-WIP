/*
http://robinmp.blogspot.com/2014/04/script-para-generar-el-diccionario-de.html
*/

--Cut and paste the results to note pad and name with a *.html format when saving.

--//SQL Database documentation script
--//Author: Nitin Patel, Email: nitinpatel31@gmail.com
--//Modificado por :Robinson Moscoso, Email: robinmp@gmail.com
--//Date:26-Jun-2013
--//Description: T-SQL script to generate the database document for SQL server 2005 
DECLARE @i int,
        @maxi int
DECLARE @j int,
        @maxj int
DECLARE @sr int
DECLARE @Output varchar(4000)
DECLARE @SqlVersion varchar(5)
DECLARE @last varchar(155),
        @current varchar(255),
        @typ varchar(255),
        @description varchar(4000)
DECLARE @NombreTabla nvarchar(100)

--crear la tabla donde se van a guardar los tamaños
DECLARE @tamanio AS TABLE (
  objname varchar(255),
  rows varchar(100),
  reserved varchar(100),
  data varchar(100),
  index_size varchar(100),
  unused varchar(100)
)

CREATE TABLE #Tables (
  id int IDENTITY (1, 1),
  Object_id int,
  Name varchar(155),
  Type varchar(20),
  [description] varchar(4000)
)
CREATE TABLE #Columns (
  id int IDENTITY (1, 1),
  Name varchar(155),
  Type varchar(155),
  Nullable varchar(2),
  [description] varchar(4000),
  [valor] varchar(4000)
)
CREATE TABLE #Fk (
  id int IDENTITY (1, 1),
  Name varchar(155),
  col varchar(155),
  refObj varchar(155),
  refCol varchar(155)
)
CREATE TABLE #Constraint (
  id int IDENTITY (1, 1),
  Name varchar(155),
  col varchar(155),
  definition varchar(1000)
)
CREATE TABLE #Indexes (
  id int IDENTITY (1, 1),
  Name varchar(155),
  Type varchar(25),
  cols varchar(1000)
)
CREATE TABLE #Procedure (
  id int IDENTITY (1, 1),
  Shema varchar(50),
  [Procedure] varchar(100),
  CreadoEl varchar(100),
  UltimaModificacion varchar(100)
)

IF (SUBSTRING(@@VERSION, 1, 25) = 'Microsoft SQL Server 2005')
  SET @SqlVersion = '2005'
ELSE
IF (SUBSTRING(@@VERSION, 1, 26) = 'Microsoft SQL Server  2000')
  SET @SqlVersion = '2000'
ELSE
  SET @SqlVersion = '2005'
PRINT '<head>'
PRINT '<title>::' + DB_NAME() + '::</title>'
PRINT '<style>'

PRINT '  body {'
PRINT '  font-family:verdana;'
PRINT '  font-size:9pt;'
PRINT '  }'

PRINT '  td {'
PRINT '  font-family:verdana;'
PRINT '  font-size:9pt;'
PRINT '  }'

PRINT '  th {'
PRINT '  font-family:verdana;'
PRINT '  font-size:9pt;'
PRINT '  background:#A9D5A7;'
PRINT '  }'
PRINT '  table'
PRINT '  {'
PRINT '  background:#238C1D;'
--Print '  background:#d3d3d3;'
PRINT '  }'
PRINT '  tr'
PRINT '  {'
PRINT '  background:#ffffff;'
PRINT '  }'
PRINT ' </style>'
PRINT '</head>'
PRINT '<body>'

SET NOCOUNT ON
IF @SqlVersion = '2000'
BEGIN
  INSERT INTO #Tables (Object_id, Name, Type, [description])
    --FOR 2000
    SELECT
      OBJECT_ID(table_name),
      '[' + table_schema + '].[' + table_name + ']',
      CASE
        WHEN table_type = 'BASE TABLE' THEN 'Table'
        ELSE 'View'
      END,
      CAST(p.value AS varchar(4000))
    FROM information_schema.tables t
    LEFT OUTER JOIN sysproperties p
      ON p.id = OBJECT_ID(t.table_name)
      AND smallid = 0
      AND p.name = 'MS_Description'
    ORDER BY table_type, table_schema, table_name
END
ELSE
IF @SqlVersion = '2005'
BEGIN
  INSERT INTO #Tables (Object_id, Name, Type, [description])
    --FOR 2005
    SELECT
      o.object_id,
      '[' + s.name + '].[' + o.name + ']',
      CASE
        WHEN type = 'V' THEN 'View'
        WHEN type = 'U' THEN 'Table'
      END,
      CAST(p.value AS varchar(4000))
    FROM sys.objects o
    LEFT OUTER JOIN sys.schemas s
      ON s.schema_id = o.schema_id
    LEFT OUTER JOIN sys.extended_properties p
      ON p.major_id = o.object_id
      AND minor_id = 0
      AND p.name = 'MS_Description'
    WHERE type IN ('U', 'V')
    ORDER BY type, s.name, o.name;
END
SET @maxi = @@rowcount
SET @i = 1
PRINT '<table border="0" cellspacing="0" cellpadding="0" width="550px" align="center"><tr><td colspan="3" style="height:50;font-size:14pt;text-align:center;"><a name="index"></a><b>Index</b></td></tr></table>'
PRINT '<table border="0" cellspacing="1" cellpadding="0" width="550px" align="center"><tr><th>Sr</th><th>Object</th><th>Type</th></tr>'

WHILE (@i <= @maxi)
BEGIN
  SELECT
    @Output = '<tr><td align="center">' + CAST((@i) AS varchar) + '</td><td><a href="#' + Type + ':' + name + '">' + name + '</a></td><td>' + Type + '</td></tr>'
  FROM #Tables
  WHERE id = @i

  PRINT @Output
  SET @i = @i + 1
END
PRINT '</table><br />'

SET @i = 1
WHILE (@i <= @maxi)
BEGIN
  --table header
  SELECT
    @NombreTabla = name
  FROM #Tables
  WHERE id = @i
  DELETE FROM @tamanio
  INSERT INTO @tamanio
  EXEC sp_spaceused @NombreTabla

  SELECT
    @Output = '<tr><th align="left"><a name="' + Type + ':' + name + '"></a><b>' + Type + ':' + name + '</b></th></tr>',
    @description = [description]
  FROM #Tables
  WHERE id = @i
  PRINT '<br /><br /><br /><table border="0" cellspacing="0" cellpadding="0" width="1250px"><tr><td align="right"><a href="#index">Index</a></td></tr>'
  PRINT @Output
  PRINT '</table><br />'
  PRINT '<table border="0" cellspacing="0" cellpadding="0" width="1250px"><tr><th align="left">Nro Filas</th><th align="left">Reservado</th><th align="left">Tamaño de los Datos</th><th align="left">Tamaño de los Indices</th><th align="left">No Usado</th></tr>'
  SELECT
    @Output = '<tr><td align="left">' + rows + '</td><td align="left">' + reserved + '</td><td align="left">' + data + '</td><td align="left">' + index_size + '</td><td align="left">' + unused + '</td></tr>'
  FROM @tamanio
  PRINT @Output
  PRINT '</table><br />'

  PRINT '<table border="0" cellspacing="0" cellpadding="0" width="1250px"><tr><td><b>Description</b></td></tr><tr><td>' + ISNULL(@description, '') + '</td></tr></table><br />'

  --table columns
  TRUNCATE TABLE #Columns
  IF @SqlVersion = '2000'
  BEGIN
    INSERT INTO #Columns (Name, Type, Nullable, [description], valor)
      --FOR 2000
      SELECT
        c.name,
        TYPE_NAME(xtype) + (
        CASE
          WHEN (TYPE_NAME(xtype) = 'varchar' OR
            TYPE_NAME(xtype) = 'nvarchar' OR
            TYPE_NAME(xtype) = 'char' OR
            TYPE_NAME(xtype) = 'nchar') THEN '(' + CAST(length AS varchar) + ')'
          WHEN TYPE_NAME(xtype) = 'decimal' THEN '(' + CAST(prec AS varchar) + ',' + CAST(scale AS varchar) + ')'
          ELSE ''
        END
        ),
        CASE
          WHEN isnullable = 1 THEN 'Y'
          ELSE 'N'
        END,
        CAST(p.value AS varchar(8000)),
        ''
      FROM syscolumns c
      INNER JOIN #Tables t
        ON t.object_id = c.id
      LEFT OUTER JOIN sysproperties p
        ON p.id = c.id
        AND p.smallid = c.colid
        AND p.name = 'MS_Description'
      WHERE t.id = @i
      ORDER BY c.colorder
  END
  ELSE
  IF @SqlVersion = '2005'
  BEGIN
    INSERT INTO #Columns (Name, Type, Nullable, [description], valor)
      --FOR 2005 
      SELECT
        c.name,
        TYPE_NAME(user_type_id) + (
        CASE
          WHEN (TYPE_NAME(user_type_id) = 'varchar' OR
            TYPE_NAME(user_type_id) = 'nvarchar' OR
            TYPE_NAME(user_type_id) = 'char' OR
            TYPE_NAME(user_type_id) = 'nchar') THEN '(' + CAST(max_length AS varchar) + ')'
          WHEN TYPE_NAME(user_type_id) = 'decimal' THEN '(' + CAST([precision] AS varchar) + ',' + CAST(scale AS varchar) + ')'
          ELSE ''
        END
        ),
        CASE
          WHEN is_nullable = 1 THEN 'Y'
          ELSE 'N'
        END,
        CAST(p.value AS varchar(4000)),
        CAST(p1.value AS varchar(4000))
      FROM sys.columns c
      INNER JOIN #Tables t
        ON t.object_id = c.object_id
      LEFT OUTER JOIN sys.extended_properties p
        ON p.major_id = c.object_id
        AND p.minor_id = c.column_id
        AND p.name = 'MS_Description'
      LEFT OUTER JOIN sys.extended_properties p1
        ON p1.major_id = c.object_id
        AND p1.minor_id = c.column_id
        AND p1.name = 'Valor'
      WHERE t.id = @i
      ORDER BY c.column_id
  END
  SET @maxj = @@rowcount
  SET @j = 1

  PRINT '<table border="0" cellspacing="0" cellpadding="0" width="1250px"><tr><td><b>Table Columns</b></td></tr></table>'
  PRINT '<table border="0" colorbackground="#249732" cellspacing="1" cellpadding="0" width="1250px"><tr><th>Sr.</th><th>Name</th><th>Datatype</th><th>Nullable</th><th>Description</th><th>Value</th></tr>'

  WHILE (@j <= @maxj)
  BEGIN
    SELECT
      @Output = '<tr><td width="30px" align="center">' + CAST((@j) AS varchar) + '</td><td width="200px">' + ISNULL(name, '') + '</td><td width="200px">' + UPPER(ISNULL(Type, '')) + '</td><td width="50px" align="center">' + ISNULL(Nullable, 'N') + '</td><td width="650px">' + ISNULL([description], '') + '</td><td width="650px">' + ISNULL(valor, '') + '</td></tr>'
    FROM #Columns
    WHERE id = @j

    PRINT @Output
    SET @j = @j + 1;
  END

  PRINT '</table><br />'

  --reference key
  TRUNCATE TABLE #FK
  IF @SqlVersion = '2000'
  BEGIN
    INSERT INTO #FK (Name, col, refObj, refCol)
      --  FOR 2000
      SELECT
        OBJECT_NAME(constid),
        s.name,
        OBJECT_NAME(rkeyid),
        s1.name
      FROM sysforeignkeys f
      INNER JOIN sysobjects o
        ON o.id = f.constid
      INNER JOIN syscolumns s
        ON s.id = f.fkeyid
        AND s.colorder = f.fkey
      INNER JOIN syscolumns s1
        ON s1.id = f.rkeyid
        AND s1.colorder = f.rkey
      INNER JOIN #Tables t
        ON t.object_id = f.fkeyid
      WHERE t.id = @i
      ORDER BY 1
  END
  ELSE
  IF @SqlVersion = '2005'
  BEGIN
    INSERT INTO #FK (Name, col, refObj, refCol)
      --  FOR 2005
      SELECT
        f.name,
        COL_NAME(fc.parent_object_id, fc.parent_column_id),
        OBJECT_NAME(fc.referenced_object_id),
        COL_NAME(fc.referenced_object_id, fc.referenced_column_id)
      FROM sys.foreign_keys f
      INNER JOIN sys.foreign_key_columns fc
        ON f.object_id = fc.constraint_object_id
      INNER JOIN #Tables t
        ON t.object_id = f.parent_object_id
      WHERE t.id = @i
      ORDER BY f.name
  END

  SET @maxj = @@rowcount
  SET @j = 1
  IF (@maxj > 0)
  BEGIN

    PRINT '<table border="0" cellspacing="0" cellpadding="0" width="1250px"><tr><td><b>Refrence Keys</b></td></tr></table>'
    PRINT '<table border="0" cellspacing="1" cellpadding="0" width="1250px"><tr><th>Sr.</th><th>Name</th><th>Column</th><th>Reference To</th></tr>'

    WHILE (@j <= @maxj)
    BEGIN

      SELECT
        @Output = '<tr><td width="25px" align="center">' + CAST((@j) AS varchar) + '</td><td width="300px">' + ISNULL(name, '') + '</td><td width="300px">' + ISNULL(col, '') + '</td><td>[' + ISNULL(refObj, 'N') + '].[' + ISNULL(refCol, 'N') + ']</td></tr>'
      FROM #FK
      WHERE id = @j

      PRINT @Output
      SET @j = @j + 1;
    END

    PRINT '</table><br />'
  END

  --Default Constraints
  TRUNCATE TABLE #Constraint
  IF @SqlVersion = '2000'
  BEGIN
    INSERT INTO #Constraint (Name, col, definition)
      SELECT
        OBJECT_NAME(c.constid),
        COL_NAME(c.id, c.colid),
        s.text
      FROM sysconstraints c
      INNER JOIN #Tables t
        ON t.object_id = c.id
      LEFT OUTER JOIN syscomments s
        ON s.id = c.constid
      WHERE t.id = @i
      AND CONVERT(varchar, +(c.status & 1) / 1)
      + CONVERT(varchar, (c.status & 2) / 2)
      + CONVERT(varchar, (c.status & 4) / 4)
      + CONVERT(varchar, (c.status & 8) / 8)
      + CONVERT(varchar, (c.status & 16) / 16)
      + CONVERT(varchar, (c.status & 32) / 32)
      + CONVERT(varchar, (c.status & 64) / 64)
      + CONVERT(varchar, (c.status & 128) / 128) = '10101000'
  END
  ELSE
  IF @SqlVersion = '2005'
  BEGIN
    INSERT INTO #Constraint (Name, col, definition)
      SELECT
        c.name,
        COL_NAME(parent_object_id, parent_column_id),
        c.definition
      FROM sys.default_constraints c
      INNER JOIN #Tables t
        ON t.object_id = c.parent_object_id
      WHERE t.id = @i
      ORDER BY c.name
  END
  SET @maxj = @@rowcount
  SET @j = 1
  IF (@maxj > 0)
  BEGIN

    PRINT '<table border="0" cellspacing="0" cellpadding="0" width="1250px"><tr><td><b>Default Constraints</b></td></tr></table>'
    PRINT '<table border="0" cellspacing="1" cellpadding="0" width="1250px"><tr><th>Sr.</th><th>Name</th><th>Column</th><th>Value</th></tr>'

    WHILE (@j <= @maxj)
    BEGIN

      SELECT
        @Output = '<tr><td width="25px" align="center">' + CAST((@j) AS varchar) + '</td><td width="300px">' + ISNULL(name, '') + '</td><td width="300px">' + ISNULL(col, '') + '</td><td>' + ISNULL(definition, '') + '</td></tr>'
      FROM #Constraint
      WHERE id = @j

      PRINT @Output
      SET @j = @j + 1;
    END

    PRINT '</table><br />'
  END

  --Check  Constraints
  TRUNCATE TABLE #Constraint
  IF @SqlVersion = '2000'
  BEGIN
    INSERT INTO #Constraint (Name, col, definition)
      SELECT
        OBJECT_NAME(c.constid),
        COL_NAME(c.id, c.colid),
        s.text
      FROM sysconstraints c
      INNER JOIN #Tables t
        ON t.object_id = c.id
      LEFT OUTER JOIN syscomments s
        ON s.id = c.constid
      WHERE t.id = @i
      AND (CONVERT(varchar, +(c.status & 1) / 1)
      + CONVERT(varchar, (c.status & 2) / 2)
      + CONVERT(varchar, (c.status & 4) / 4)
      + CONVERT(varchar, (c.status & 8) / 8)
      + CONVERT(varchar, (c.status & 16) / 16)
      + CONVERT(varchar, (c.status & 32) / 32)
      + CONVERT(varchar, (c.status & 64) / 64)
      + CONVERT(varchar, (c.status & 128) / 128) = '00101000'
      OR CONVERT(varchar, +(c.status & 1) / 1)
      + CONVERT(varchar, (c.status & 2) / 2)
      + CONVERT(varchar, (c.status & 4) / 4)
      + CONVERT(varchar, (c.status & 8) / 8)
      + CONVERT(varchar, (c.status & 16) / 16)
      + CONVERT(varchar, (c.status & 32) / 32)
      + CONVERT(varchar, (c.status & 64) / 64)
      + CONVERT(varchar, (c.status & 128) / 128) = '00100100')

  END
  ELSE
  IF @SqlVersion = '2005'
  BEGIN
    INSERT INTO #Constraint (Name, col, definition)
      SELECT
        c.name,
        COL_NAME(parent_object_id, parent_column_id),
        definition
      FROM sys.check_constraints c
      INNER JOIN #Tables t
        ON t.object_id = c.parent_object_id
      WHERE t.id = @i
      ORDER BY c.name
  END
  SET @maxj = @@rowcount

  SET @j = 1
  IF (@maxj > 0)
  BEGIN

    PRINT '<table border="0" cellspacing="0" cellpadding="0" width="1250px"><tr><td><b>Check  Constraints</b></td></tr></table>'
    PRINT '<table border="0" cellspacing="1" cellpadding="0" width="1250px"><tr><th>Sr.</th><th>Name</th><th>Column</th><th>Definition</th></tr>'

    WHILE (@j <= @maxj)
    BEGIN

      SELECT
        @Output = '<tr><td width="25px" align="center">' + CAST((@j) AS varchar) + '</td><td width="300px">' + ISNULL(name, '') + '</td><td width="300px">' + ISNULL(col, '') + '</td><td>' + ISNULL(definition, '') + '</td></tr>'
      FROM #Constraint
      WHERE id = @j
      PRINT @Output
      SET @j = @j + 1;
    END

    PRINT '</table><br />'
  END


  --Triggers
  TRUNCATE TABLE #Constraint
  IF @SqlVersion = '2000'
  BEGIN
    INSERT INTO #Constraint (Name)
      SELECT
        tr.name
      FROM sysobjects tr
      INNER JOIN #Tables t
        ON t.object_id = tr.parent_obj
      WHERE t.id = @i
      AND tr.type = 'TR'
      ORDER BY tr.name
  END
  ELSE
  IF @SqlVersion = '2005'
  BEGIN
    INSERT INTO #Constraint (Name)
      SELECT
        tr.name
      FROM sys.triggers tr
      INNER JOIN #Tables t
        ON t.object_id = tr.parent_id
      WHERE t.id = @i
      ORDER BY tr.name
  END
  SET @maxj = @@rowcount

  SET @j = 1
  IF (@maxj > 0)
  BEGIN

    PRINT '<table border="0" cellspacing="0" cellpadding="0" width="1250px"><tr><td><b>Triggers</b></td></tr></table>'
    PRINT '<table border="0" cellspacing="1" cellpadding="0" width="1250px"><tr><th>Sr.</th><th>Name</th><th>Description</th></tr>'

    WHILE (@j <= @maxj)
    BEGIN
      SELECT
        @Output = '<tr><td width="25px" align="center">' + CAST((@j) AS varchar) + '</td><td width="300px">' + ISNULL(name, '') + '</td><td></td></tr>'
      FROM #Constraint
      WHERE id = @j
      PRINT @Output
      SET @j = @j + 1;
    END

    PRINT '</table><br />'
  END

  --Indexes
  TRUNCATE TABLE #Indexes
  IF @SqlVersion = '2000'
  BEGIN
    INSERT INTO #Indexes (Name, type, cols)
      SELECT
        i.name,
        CASE
          WHEN i.indid = 0 THEN 'Heap'
          WHEN i.indid = 1 THEN 'Clustered'
          ELSE 'Nonclustered'
        END,
        c.name
      FROM sysindexes i
      INNER JOIN sysindexkeys k
        ON k.indid = i.indid
        AND k.id = i.id
      INNER JOIN syscolumns c
        ON c.id = k.id
        AND c.colorder = k.colid
      INNER JOIN #Tables t
        ON t.object_id = i.id
      WHERE t.id = @i
      AND i.name NOT LIKE '_WA%'
      ORDER BY i.name, i.keycnt
  END
  ELSE
  IF @SqlVersion = '2005'
  BEGIN
    INSERT INTO #Indexes (Name, type, cols)
      SELECT
        i.name,
        CASE
          WHEN i.type = 0 THEN 'Heap'
          WHEN i.type = 1 THEN 'Clustered'
          ELSE 'Nonclustered'
        END,
        COL_NAME(i.object_id, c.column_id)
      FROM sys.indexes i
      INNER JOIN sys.index_columns c
        ON i.index_id = c.index_id
        AND c.object_id = i.object_id
      INNER JOIN #Tables t
        ON t.object_id = i.object_id
      WHERE t.id = @i
      ORDER BY i.name, c.column_id
  END

  SET @maxj = @@rowcount

  SET @j = 1
  SET @sr = 1
  IF (@maxj > 0)
  BEGIN

    PRINT '<table border="0" cellspacing="0" cellpadding="0" width="1250px"><tr><td><b>Indexes</b></td></tr></table>'
    PRINT '<table border="0" cellspacing="1" cellpadding="0" width="1250px"><tr><th>Sr.</th><th>Name</th><th>Type</th><th>Columns</th></tr>'
    SET @Output = ''
    SET @last = ''
    SET @current = ''
    WHILE (@j <= @maxj)
    BEGIN
      SELECT
        @current = ISNULL(name, '')
      FROM #Indexes
      WHERE id = @j

      IF @last <> @current
        AND @last <> ''
      BEGIN
        PRINT '<tr><td width="25px" align="center">' + CAST((@sr) AS varchar) + '</td><td width="300px">' + @last + '</td><td width="300px">' + @typ + '</td><td>' + @Output + '</td></tr>'
        SET @Output = ''
        SET @sr = @sr + 1
      END


      SELECT
        @Output = @Output + cols + '<br />',
        @typ = type
      FROM #Indexes
      WHERE id = @j

      SET @last = @current
      SET @j = @j + 1;
    END
    IF @Output <> ''
    BEGIN
      PRINT '<tr><td width="25px" align="center">' + CAST((@sr) AS varchar) + '</td><td width="300px">' + @last + '</td><td width="300px">' + @typ + '</td><td>' + @Output + '</td></tr>'
    END

    PRINT '</table><br />'
  END
  --------------------------------------------------------------------------------------------
  SET @i = @i + 1;
  --Print @Output
  PRINT 'Autor: ROBINSON MOSCOSO - SIPSE'
END
-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- procedures
TRUNCATE TABLE #Procedure
IF @SqlVersion = '2005'
BEGIN
  ---create Table #Procedure(id int identity(1,1), Shema varchar(25), [Procedure] Varchar(60), CreadoEl varchar(50), UltimaModificacion varchar(50))
  INSERT INTO #Procedure (Shema, [Procedure], CreadoEl, UltimaModificacion)
    SELECT
      SPECIFIC_SCHEMA AS Shema,
      ROUTINE_NAME AS [Procedure],
      CREATED AS CreadoEl,
      LAST_ALTERED AS UltimaModificacion
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_TYPE = 'PROCEDURE' -- AND LEFT(ROUTINE_NAME,4) ='usp_'
    ORDER BY ROUTINE_NAME
END

SET @maxj = @@rowcount
SET @j = 1


PRINT '<p>'
PRINT '<br>'
PRINT '<p>'
PRINT '<table border="0" cellspacing="0" cellpadding="0" width="1250px"><tr><td><b>Procedure Name</b></td></tr></table>'
PRINT '<table border="0" cellspacing="1" cellpadding="0" width="1250px"><tr><th>Sr.</th><th>Schema</th><th>Procedure Name</th><th>Creado El</th><th>UltimaModificacion</th></tr>'

WHILE (@j <= @maxj)
BEGIN
  SELECT
    @Output = '<tr><td width="30px" align="center">' + CAST((@j) AS varchar) + '</td><td width="70px">' + ISNULL(Shema, '') + '</td><td width="240px">' + ISNULL([Procedure], '') + '</td><td width="280px" align="Left">' + ISNULL(CreadoEl, '') + '</td><td width="280px">' + ISNULL(UltimaModificacion, '') + '</td></tr>'
  FROM #Procedure
  WHERE id = @j

  PRINT @Output
  SET @j = @j + 1;
END

PRINT '</table><br />'
PRINT 'Autor: ROBINSON MOSCOSO - SIPSE'
PRINT '</body>'
PRINT '</html>'

DROP TABLE #Tables
DROP TABLE #Columns
DROP TABLE #FK
DROP TABLE #Constraint
DROP TABLE #Indexes
DROP TABLE #Procedure

SET NOCOUNT OFF