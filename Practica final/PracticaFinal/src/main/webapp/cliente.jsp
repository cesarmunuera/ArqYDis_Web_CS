<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
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

        <%@ page import="java.io.IOException"%>
        <%@ page contentType="text/html" pageEncoding="UTF-8"%>
        <%@ page import="java.sql.*"%>
        <%@page import="java.util.regex.Pattern"%>
        <%@page import="java.text.DateFormat"%>


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
            double precioFinal, precio = 0;
            DecimalFormat df = new DecimalFormat("#.00");

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
                        <input type="date" id="fechas" name="fechas">
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

            <div class="inicio">
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

            /*
            public java.util.Date convertirFecha(String fecha) throws ParseException {
                DateFormat dateFormat = new SimpleDateFormat ("yyyy-MM-dd");
                java.util.Date fechaBuena = dateFormat.parse(fecha);
                return fechaBuena;
            }*/
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
                //System.out.println("SELECT CAPACIDAD FROM VUELOS WHERE ORIGEN = '" + origen + "' AND DESTINO = '" + destino + "' AND FECHA = '" + fecha + "'");

                //Logica de funcionamiento
                while (rsCapacidad.next()) {
                    capacidad = Integer.parseInt(rsCapacidad.getString("CAPACIDAD"));
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
                        session.setAttribute("Precio", df.format(precioFinal));
                        session.setAttribute("Origen", origen);
                        session.setAttribute("Destino", destino);
                        session.setAttribute("Fecha", fecha);
                        session.setAttribute("IdaVuelta", idaVuelta);
                        session.setAttribute("NumeroViajeros", numViajeros);

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

        <input type="text" value="<%= df.format(precioFinal)%>" readonly onmousedown="return false;" class="botonPagar"/>

        <br>
        <br>

        <a href="pago.jsp" class="botonPagar" type="reset"><button>Ir al carro</button></a>

    </body>

</html>