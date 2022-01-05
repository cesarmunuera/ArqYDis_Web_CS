<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>

<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pasarela de pago</title>
        <link rel="stylesheet" href="estilo.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>
        <h1 style="text-align: left;">Resumen del pedido</h1>
        <br>
        <br>
        <%!
            Connection con;
            Statement set;
            ResultSet rs;

            public boolean actualizarViajes(String user, int viajes) {
                boolean insertado = false;
                try {
                    set = con.createStatement();
                    set.executeUpdate("UPDATE USUARIOS SET VIAJES=" + viajes + " WHERE NOMBRE='" + user + "'");
                    insertado = true;
                    rs.close();
                    set.close();
                } catch (Exception e) {
                    System.out.println("No se ha podido actualizar el viaje");
                    System.out.println(e);
                }
                return insertado;
            }
        %>
        El numero de billetes es: <%=session.getAttribute("NumeroViajeros")%>, 
        con origen <%=session.getAttribute("Origen")%> y destino
        <%=session.getAttribute("Destino")%>.
        <%
            double precioFinal = Double.parseDouble(session.getAttribute("Precio").toString());
            String descuento = "";
            if (session.getAttribute("Viajes").equals(2)) {
                System.out.println("Felicidades, obtienes un descuento");
                precioFinal = precioFinal * 0.5;
                descuento = "¡Felicidades! Has obtenido un descuento al ser esta tu tercera compra. El precio final es de: " + precioFinal;
            } else {
                descuento = "El precio final es de " + precioFinal;
            }
        %>   
        <%=descuento%>

        <br>
        <br>
        <svg version="1.1" id="visa" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
             width="64px" height="64px" viewBox="0 0 47.834 47.834" style="enable-background:new 0 0 47.834 47.834;">
        <g>
        <g>
        <path d="M44.688,16.814h-3.004c-0.933,0-1.627,0.254-2.037,1.184l-5.773,13.074h4.083c0,0,0.666-1.758,0.817-2.143
              c0.447,0,4.414,0.006,4.979,0.006c0.116,0.498,0.474,2.137,0.474,2.137h3.607L44.688,16.814z M39.893,26.01
              c0.32-0.819,1.549-3.987,1.549-3.987c-0.021,0.039,0.317-0.825,0.518-1.362l0.262,1.23c0,0,0.745,3.406,0.901,4.119H39.893z
              M34.146,26.404c-0.028,2.963-2.684,4.875-6.771,4.875c-1.743-0.018-3.422-0.361-4.332-0.76l0.547-3.193l0.501,0.228
              c1.277,0.532,2.104,0.747,3.661,0.747c1.117,0,2.313-0.438,2.325-1.393c0.007-0.625-0.501-1.07-2.016-1.77
              c-1.476-0.683-3.43-1.827-3.405-3.876c0.021-2.773,2.729-4.708,6.571-4.708c1.506,0,2.713,0.31,3.483,0.599l-0.526,3.092
              l-0.351-0.165c-0.716-0.288-1.638-0.566-2.91-0.546c-1.522,0-2.228,0.634-2.228,1.227c-0.008,0.668,0.824,1.108,2.184,1.77
              C33.126,23.546,34.163,24.783,34.146,26.404z M0,16.962l0.05-0.286h6.028c0.813,0.031,1.468,0.29,1.694,1.159l1.311,6.304
              C7.795,20.842,4.691,18.099,0,16.962z M17.581,16.812l-6.123,14.239l-4.114,0.007L3.862,19.161
              c2.503,1.602,4.635,4.144,5.386,5.914l0.406,1.469l3.808-9.729L17.581,16.812L17.581,16.812z M19.153,16.8h3.89L20.61,31.066
              h-3.888L19.153,16.8z"/>
        </g>
        </g>
        </svg>
        <br>
        <label for="card-number">Número de Tarjeta</label>
        <input type="num" id="card-number" class="cajaPrecio" minlength="4" maxlength="4" required pattern="[0-9]+"/>
        <input type="num" id="card-number-1" class="cajaPrecio" minlength="4"maxlength="4" required pattern="[0-9]+"/>
        <input type="num" id="card-number-2" class="cajaPrecio" minlength="4" maxlength="4" required pattern="[0-9]+"/>
        <input type="num" id="card-number-3" class="cajaPrecio" minlength="4" maxlength="4" required pattern="[0-9]+"/>
        <br>
        <br>
        <label for="card-expiration-month">Fecha de Expiración</label>
        <select id="card-expiration-month" class="selecionableFecha">
            <option></option>
            <option>01</option>
            <option>02</option>
            <option>03</option>
            <option>04</option>
            <option>05</option>
            <option>06</option>
            <option>07</option>
            <option>08</option>
            <option>09</option>
            <option>10</option>
            <option>11</option>
            <option>12</option>
        </select>
        <select id="card-expiration-year" class="selecionableFecha">
            <option></option>
            <option>2022</option>
            <option>2023</option>
            <option>2024</option>
            <option>2025</option>
            <option>2026</option>
            <option>2027</option>
        </select>
        <br>
        <br>
        <label for="card-ccv">CCV</label>
        <input type="text" id="card-ccv" maxlength="3" minlength="3"class="cajaPrecio" required pattern="[0-9]+"/>
        <br>
        <input type="submit" value="Pagar" name="botonPagar" class="botonPagar">
        <br>
        <%
            String pagar = request.getParameter("botonPagar");
            if (pagar != null) {
                switch (Integer.parseInt(session.getAttribute("Viajes").toString())) {
                    case 0:
                        actualizarViajes(session.getAttribute("user").toString(), 1);
                    case 1:
                        actualizarViajes(session.getAttribute("user").toString(), 2);
                    case 2:
                        actualizarViajes(session.getAttribute("user").toString(), 0);
                }
                response.sendRedirect(response.encodeRedirectURL("/PracticaFinal/resumen.jsp"));
            }
        %>
    </body>

</html>
