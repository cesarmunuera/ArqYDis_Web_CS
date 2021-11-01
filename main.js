
function populate(slct1, slct2) {
    var s1 = document.getElementById(slct1);
    var s2 = document.getElementById(slct2);
    s2.innerHTML = "";
    if (s1.value == "Mesa 1") {
        //aqui metemos lo correspondiente a elegir dicha mesa
        //var optionArray = ["mierda", ...];
    } else if (s1.value == "Mesa 2") {
        //aqui metemos lo correspondiente a elegir dicha mesa
        //var optionArray = ["mierda", ...];
    } else if (s1.value == "Mesa 3") {
        //aqui metemos lo correspondiente a elegir dicha mesa
        //var optionArray = ["mierda", ...];
    } else if (s1.value == "Mesa 4") {
        //aqui metemos lo correspondiente a elegir dicha mesa
        //var optionArray = ["mierda", ...];
    } else if (s1.value == "Mesa 5") {
        //aqui metemos lo correspondiente a elegir dicha mesa
        //var optionArray = ["mierda", ...];
    }
    for (var option in optionArray) {
        if (optionArray.hasOwnProperty(option)) {
            var pair = optionArray[option];
            var newOption = document.createElement("option");
            newOption.value = pair;
            newOption.innerHTML = pair;
            s2.options.add(newOption);
        }
    }
}

function accionBoton() {
    // Accion del boton
}


//Inicializamos la tabla izquierda con los primeros platos
function inicializarArrayPlatos(platosPricipales) {
    $("#CajaMenu").empty();
    //Esta funcion setea el array que le pasas, en la caja de la izquierda
    platosPricipales.forEach(element => {
        $("#CajaMenu").prepend($('<option />', {
            text: element,
            value: element,
        }));

    });


}

let platosPricipales = ["Ensalada", "Macarrones", "Pure", "Cocido"];
let platosSegudos = ["Ternera", "Pescado", "Pollo", "Lomo"];
let platosPostres = ["Manzana", "Helado", "Yogur", "Tarta"];

inicializarArrayPlatos(platosPricipales);
//Hasta aqui




//Ahora la logica de cambiar entre los distintos tipos de platos
/*$("#radio1").click(function () {
    if ($("#radio").is(':checked')) {
        //Llamamos a la funcion de inicializarArrayPlatos
    } else {
        //El else supongo que sobra
    }
});*/

$("#radio1").click(function () {
    inicializarArrayPlatos(platosPricipales);
});

$("#radio2").click(function () {
    inicializarArrayPlatos(platosSegudos);
});

$("#radio3").click(function () {
    inicializarArrayPlatos(platosPostres);
});













