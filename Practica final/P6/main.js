$("#boton1").on('click', function () {

    var msg = "Los campos erróneos son: ";

    var num_vueltas = document.getElementById("num_vueltas").value;
    var longitud = document.getElementById("longitud").value;
    var num_curvas = document.getElementById("num_curvas").value;
    var ganancia = document.getElementById("ganancia").value;
    var nombre_circuito = document.getElementById("nombre_circuito").value;
    var ciudad = document.getElementById("ciudad").value;
    var pais = document.getElementById("pais").value;
    var nombre_coche = document.getElementById("nombre_coche").value;

    if(!(num_vueltas > 40 && num_vueltas < 80)){
        msg += "Número de vueltas " + num_vueltas + " inválido/ ";
    }

    if(!(longitud > 3000 && longitud < 9000)){
        msg += "longitud de las vueltas  " + longitud + " invalido/ ";
    }

    if(!(num_curvas > 6 && num_curvas < 20)){
        msg += "número de curvas " + num_curvas + " invalido/ ";
    }

    if(!(ganancia > 4 && ganancia < 10)){
        msg += "ganancia de potencia " + ganancia + " invalido/ ";
    }

    if(nombre_circuito == "" || ciudad == "" || pais == "" || nombre_coche == ""){
        msg += "Algún campo está vacío.";
    }

    if(msg!="Los campos erróneos son: "){
        window.alert(msg);
    }

    

});

