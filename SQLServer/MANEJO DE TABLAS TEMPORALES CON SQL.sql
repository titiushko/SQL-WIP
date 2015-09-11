MANEJO DE TABLAS TEMPORALES CON SQL


Hace mucho tiempo este documento me hubiera ahorrado mucho trabajo, por eso quiero compartirlo.

En ocasiones es necesario el manejo de tablas temporales en la creación de un sp.
Entre muchos beneficios que tienen las tablas temporales esta el facilitar la programación y mejorar los tiempos de un sp.

Ejemplos:

1.	Crear una tabla temporal y llenarla.

Create table #tem_clientes (
	Documento	int,
	Tipodoc	char(1),
	Nombre	varchar(100)
)

Cuando el sp termina, las tablas temporales desaparecen, eso quiere decir que no las encontraras en la db y si intentas hacer una consulta  te saldrá un error que te informa que la tabla no existe.

El signo: #,  indica que la tabla es temporal.

Podemos llenar la tabla temporal de las siguiente forma:

Insert into #tem_clientes
Select cl_documento,cl_tipodoc,cl_nombre
  From  srs_clientes
Where cl_tipodoc = ‘C’

Si ejecutamos el query anterior, la tabla temporal se llena con los clientes que están identificados con las cédula.

Otro insert puede ser:

Insert into #tem_clientes values (7178969855,’N’,”COLCAFE”)

Podemos hacer consultas, update y todo los querys que queramos como si fuera una tabla normal.


 
Hay otra forma de crear una tabla temporal y llenarla al mismo tiempo:

Ejemplo:

Select cl_documento,cl_tipodoc,cl_nombre into #tem_clientes
  From  srs_clientes
Where cl_tipodoc = ‘N’


El problema con este query, es que los nombres de los campos de la  tabla temporal
Quedan iguales a los de la tabla srs_clientes.

Ejemplo: Para hacer una consulta del nombre sería:

Select  cl_nombre
   From #tem_clientes


Si  queremos que los nombres de la tabla temporal sean diferentes a la tabla fuente, entonces hacemos:

Ejemplo:

Select documento = cl_documento, dipodoc = cl_tipodoc, 
           nombre = cl_nombre into #tem_clientes
  From  srs_clientes
Where cl_tipodoc = ‘N’

     
LISTO PARSEROS.














 















