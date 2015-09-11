CREATE OR REPLACE FUNCTION add_days (d date, n number)
RETURN DATE
IS
v_date DATE;
BEGIN
v_date := d + n;

DBMS_OUTPUT.put_line (v_date);
RETURN v_date;
END;
Simple test case

DECLARE
retval DATE;
d DATE;
n NUMBER;
BEGIN
d := SYSDATE;
n := -20;
retval := add_days (d, n);
END;

Output
17-NOV-08