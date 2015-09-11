SELECT *
  FROM sys.v_$session
 WHERE schemaname <> 'SYS'
   AND status = 'INACTIVE'
   --AND status = 'ACTIVE'
   --AND status = 'KILLED'
   AND username = 'GA';
--
ALTER SYSTEM KILL SESSION '143,41925';
--
BEGIN
   FOR r IN(SELECT sid, serial# FROM sys.v_$session WHERE status = 'INACTIVE' AND schemaname <> 'SYS' AND username = 'GA') LOOP
      EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION ''' || r.sid || ',' || r.serial# || '''';
    END LOOP;
END;