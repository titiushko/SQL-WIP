-- CREAR UNA FUNCION QUE DEVUELVA EN NOMBRE DE UN DEPARTAMENTO, RECIBIENDO COMO PARAMETRO EL CODIGO DEL DEPARTAMENTO...
CREATE OR REPLACE FUNCTION fun_NombreDepartamento (codigo_departamento IN NUMBER)
RETURN VARCHAR2
IS
    nombre_departamento VARCHAR2(100);
BEGIN
    SELECT department_name
      INTO nombre_departamento
      FROM department
     WHERE department_id = codigo_departamento;
    
    RETURN nombre_departamento; 
END fun_NombreDepartamento;

-- PROBANDO LA FUNCION QUE DEVUELVE EL NOMBRE DE UN DEPARTAMENTO...
DECLARE
    nombre VARCHAR2(100);
BEGIN
    nombre := fun_NombreDepartamento(20);
    --DBMS_OUTPUT.PUT_LINE('Nombre del Departamento: ' || nombre);
    RAISE_APPLICATION_ERROR(-20100,'Nombre del Departamento: ' || nombre);
END;

-- CREAR PROCEDIMIENTO QUE DEVUELVA EN NOMBRE DE UN DEPARTAMENTO, RECIBIENDO COMO PARAMETRO EL CODIGO DEL DEPARTAMENTO...
CREATE OR REPLACE PROCEDURE proc_NombreDepartamento (codigo_departamento IN NUMBER, nombre_departamento OUT VARCHAR2)
IS
BEGIN
    SELECT department_name
      INTO nombre_departamento
      FROM department
     WHERE department_id = codigo_departamento;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            nombre_departamento:= 'El Codigo del Departamento no Existe!';
        /*
        WHEN TOO_MANY_ROWS THEN
            nombre_departamento:= 'Existe mas de un Registro!';
        */         
        WHEN OTHERS THEN
            nombre_departamento:= 'Ah ocurrido un Error del tipo: ' || SQLERRM || '!';

END proc_NombreDepartamento;

-- PROBANDO EL PROCEDIMIENTO QUE DEVUELVE EL NOMBRE DE UN DEPARTAMENTO...
DECLARE
    nombre VARCHAR2(100);
    contador NUMBER;
BEGIN 
    proc_NombreDepartamento(10,nombre);
    RAISE_APPLICATION_ERROR(-20100,'Nombre del Departamento: ' || nombre);
END;

-- CREAR UNA FUNCION QUE UTILICE UN CURSOR QUE DEVUELVA EN NOMBRE DE UN DEPARTAMENTO, RECIBIENDO COMO PARAMETRO EL CODIGO DEL DEPARTAMENTO...
CREATE OR REPLACE FUNCTION fun_NombreDepartamento2 (codigo_departamento IN NUMBER)
RETURN VARCHAR2
IS
    nombre_departamento VARCHAR2(100);
    
    CURSOR nombreDepartamento IS    -- No da error de tipo NO_DATA_FOUN y TOO_MANY_ROWS
        SELECT department_name      
          FROM department
         WHERE department_id = codigo_departamento;
BEGIN
    OPEN nombreDepartamento;
    FETCH nombreDepartamento INTO nombre_departamento;
    CLOSE nombreDepartamento;
    
    IF nombre_departamento IS NULL THEN
        nombre_departamento := 'El Codigo del Departamento no Existe!';
    END IF;
    
    RETURN nombre_departamento;
END fun_NombreDepartamento2;

-- PROBANDO LA FUNCION QUE UTILIZA UN CURSOR QUE DEVUELVE EL NOMBRE DE UN DEPARTAMENTO...
DECLARE
    nombre VARCHAR2(100);
BEGIN
    nombre := fun_NombreDepartamento2(600);
    RAISE_APPLICATION_ERROR(-20100,'El Nombre del Departamento es: ' || nombre);
END;

/*============================================================================================================*/

-- CREACION DE PAQUETES...
-- SPEC...
CREATE OR REPLACE PACKAGE pkg_Departamento 
IS
    FUNCTION fun_getNombreDepartamento (codigo_departamento IN NUMBER)
    RETURN VARCHAR2;
    
    PROCEDURE proc_getNombreDepartamento (codigo_departamento IN NUMBER, nombre_departamento OUT VARCHAR2);
    
END pkg_Departamento;

-- BODY...
CREATE OR REPLACE PACKAGE BODY pkg_Departamento 
IS
    FUNCTION fun_getNombreDepartamento (codigo_departamento IN NUMBER)
    RETURN VARCHAR2
    IS
        nombre_departamento VARCHAR2(100);
    
        CURSOR nombreDepartamento IS
            SELECT department_name      
              FROM department
             WHERE department_id = codigo_departamento;
    BEGIN
        OPEN nombreDepartamento;
        FETCH nombreDepartamento INTO nombre_departamento;
        CLOSE nombreDepartamento;
    
        IF nombre_departamento IS NULL THEN
            nombre_departamento := 'NOOOOO!!! El Codigo del Departamento no Existe!';
        END IF;
    
        RETURN nombre_departamento;
    END fun_getNombreDepartamento;
    
    PROCEDURE proc_getNombreDepartamento (codigo_departamento IN NUMBER, nombre_departamento OUT VARCHAR2)
    IS
    BEGIN
        SELECT department_name
          INTO nombre_departamento
          FROM department
         WHERE department_id = codigo_departamento;
    
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                nombre_departamento:= 'El Codigo del Departamento no Existe!';
            /*
            WHEN TOO_MANY_ROWS THEN
                nombre_departamento:= 'Existe mas de un Registro!';
            */         
            WHEN OTHERS THEN
                nombre_departamento:= 'Ah ocurrido un Error del tipo: ' || SQLERRM || '!';

    END proc_getNombreDepartamento;

END pkg_Departamento;

-- PROBANDO LA FUNCION DEL PAQUETE...
DECLARE
    contador NUMBER;
    nombre VARCHAR2(100);
BEGIN
    contador := 10;
    WHILE contador <= 300 LOOP
        DBMS_OUTPUT.PUT_LINE('Nombre del Departamento es: ' || pkg_Departamento.fun_getNombreDepartamento(contador));
        contador := contador + 10;
    END LOOP;    
    
    --pkg_Departamento.proc_getNombreDepartamento(60,nombre);
    --DBMS_OUTPUT.PUT_LINE('Nombre del Departamento es: ' || nombre);
END;