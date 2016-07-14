/*
http://wjsanchezg.blogspot.com/2011/12/diccionario-de-datos-con-sql-server.html
http://www.todoexpertos.com/categorias/tecnologia-e-internet/bases-de-datos/sql-server/respuestas/511789/diccionario-de-datos
*/

SET NOCOUNT ON

DECLARE @NOMBRE_TABLA sysname
DECLARE @iColumna int,
        @iUltimaColumna int,
        @NombreColumna sysname,
        @TipoColumna sysname,
        @Longitud int

SELECT
  @NOMBRE_TABLA = MIN(TABLE_NAME)
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
AND TABLE_NAME != 'sysdiagrams'

WHILE @NOMBRE_TABLA IS NOT NULL
BEGIN
  PRINT '======================' + @NOMBRE_TABLA + ':========================='

  SELECT
    @iColumna = 0,
    @iUltimaColumna = MAX(ORDINAL_POSITION)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_NAME = @NOMBRE_TABLA

  WHILE @iColumna < @iUltimaColumna
  BEGIN
    SELECT
      @iColumna = MIN(ORDINAL_POSITION)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = @NOMBRE_TABLA
    AND ORDINAL_POSITION > @iColumna;
    --
    SELECT
      @NombreColumna = IC.COLUMN_NAME,
      @TipoColumna = IC.DATA_TYPE,
      @Longitud =
                 CASE
                   WHEN CAST(IC.DATA_TYPE AS nvarchar) IN ('char', 'nchar', 'varchar', 'nvarchar', 'text', 'ntext') THEN IC.CHARACTER_MAXIMUM_LENGTH
                   ELSE NULL
                 END
    FROM INFORMATION_SCHEMA.COLUMNS IC
    WHERE IC.TABLE_NAME = @NOMBRE_TABLA
    AND IC.ORDINAL_POSITION = @iColumna;
    PRINT '. ' + @NombreColumna + ' ' + @TipoColumna + ' ' + ISNULL(CAST(@Longitud AS nvarchar(64)), '')
  --
  END

  SELECT
    @NOMBRE_TABLA = MIN(TABLE_NAME)
  FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_NAME > @NOMBRE_TABLA
  AND TABLE_TYPE = 'BASE TABLE'
  AND TABLE_NAME != 'sysdiagrams'
END