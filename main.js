
//-------------- VARIABLES ---------------------------------------------------------------------------
let platosPricipales = ["Ensalada", "Macarrones", "Pure", "Cocido"];
let preciosPlatosPricipales = [3, 4, 3, 4];
let platosSegudos = ["Ternera", "Pescado", "Pollo", "Lomo"];
let preciosPlatosSegudos = [4, 4, 3, 3];
let platosPostres = ["Manzana", "Helado", "Yogur", "Tarta"];
let preciosPlatosPostres = [2, 3, 2, 3];


let platosPedidosM1 = [];
let platosPedidosM2 = [];
let platosPedidosM3 = [];
let platosPedidosM4 = [];
let platosPedidosM5 = [];

let mesa1;
let mesa2;
let mesa3;
let mesa4;
let mesa5;
var valor;


//-------------- VARIABLES ------------------------------------------------------------------------------^^

//-------------- FUNCIONES ------------------------------------------------------------------------------

/*function populate(slct1, slct2) {
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
*/

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

function actualizarPrecio(datosPedidos) {
    var parar = false;
    var contador = 0;
    var precio = 0;

    datosPedidos.forEach(plato => {

        platosPricipales.forEach(element => {
            if (plato == element) {
                parar = true;
                precio += preciosPlatosPricipales[contador];
            }
            contador++;
        });

        contador = 0;
        if (parar == false) {
            platosSegudos.forEach(element => {
                if (plato == element) {
                    parar = true;
                    precio += preciosPlatosSegudos[contador];
                }
                contador++;
            });
        } else if (parar == false) {
            contador = 0;
            platosPostres.forEach(element => {
                if (plato == element) {
                    parar = true;
                    precio += preciosPlatosPostres[contador];
                }
                contador++;
            });
        }

    });
    return precio;
}


//-------------- FUNCIONES ----------------------------------------------------------------------------- ^^



//-------------- JQUERYS --------------------------------------------------------------------------------

//Logica de cambiar entre los distintos tipos de platos
$("#radio1").click(function () {
    inicializarArrayPlatos(platosPricipales);
});

$("#radio2").click(function () {
    inicializarArrayPlatos(platosSegudos);
});

$("#radio3").click(function () {
    inicializarArrayPlatos(platosPostres);
});


//jquery para mostrar los platos pedidos de cada mesa cuando se cambia de mesa
$("#slct1").on("change", function () {
    $("#CajaPlatosPedidos").empty();
    if (this.value == "Mesa1") {
        platosPedidosM1.forEach(element => {
            $("#CajaPlatosPedidos").prepend($('<option />', {
                text: element,
                value: element,
            }));
        });
    } else if (this.value == "Mesa2") {
        platosPedidosM2.forEach(element => {
            $("#CajaPlatosPedidos").prepend($('<option />', {
                text: element,
                value: element,
            }));
        });
    } else if (this.value == "Mesa3") {
        platosPedidosM3.forEach(element => {
            $("#CajaPlatosPedidos").prepend($('<option />', {
                text: element,
                value: element,
            }));
        });
    } else if (this.value == "Mesa4") {
        platosPedidosM4.forEach(element => {
            $("#CajaPlatosPedidos").prepend($('<option />', {
                text: element,
                value: element,
            }));
        });
    } else {
        platosPedidosM5.forEach(element => {
            $("#CajaPlatosPedidos").prepend($('<option />', {
                text: element,
                value: element,
            }));
        });
    }

});


//Logica de almacenar los platos elegidos


$("#CajaMenu").on('change', function () {
    var plato = $(this).val();
    //Esta variable debe ser uno de los arrays anteriores
    //Falta la logica de cambiar el array cuando se cambia la mesa
    $("#CajaPlatosPedidos").prepend($('<option />', {
        text: plato,
        value: plato,
    }));
    actualizarPrecio(plato);
});

//-------------- CODIGO PROGRAMA -------------- ESTO ES LO QUE SE VA A EJECUTAR 

inicializarArrayPlatos(platosPricipales);



$("#cbox1").on('click', function () {
    if ($('#cbox1').is(':checked')) {
        alert('Seleccionado');
    } else {
        alert('a');
    }
});
$("#cbox2").on('click', function () {
    if ($('#cbox2').is(':checked')) {
        alert('Seleccionado');
    } else {
        alert('a');
    }
});


$("#botonPagar").on('click', function () {
    document.getElementById("cajaPrecio").value = "€";
});

//-------------- CODIGO PROGRAMA -------------- ESTO ES LO QUE SE VA  A EJECUTAR ^^

/*Loica de poner los precios
var parar = false;
var contador = 0;
var precio = 0;

platosPricipales.forEach(element => {
    contador++;
    if (plato == element) {
        parar = true;
        precio += preciosPlatosPricipales[contador];
    }
});

contador = 0;
if (parar == false) {
    platosSegudos.forEach(element => {
        contador++;
        if (plato == element) {
            parar = true;
            precio += preciosPlatosSegudos[contador];
        }
    });
} else if (parar == false) {
    contador = 0;
    platosPostres.forEach(element => {
        contador++;
        if (plato == element) {
            parar = true;
            precio += preciosPlatosPostres[contador];
        }
    });
}


//Nose pq no va esta mierda
*/




