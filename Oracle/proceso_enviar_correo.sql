CREATE OR REPLACE PROCEDURE ga_titulos_vencimiento(p_dia IN NUMBER DEFAULT 30) IS
/*
proceso que identifica que garantias de tipo "titulos valores" estan proximas a vencerse dentro
de un mes a partir de la fecha actual, si se encuentran garantias a vencer dentro de un mes se
enviaa un correo electronico al administrador notificandole sobre las garantias que estan pronto
a vencerse
la verificacion de garantias que estan proximas a vencerse se hace en una tarea que se ejecuta
diariamente en la base de datos e invoca el proceso de envio de correo con la notificacion en caso
de que encuentre garantias que esten proximas a vencerse

el proceso recibe como parametro el numero de dias de la fecha que se quiere buscar creditos por vencer a partir de la fecha actual
ejemplo de uso:
buscar creditos que se van a vencer en 5 dias: ga_titulos_vencimiento(5)
buscar creditos que se van a vencer en 3 meses: ga_titulos_vencimiento(90)
buscar creditos que se van a vencer en 4 dias y 1 mes: ga_titulos_vencimiento(34)
buscar creditos que se van a vencer en 1 año: ga_titulos_vencimiento(365)
tito miguel: 23/01/2013
*/
    --
    -- cursor que devuelve la cantidad de garantias que son de titulos valores a vecerse dentro de un mes
    CURSOR c_cantidad_titulos_vencer IS
        SELECT COUNT(*) cantidad_titulos_vencer
          FROM ga_det_sol_garantia
         WHERE det_tip_garantia = 'TV'
           AND det_cod_empresa IN(32,6)
           AND det_fec_vencimiento = TRUNC(SYSDATE + p_dia)
           AND det_estado = 'A';
    --
    -- cursor que devuelve las garantias que son de titulos valores a vecerse dentro de un mes
    CURSOR c_titulos_vencer IS
        SELECT det.det_cod_empresa empresa, ins.nombre_institucion institucion, det.det_num_credito credito, det.det_val_garantia garantia, det.det_fec_vencimiento fecha, det.det_des_garantia descripcion, det.det_emisor emisor
          FROM ga_det_sol_garantia det, ga_prediagnostico_ga pre, pr_instituciones_financieras ins
         WHERE det.det_tip_garantia = 'TV'
           AND det.det_cod_empresa IN(32,6)
           AND det_fec_vencimiento = TRUNC(SYSDATE + p_dia)
           AND det.det_estado = 'A'
           AND det.det_cod_empresa = pre.pre_cod_empresa
           AND det.det_anio = pre.pre_anio
           AND det.det_correlativo = pre.pre_correlativo
           AND pre.pre_ifi = ins.codigo_institucion
         ORDER BY det.det_fec_vencimiento;
    --
    -- cursor para obtener el correo electronico de quien recibe la notificacion por correo
    CURSOR c_correo IS
        SELECT cor_correo correo
          FROM pr.pr_correos c, pr.pr_detalle_x_correos d
         WHERE c.cor_id_correo = d.id_correo AND d.cod_servicio = 'GA_TITULOS_EN_VENCIMIENTO' AND d.codigo_empresa IN(32,6);
    --
    -- cursor para obtener la plantilla del correo que se va enviar
     CURSOR c_plantilla IS
        SELECT asunto, cuerpo, pie_pagina
          FROM pr.pr_plantilla_correos
         WHERE cod_servicio = 'GA_TITULOS_EN_VENCIMIENTO' AND codigo_empresa IN(32,6);
    --
    v_cantidad_titulos_vencer   NUMBER := 0;
    v_contador                  NUMBER := 0;
    v_empresa                   VARCHAR2(30) := NULL;
    --
    v_correo     pr.pr_correos.cor_correo%TYPE           := NULL;   -- correo electronico de quien recibe la notificacion por correo
    v_asunto     pr.pr_plantilla_correos.asunto%TYPE     := NULL;   -- titulo de la notificacion por correo
    v_cuerpo     pr.pr_plantilla_correos.cuerpo%TYPE     := NULL;   -- cuerpo del mensaje de la notificacion por correo
    v_pie_pagina pr.pr_plantilla_correos.pie_pagina%TYPE := NULL;   -- pie de pagina del cuerpo del mensaje de la notificacion por correo
    v_registro   VARCHAR2(4000) := NULL;                            -- registro con la informacion de la ifi que se adiciona a la tabla de la plantilla del correo que se va a enviar 
    v_mensaje    VARCHAR2(4000) := NULL;                            -- mensaje de la notificacion por correo
    --
BEGIN
    OPEN c_cantidad_titulos_vencer;
    FETCH c_cantidad_titulos_vencer INTO v_cantidad_titulos_vencer;
    IF c_cantidad_titulos_vencer%NOTFOUND THEN v_cantidad_titulos_vencer := 0; END IF;    
    CLOSE c_cantidad_titulos_vencer;
    --
    FOR c IN c_correo LOOP
        IF v_contador = 0 THEN
            v_contador := v_contador + 1;
        ELSE
            v_correo := v_correo||',';
        END IF;
        v_correo := v_correo||c.correo;
    END LOOP;
    --
    OPEN c_plantilla;
    FETCH c_plantilla INTO v_asunto, v_cuerpo, v_pie_pagina;
    IF c_plantilla%NOTFOUND THEN
        v_asunto := NULL;
        v_cuerpo := NULL;
        v_pie_pagina := NULL;
    END IF;
    CLOSE c_plantilla;
    --
    IF v_cantidad_titulos_vencer > 0 THEN
        FOR x IN c_titulos_vencer LOOP
            IF x.empresa = 32 THEN v_empresa := 'BANDESAL';
            ELSIF x.empresa = 6 THEN v_empresa := 'FIDEMYPE'; END IF;
            v_registro := v_registro||'<tr><td>'||v_empresa||'</td><td>'||x.institucion||'</td><td>'||x.credito||'</td><td>$ '||TO_CHAR(x.garantia,'999G999G999G990D00')||'</td><td>'||x.fecha||'</td><td>'||x.descripcion||'</td><td>'||x.emisor||'</td></tr>';
        END LOOP;
        --
        v_mensaje := v_cuerpo||v_registro||v_pie_pagina;
        pr.enviar_correo_html_mult('info@bandesal.gob.sv',v_correo,v_asunto,v_mensaje);
        --
    END IF;
    --
END;	-- fin del procedimiento ga_titulos_vencimiento