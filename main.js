
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
let preciosPlatosPricipales = [3, 4, 3, 4];
let platosSegudos = ["Ternera", "Pescado", "Pollo", "Lomo"];
let preciosPlatosSegudos = [4, 4, 3, 3];
let platosPostres = ["Manzana", "Helado", "Yogur", "Tarta"];
let preciosPlatosPostres = [2, 3, 2, 3];

inicializarArrayPlatos(platosPricipales);
//Hasta aqui


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
//Hasta aqui


//Logica de almacenar los platos elegidos
let mesa1;
let mesa2;
let mesa3;
let mesa4;
let mesa5;
var valor;

$("#CajaMenu").on('change', function () {
    var plato = $(this).val();
    //Esta variable debe ser uno de los arrays anteriores
    //Falta la logica de cambiar el array cuando se cambia la mesa
    $("#CajaPlatosPedidos").prepend($('<option />', {
        text: plato,
        value: plato,
    }));
});
//Hasta aqui


//Loica de poner los precios
var parar = false;
var contador = 0;
var precio = 0;

platosPricipales.forEach(element => {
    contador ++; 
    if(plato == element){
        parar = true;
        precio += preciosPlatosPricipales[contador];
    }
});

contador = 0;
if (parar == false){
    platosSegudos.forEach(element => {
        contador ++; 
        if(plato == element){
            parar = true;
            precio += preciosPlatosSegudos[contador];
        }
    });
}else if (parar == false){
    contador = 0;
    platosPostres.forEach(element => {
        contador ++; 
        if(plato == element){
            parar = true;
            precio += preciosPlatosPostres[contador];
        }
    });
}

document.getElementById("cajaPrecio").value = "My value";
//Nose pq no va esta mierda

//Hasta aqui