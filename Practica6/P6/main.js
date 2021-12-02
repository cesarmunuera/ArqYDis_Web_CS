$("#boton").on('click', function () {

    var msg = "Los campos erróneos son: ";

    if(!($("num_vueltas").val > 40 && $("num_vueltas").val < 80)){
        msg += "número de vueltas, ";
    }

    if(!($("longitud").val > 3000 && $("longitud").val < 9000)){
        msg += "longitud de las vueltas, ";
    }

    if(!($("num_curvas").val > 6 && $("num_curvas").val < 20)){
        msg += "número de curvas, ";
    }

    if(!($("ganancia").val > 6 && $("ganancia").val < 20)){
        msg += "ganancia de potencia.";
    }

    if($("nombre_circuito").val == "" || $("ciudad").val == "" || $("pais").val == "" || $("nombre_coche").val == ""){
        msg += "Algún campo está vacío";
    }

    

});