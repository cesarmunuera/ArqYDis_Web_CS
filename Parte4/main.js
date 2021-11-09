
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

var cafeM1 = false;
var cafeM2 = false;
var cafeM3 = false;
var cafeM4 = false;
var cafeM5 = false;

var copaM1 = false;
var copaM2 = false;
var copaM3 = false;
var copaM4 = false;
var copaM5 = false;


//-------------- VARIABLES ------------------------------------------------------------------------------^^

//-------------- FUNCIONES ------------------------------------------------------------------------------

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

function CalcularPrecio(datosPedidos) {
    var parar;
    var contador;
    var precio = 0;

    datosPedidos.forEach(plato => {
        parar = false;
        contador = 0

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
        }
        if (parar == false) {
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
    if ($('#cbox1').is(':checked')) {
        precio += 1;
    }
    if ($('#cbox2').is(':checked')) {
        precio += 5;
    }
    return precio;
}

function funcionMesa() {
    if (document.getElementById("slct1").value == "Mesa1") {
        return "Mesa1";
    } else if (document.getElementById("slct1").value == "Mesa2") {
        return "Mesa2";
    } else if (document.getElementById("slct1").value == "Mesa3") {
        return "Mesa3";
    } else if (document.getElementById("slct1").value == "Mesa4") {
        return "Mesa4";
    } else return "Mesa5";
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


//jquery para mostrar los platos pedidos de cada mesa cuando se vuelve a dicha mesa
$("#slct1").on("change", function () {
    $("#CajaPlatosPedidos").empty();
    if (this.value == "Mesa1") {
        platosPedidosM1.forEach(element => {
            $("#CajaPlatosPedidos").prepend($('<option />', {
                text: element,
                value: element,
            }));
        });
        if (cafeM1) {
            $("#cbox1").prop("checked", true);
        }else{
            $("#cbox1").prop("checked", false);
        }
        if (copaM1) {
            $("#cbox2").prop("checked", true);
        }else{
            $("#cbox2").prop("checked", false);
        }
    } else if (this.value == "Mesa2") {
        platosPedidosM2.forEach(element => {
            $("#CajaPlatosPedidos").prepend($('<option />', {
                text: element,
                value: element,
            }));
        });
        if (cafeM2) {
            $("#cbox1").prop("checked", true);
        }else{
            $("#cbox1").prop("checked", false);
        }
        if (copaM2) {
            $("#cbox2").prop("checked", true);
        }else{
            $("#cbox2").prop("checked", false);
        }
    } else if (this.value == "Mesa3") {
        platosPedidosM3.forEach(element => {
            $("#CajaPlatosPedidos").prepend($('<option />', {
                text: element,
                value: element,
            }));
        });
        if (cafeM3) {
            $("#cbox1").prop("checked", true);
        }else{
            $("#cbox1").prop("checked", false);
        }
        if (copaM3) {
            $("#cbox2").prop("checked", true);
        }else{
            $("#cbox2").prop("checked", false);
        }
    } else if (this.value == "Mesa4") {
        platosPedidosM4.forEach(element => {
            $("#CajaPlatosPedidos").prepend($('<option />', {
                text: element,
                value: element,
            }));
        });
        if (cafeM4) {
            $("#cbox1").prop("checked", true);
        }else{
            $("#cbox1").prop("checked", false);
        }
        if (copaM4) {
            $("#cbox2").prop("checked", true);
        }else{
            $("#cbox2").prop("checked", false);
        }
    } else {
        platosPedidosM5.forEach(element => {
            $("#CajaPlatosPedidos").prepend($('<option />', {
                text: element,
                value: element,
            }));
        });
        if (cafeM5) {
            $("#cbox1").prop("checked", true);
        }else{
            $("#cbox1").prop("checked", false);
        }
        if (copaM5) {
            $("#cbox2").prop("checked", true);
        }else{
            $("#cbox2").prop("checked", false);
        }
    }

});


//Logica de almacenar los platos elegidos


$("#CajaMenu").dblclick(function () {
    var plato = $(this).val();
    if (funcionMesa() == "Mesa1") {
        platosPedidosM1.push(plato);
    } else if (funcionMesa() == "Mesa2") {
        platosPedidosM2.push(plato);
    } else if (funcionMesa() == "Mesa3") {
        platosPedidosM3.push(plato);
    } else if (funcionMesa() == "Mesa4") {
        platosPedidosM4.push(plato);
    } else {
        platosPedidosM5.push(plato);
    }
    $("#CajaPlatosPedidos").prepend($('<option />', {
        text: plato,
        value: plato,
    }));
    actualizarPrecio(plato);
});

$("#cbox1").on('click', function () {
    var cafe = false;
    if ($('#cbox1').is(':checked')) {
        cafe = true;
        if (funcionMesa() == "Mesa1") {
            cafeM1 = cafe;
        } else if (funcionMesa() == "Mesa2") {
            cafeM2 = cafe;
        } else if (funcionMesa() == "Mesa3") {
            cafeM3 = cafe;
        } else if (funcionMesa() == "Mesa4") {
            cafeM4 = cafe;
        } else {
            cafeM5 = cafe;
        }
    } else if (funcionMesa() == "Mesa1") {
        cafeM1 = cafe;
    } else if (funcionMesa() == "Mesa2") {
        cafeM2 = cafe;
    } else if (funcionMesa() == "Mesa3") {
        cafeM3 = cafe;
    } else if (funcionMesa() == "Mesa4") {
        cafeM4 = cafe;
    } else {
        cafeM5 = cafe;
    }
});
$("#cbox2").on('click', function () {
    var copa = false;
    if ($('#cbox2').is(':checked')) {
        if (funcionMesa() == "Mesa1") {
            copaM1 = copa;
        } else if (funcionMesa() == "Mesa2") {
            copaM2 = copa;
        } else if (funcionMesa() == "Mesa3") {
            copaM3 = copa;
        } else if (funcionMesa() == "Mesa4") {
            copaM4 = copa;
        } else {
            copaM5 = copa;
        }
    } else if (funcionMesa() == "Mesa1") {
        copaM1 = copa;
    } else if (funcionMesa() == "Mesa2") {
        copaM2 = copa;
    } else if (funcionMesa() == "Mesa3") {
        copaM3 = copa;
    } else if (funcionMesa() == "Mesa4") {
        copaM4 = copa;
    } else {
        copaM5 = copa;
    }
});


//-------------- CODIGO PROGRAMA -------------- ESTO ES LO QUE SE VA A EJECUTAR 

inicializarArrayPlatos(platosPricipales);






$("#botonPagar").on('click', function () {
    if (funcionMesa() == "Mesa1") {
        document.getElementById("cajaPrecio").value = CalcularPrecio(platosPedidosM1) + "€";
        platosPedidosM1 = [];
        $("#cbox1").prop("checked", false);
        $("#CajaPlatosPedidos").empty();
        $("#cbox2").prop("checked", false);
    } else if (funcionMesa() == "Mesa2") {
        document.getElementById("cajaPrecio").value = CalcularPrecio(platosPedidosM2) + "€";
        platosPedidosM2 = [];
        $("#cbox1").prop("checked", false);
        $("#CajaPlatosPedidos").empty();
        $("#cbox2").prop("checked", false);
    } else if (funcionMesa() == "Mesa3") {
        document.getElementById("cajaPrecio").value = CalcularPrecio(platosPedidosM3) + "€";
        platosPedidosM3 = [];
        $("#cbox1").prop("checked", false);
        $("#CajaPlatosPedidos").empty();
        $("#cbox2").prop("checked", false);
    } else if (funcionMesa() == "Mesa4") {
        document.getElementById("cajaPrecio").value = CalcularPrecio(platosPedidosM4) + "€";
        platosPedidosM4 = [];
        $("#CajaPlatosPedidos").empty();
        $("#cbox1").prop("checked", false);
        $("#cbox2").prop("checked", false);
    } else {
        document.getElementById("cajaPrecio").value = CalcularPrecio(platosPedidosM5) + "€";
        platosPedidosM5 = [];
        $("#CajaPlatosPedidos").empty();
        $("#cbox1").prop("checked", false);
        $("#cbox2").prop("checked", false);
    }
});

//-------------- CODIGO PROGRAMA -------------- ESTO ES LO QUE SE VA  A EJECUTAR ^^