CREATE OR REPLACE PROCEDURE pr.enviar_correo_html_mult(
	p_envia		IN VARCHAR2,
	p_recibe	IN VARCHAR2,
	p_asunto	IN VARCHAR2,
	p_mensaje	IN VARCHAR2,
	p_acuse		IN VARCHAR2 DEFAULT NULL
) IS
	--
	v_numjob		INTEGER;
	v_valor			VARCHAR2(1);
	v_host_actual	VARCHAR2(255);
	puerto			NUMBER(5);
	--
BEGIN
	BEGIN 
		SELECT NVL(valor,'n')  
		  INTO v_valor 
		  FROM param_generales
		 WHERE cod_sistema = 'pa' AND abrev_parametro = 'envia_correos_jobs';
	
	EXCEPTION
		WHEN NO_DATA_FOUND THEN 
			DBMS_OUTPUT.PUT_LINE('el parametro no envia_correos_jobs no esta asignado e la tabla param_generales');
			v_valor := 'n';
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('error en el sistema ' || SQLERRM);
			v_valor := 'n';
	END;
	--
	BEGIN 
		SELECT SYS_CONTEXT('userenv','server_host') 
		  INTO v_host_actual
		  FROM dual;
	END;
	--
	IF UPPER(v_host_actual) = 'bmiprcon' THEN
		IF v_valor = 's' THEN
			DBMS_JOB.SUBMIT(v_numjob,'begin pr.enviar_correo_html_correo_mult('''||p_envia||''','''||p_recibe||''','''||p_asunto||''','''||p_mensaje||''','''||p_acuse||'''); end;', SYSDATE + 3/86400);
		END IF;
	ELSIF UPPER(v_host_actual) = 'bmipru' THEN
		IF v_valor = 's' THEN       
			DBMS_JOB.SUBMIT(v_numjob,'begin pr.enviar_correo_html_correo_mult('''||p_envia||''','''||p_recibe||''','''||p_asunto||''','''||p_mensaje||''','''||p_acuse||'''); end;', SYSDATE + 3/86400);
		END IF;
	ELSE
		DBMS_JOB.SUBMIT(v_numjob,'begin pr.enviar_correo_html_correo_mult('''||p_envia||''','''||p_recibe||''','''||p_asunto||''','''||p_mensaje||''','''||p_acuse||'''); end;', SYSDATE + 3/86400);
	END IF;
	--
	COMMIT;
END;
/