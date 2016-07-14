SELECT
  d.object_id,
  a.name [table],
  --schema_name(a.schema_id) schema_name, 
  --a.create_date,
  b.name [column],
  c.name [type],
  CASE
    WHEN c.name = 'numeric' OR
      c.name = 'decimal' OR
      c.name = 'float' THEN b.precision
    ELSE NULL
  END [precision],
  b.max_length,
  CASE
    WHEN b.is_nullable = 0 THEN 'no'
    ELSE 'si'
  END [permite nulls],
  CASE
    WHEN b.is_identity = 0 THEN 'no'
    ELSE 'si'
  END [es autonumerico],
  ep.value [descripcion],
  f.foreignkey,
  f.referencetablename,
  f.referencecolumnname
FROM sys.tables a
INNER JOIN sys.columns b ON a.object_id = b.object_id
INNER JOIN sys.systypes c ON b.system_type_id = c.xtype
INNER JOIN sys.objects d ON a.object_id = d.object_id
LEFT JOIN sys.extended_properties ep ON d.object_id = ep.major_id AND b.column_id = ep.minor_id
LEFT JOIN (
	SELECT
	  f.name AS foreignkey,
	  OBJECT_NAME(f.parent_object_id) AS tablename,
	  COL_NAME(fc.parent_object_id, fc.parent_column_id) AS columnname,
	  OBJECT_NAME(f.referenced_object_id) AS referencetablename,
	  COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS referencecolumnname
	FROM sys.foreign_keys AS f
	INNER JOIN sys.foreign_key_columns AS fc ON f.object_id = fc.constraint_object_id
  ) f ON f.tablename = a.name AND f.columnname = b.name
WHERE a.name <> 'sysdiagrams'
ORDER BY a.name, b.column_id;
