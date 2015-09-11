/*-----------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- invocacion del proceso que envia los correos
CALL pr.enviar_correo_html_mult(
'info@bandesal.gob.sv', -- p_envia
'sergio.iraheta@creativaconsultores.com',   -- p_recibe    --William.Cambray@bandesal.gob.sv
'Notificacion de Titulos Valores a Vencer.',    -- p_asunto
'Estimado usuario,<br>
<br>
Se le informa que se encuentran Garant&iacute;as Adicionales de T&iacute;tulos Valores que están cerca a vencerse, lo cual se detalla a continuaci&oacute;n:<br>
<br>
<table border="1">
<tr><th>EMPRESA</th><th>NOMBRE INSTITUCI&Oacute;N</th><th>N&Uacute;MERO CR&Eacute;DITO</th><th>VALOR GARANT&Iacute;A</th><th>FECHA VENCIMIENTO</th><th>DESCRIPCI&Oacute;N</th><th>EMISOR</th></tr>
<tr><td>BANDESAL</td><td>FEDECREDITO, DE C.V.</td><td>185205</td><td>$280,000.00</td><td>26/01/2013</td><td>CERTIFICADO NEGOCIABLE DE LIQUIDEZ</td><td>FEDECREDITO</td></tr>
<tr><td>BANDESAL</td><td>FEDECREDITO, DE C.V.</td><td>28520</td><td>$343,000.00</td><td>27/01/2013</td><td>CERTIFICADO NEGOCIABLE DE LIQUIDEZ</td><td>FEDECREDITO</td></tr>
<tr><td>FIDEMYPE</td><td>FEDECREDITO, DE C.V.</td><td>133244763</td><td>$260,000.00</td><td>30/01/2013</td><td>&nbsp;</td><td>MINISTERIO DE HACIENDA</td></tr>
<tr><td>BANDESAL</td><td>BANCO G&T CONTINENTAL EL SALVADOR, SOCIEDAD ANONIMA</td><td>8520</td><td>$6000,000.00</td><td>03/02/2013</td><td>EUROSV2023</td><td>El Estado de EL Salvador por medio del MH</td></tr>
</table>
<br>
<br>
GA - Sistema de Garant&iacute;as Adicionales' -- p_mensaje
);
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- consulta para obtener la direccion de correo de quien recibira la notificacion por correo
SELECT cor_correo
  FROM pr_correos c, pr_detalle_x_correos d
 WHERE c.cor_id_correo = d.id_correo
   AND d.codigo_empresa = 32
   AND d.cod_servicio = 'GA_CARGA_TITULO_VENCIMIENTO';  --GA_CARGA_SUBIDA
/*----------------------------------------------------------------------------*/
-- consulta para obtener la plantilla del correo que se va enviar
SELECT asunto, cuerpo, pie_pagina
 FROM pr_plantilla_correos
WHERE cod_servicio = 'GA_CARGA_TITULO_VENCIMIENTO'  --GA_CARGA_SUBIDA
  AND codigo_empresa = 32;
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- ejecutar el proceso
BEGIN 
  ga_titulos_vencimiento(0,1);
  COMMIT;
END;
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- eliminar tarea con id_job: 12589
BEGIN 
    SYS.DBMS_JOB.REMOVE(12589);
    COMMIT;
END;
/
-- ejecutar tarea con id_job: 12683
EXECUTE DBMS_JOB.RUN(12752);
-- crear tarea
DECLARE
    --
    id_tarea NUMBER;
    --
BEGIN
    SYS.DBMS_JOB.SUBMIT(
        JOB       => id_tarea,
        WHAT      => 'ga.ga_titulos_vencimiento(0,1);',                       -- nombre del procedimiento almacenado a ejecutar
        NEXT_DATE => TO_DATE('28/01/2013 08:10:00','DD/MM/YYYY HH24:MI:SS'),  -- fecha y hora en el cual se debe ejecutar el job por primera vez
        INTERVAL  => 'SYSDATE+01/1440',                                       -- intervalo de tiempo para que el proceso se vuelva a ejecutar, cada dia 'TRUNC(SYSDATE+1)' -- cada minuto 'SYSDATE+01/1440'
        NO_PARSE  => FALSE                                                    -- indica si el proceso se debe dividir
    );
    DBMS_OUTPUT.PUT_LINE('Numero de tarea: '||TO_CHAR(id_tarea));
    COMMIT;
END;
/
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------*/