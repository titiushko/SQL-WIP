var valor_inicial_class = '';

function f_over(celda)
{
	
	valor_inicial_class = celda.className ;
	celda.className = "fila_activa";
	var funcionout ;
	funcionout = new Function("f_out(this)");
	celda.onmouseout = funcionout ;
}

function f_out(celda)
{
	celda.className = valor_inicial_class;
}

function fnConfirmarBorrado()
{
	
	return window.confirm('Se dispone a eliminar el registro seleccionado. \n¿Confirma el borrado?');
}

// Funcion para abrir una imagen
var webname = "www.devjoker.com";
function ver_img(img, ancho, alto) {
    //relative se incia y asigna en la master page
    relative = "http://www.devjoker.com/";
    $.fn.colorbox({ href: relative + img, height: alto, width: ancho });
    /*
	var prop ="";
	ancho = ancho + 25;
	alto = alto + 25;
	prop = "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=1,width=" + ancho.toString() + ",height=" + alto.toString();	
	window.open (img,"",prop);*/
}


// Fin Funcion abrir imagen
function linkify(inputText) {
    //URLs starting with http://, https://, or ftp://
    var replacePattern1 = /(\b(https?|ftp):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/gim;
    var replacedText = inputText.replace(replacePattern1, '<a href="$1" target="_blank">$1</a>');

    //URLs starting with www. (without // before it, or it'd re-link the ones done above)
    var replacePattern2 = /(^|[^\/])(www\.[\S]+(\b|$))/gim;
    var replacedText = replacedText.replace(replacePattern2, '$1<a href="http://$2" target="_blank">$2</a>');

    //Change email addresses to mailto:: links
    /*
    var replacePattern3 = /(\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,6})/gim;
    var replacedText = replacedText.replace(replacePattern3, '<a href="mailto:$1">$1</a>');
    */
    return replacedText
}