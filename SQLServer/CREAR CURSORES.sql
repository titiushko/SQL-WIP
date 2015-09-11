/*Un amigo me dijo que es mejor crear tus cursores en vez de utilizar: Declare cursor for de sql. Si alguien me puede explicar porque es esto cierto se lo agradecería mucho.


Bueno, por si es cierto, este es el código para crear tus propios cursores: 

Nota: El Código corre en sybase, pero no creo que tenga problema en otro motor de BD, claro que lo que importa realmente es el algoritmo.
*/


-- Con este query creas una tabla en sql (lógicamente puedes utilizar varias tablas, pero para nuestro ejemplo sólo utilizaremos esta tabla)

Create table empleados (

	Documento 	varchar(12),
	TipoDoc	char(2),
	Nombre	varchar(50)

)

-- Con este query puedes insertar registros en una tabla  (Es bueno)
insert into empleados
select "698754","CC","Pedro Perez"
union
select "98587856","NI","Ind. Colombia"
union
select "2154655","CC","Mario Castrillon"

-- Por ultimo este es el cursor:

-- Creo tabla temporal
Create table #temp_empleados(

	Consec		numeric identity,
	Documento 	varchar(12),
	TipoDoc	char(2),
	Nombre	varchar(50)

)

insert into #temp_empleados
select Documento, TipoDoc, Nombre
  from empleados



declare @w_i     int,
	@w_k     int,
	@w_doc varchar(12),
	@w_tdoc char(2),
	@w_nombre varchar(50)


select @w_i      = 1

select @w_k = count(*)  from #temp_empleados



select @w_doc  = Documento, @w_tdoc  = TipoDoc, @w_nombre =   Nombre
  from #temp_empleados
where Consec = @w_i     

while  @w_i <= @w_k
begin

	print  ' Doc: %1!', @w_doc

	select @w_i = @w_i + 1

	select @w_doc  = Documento, @w_tdoc  = TipoDoc, @w_nombre =  Nombre
	  from #temp_empleados
	where Consec = @w_i     

end


Suerte  parceros,









