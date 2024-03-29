<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.text.DateFormat"%>
<!DOCTYPE html>

<% try {
        if (session.getAttribute("tipoUsuario").toString().compareTo("cliente") != 0) {
            session.invalidate();
            response.sendRedirect(response.encodeRedirectURL("index.jsp"));
        }
    } catch (Exception e) {
        response.sendRedirect(response.encodeRedirectURL("index.jsp"));
    }
%>

<html lang="es" manifest="mimanifest.manifest">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Compra de billetes</title>
        <link rel="stylesheet" href="estilo.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>

    <body>
        <h1>
            <center>Compra de billetes</center>
        </h1>

        <%!
            Connection c;
            Statement sOrigen;
            Statement sDestino;
            Statement sCapacidad;
            Statement sPrecio;
            ResultSet rsOrigen;
            ResultSet rsDestino;
            ResultSet rsCapacidad;
            ResultSet rsPrecio;
            int i = 1, precioTasas = 5, capacidad = 0;
            double precioFinal = 0, precio = 0, roundDbl;
            String ppp = "0";
        %>
        
        <%
            c = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");
            sOrigen = c.createStatement();
            sDestino = c.createStatement();
            sCapacidad = c.createStatement();
            sPrecio = c.createStatement();
            rsOrigen = sOrigen.executeQuery("SELECT DISTINCT ORIGEN FROM VUELOS");
            rsDestino = sDestino.executeQuery("SELECT DISTINCT DESTINO FROM VUELOS");
        %>
        
        <br>
        <br>

        <form action="" method="POST">
            <table>
                <tr class="espacioColumnas">
                    <td class="espacioColumnas1">
                        <label>Origen</label>
                        <br>
                        <br>
                        <select name="origen">
                            <% while (rsOrigen.next()) {%>
                            <option value="<%= rsOrigen.getString(1)%>" name="nombreOrigen">
                                <%= rsOrigen.getString(1)%>
                            </option>
                            <% }%>
                        </select>
                    </td>

                    <td class="espacioColumnas2">
                        <label>Destino</label>
                        <br>
                        <br>
                        <select name="destino">
                            <% while (rsDestino.next()) {%>
                            <option value="<%= rsDestino.getString(1)%>" name="nombreDestino">
                                <%= rsDestino.getString(1)%>
                            </option>
                            <% }%>
                        </select>
                    </td>

                    <td class="espacioColumnas3">
                        <label>Fecha</label>
                        <br>
                        <br>
                        <input type="date" id="fechas" name="fechas" value="2022-01-02" min="2021-01-01" max="2023-12-31">
                        <br>
                        <br>
                    </td>

                    <td class="espacioColumnas4">
                        <label>Ida y vuelta</label>
                        <br>
                        <br>
                        <label>Si</label>
                        <input type="checkbox" id="idavuelta" name="idaVuelta" value="algo">
                    </td>

                    <td class="espacioColumnas5">
                        <label>Numero de viajeros</label>
                        <br>
                        <br>
                        <select name="num_viajeros">
                            <option value="1" name="option_viajeros">1</option>
                            <option value="2" name="option_viajeros">2</option>
                            <option value="3" name="option_viajeros">3</option>
                            <option value="4" name="option_viajeros">4</option>
                            <option value="5" name="option_viajeros">5</option>
                            <option value="6" name="option_viajeros">6</option>
                            <option value="7" name="option_viajeros">7</option>
                            <option value="8" name="option_viajeros">8</option>
                            <option value="9" name="option_viajeros">9</option>
                            <option value="10" name="option_viajeros">10</option>
                        </select>
                    </td>
                </tr>

            </table>

            <br>

            <div class="calcularPrecio">
                <input type="submit" value="Calcular Precio" name="botonCalcularPrecio">

            </div>
        </form>
        <br>
        <br>
        <br>

        <%!
            Connection con;
            Statement set;
            ResultSet rs;

            public boolean comprobarIdaVuelta(String r) {
                boolean reg = true;
                if (r == null) {
                    reg = false;
                }
                return reg;
            }
        %>

        <%
            //Creamos la conexion con la base de datos, esto es el driver
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");
            String pagar = request.getParameter("botonCalcularPrecio");
            //Obtenemos parametros del submit del html
            if (pagar != null) {
                
                System.out.println("Entrando en modo calcular precio");
                String origen = request.getParameter("origen");
                String destino = request.getParameter("destino");
                String fecha = request.getParameter("fechas");
                String idaVuelta = (String) request.getParameter("idaVuelta");
                int numViajeros = Integer.parseInt(request.getParameter("num_viajeros"));
                
                rsCapacidad = sCapacidad.executeQuery("SELECT CAPACIDAD FROM VUELOS WHERE ORIGEN = '" + origen + "' AND DESTINO = '" + destino + "' AND FECHA = '" + fecha + "'");

                //Logica de funcionamiento
                while (rsCapacidad.next()) {
                    capacidad = Integer.parseInt(rsCapacidad.getString("CAPACIDAD"));
                    System.out.println("La capacidad es: " + capacidad);
                    // TODO: ARREGLAR EL AVISO SI LOS DATOS INTRODUCIDOS NO SON CORRECTOS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                }
                System.out.println("La capacidad es: " + capacidad);
                
                if (capacidad > 0) {
                    if (numViajeros <= capacidad) {
                        rsPrecio = sPrecio.executeQuery("SELECT PRECIO FROM VUELOS WHERE ORIGEN = '" + origen + "' AND DESTINO = '" + destino + "' AND FECHA = '" + fecha + "'");
                        while (rsPrecio.next()) {
                            precio = Double.parseDouble(rsPrecio.getString("PRECIO"));
                        }
                        System.out.println("El precio es: " + precio);
                        precioFinal = ((precio * 1.21) + precioTasas) * numViajeros;
                        if (idaVuelta != null) {
                            precioFinal = precioFinal * 1.5; //la vuelta sale a la mitad del precio
                        }
                        
                        //Guardamos en sesion los datos de la compra realizada
                        roundDbl = Math.round(precioFinal * 100.0) / 100.0;
                        session.setAttribute("Precio", roundDbl + "");
                        session.setAttribute("Origen", origen);
                        session.setAttribute("Destino", destino);
                        session.setAttribute("Fecha", fecha);
                        session.setAttribute("IdaVuelta", idaVuelta);
                        session.setAttribute("NumeroViajeros", numViajeros);
                        session.setAttribute("CapacidadVuelo", capacidad);

                    } else {
                        System.out.println("El numero de plazas solicitadas es mayor a las disponibles");
                    }
                } else {
                    System.out.println("Los datos seleccionados no son correctos");
                }
            } else {
                System.out.println("Modo null de pagar ...");
            }
        %>

        <input type="text" value="<%= roundDbl + " €"%>" readonly onmousedown="return false;" class="botonPagar"/>
        <br>
        <br>
        <a href="pago.jsp" class="botonPagar" type="reset"><button>Ir al carro</button></a>
    </body>
</html>