/*
creacion de la tarea que se ejecuta diariamente e invoca el proceso que envia 
correo de notificacion en caso de que encuentre garantias de titulos valores que 
esten proximos a vencerse dentro de un mes
tito miguel: 23/01/2013
*/
DECLARE
    --
    id_tarea NUMBER;
    --
BEGIN
    SYS.DBMS_JOB.SUBMIT(
        JOB       => id_tarea,
        WHAT      => 'ga.ga_titulos_vencimiento(0,1);',
        NEXT_DATE => TO_DATE('25/01/2013 08:00:00','DD/MM/YYYY HH24:MI:SS'),
        INTERVAL  => 'TRUNC(SYSDATE+1)',
        NO_PARSE  => FALSE
    );
    DBMS_OUTPUT.PUT_LINE('Numero de tarea para BANDESAL: '||TO_CHAR(id_tarea));
    COMMIT;
END;
/