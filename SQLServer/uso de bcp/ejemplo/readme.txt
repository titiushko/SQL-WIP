1. el archivo ramdom.xls es para datos, si ustedes poseen datos en sus tablas ya, no es necesario el uso de este archivo

2. El archivo  call_center_DB.Bak es una backup de la base de datos, donde ustedes pueden reestablecer la BD siempre y cuando 
   el motor de la base de datos sea compatible. en este caso se genero. de la version ocupada en los laboratorios de la escuela
   
	10.50.1600.1  RTM  Developer Edition

   ejecutar la siguiente instruccion transac sql

   SELECT SERVERPROPERTY('productversion'), SERVERPROPERTY ('productlevel'), SERVERPROPERTY ('edition')

   si es igual, "Perfecto". XD

3. si lo usa, tendra que importar los datos, especificando el origen y destino en
   microsoft manager. y modificar los tipos de datos en esta opcion para que cree un tabla nueva llamada random$ algo asi

4. va el script de copia de esta tabla creada a la tabla customers del modelo


5. proceder al uso del pequeño manual en docx.