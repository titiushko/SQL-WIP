/* Recorrer los registros de una tabla sin utilizar cursores */
Declare @Indice Int, @Contador Int;
Set @Indice = 1;
Select @Contador = Count(*) From AspNetUsers;

/* Utilizando un while se recorren los registros de la tabla sin utilizar un cursor */
While @Indice <= @Contador
Begin
	/* Se recorren secuencialmente los registros de la tabla al introducir la función Rank() y establecer el resultado en la variable @Indice */
    Select Id, UserName, Email
	From (Select *, Rank() Over (Order By UserName Asc) As Rank From AspNetUsers) As Tabla
    Where Rank = @Indice;
/* Terminadas las opercaciones se incrementa en 1 la variable @Indice */
	Set @Indice = @Indice + 1;
End;
Go