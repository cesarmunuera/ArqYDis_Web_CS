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
            ResultSet rsOrigen;
            ResultSet rsDestino;
            int i = 1;
        %>
        <%
            c = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

            sOrigen = c.createStatement();
            sDestino = c.createStatement();

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
                            <% while (i < 11) {%>
                            <option value="<%= i%>" name="option_viajeros">
                                <%= i%>
                            </option>
                            <%
                                    i++;
                                }%>
                        </select>
                    </td>
                </tr>

            </table>

            <br>
            <br>
            <br>

            <div class="inicio">
                <input type="submit" id="calcularPrecio" value="Calcular Precio">
                <input type="text" id="cajaPrecio" value="" readonly onmousedown="return false;" />
            </div>
        </form>

        <br>
        <br>
        <br>

        <a href="pagar.jsp" class="botonPagar"><button>Pagar</button></a>

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

            public boolean comprobarIdaVuelta(String r){
                boolean reg = true;
                if(r == null){
                    reg = false;
                }
                return reg;
            }

        %>


        <%
            //Creamos la conexion con la base de datos, esto es el driver
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

            //Obtenemos parametros del submit del html
            String origen = request.getParameter("nombreOrigen");
            String destino = request.getParameter("nombreDestino");
            String fecha = request.getParameter("fechas");
            System.out.println(fecha);
            //System.out.println(convertirFecha(fecha).toString());
            
            String idaVuelta = (String) request.getParameter("idaVuelta");
            if (comprobarIdaVuelta(idaVuelta)) {
                System.out.println("SI ida y vuelta");
            } else {
                System.out.println("NO ida y vuelta");
            }
            
            String numViajeros = request.getParameter("num_viajeros");
            System.out.println(numViajeros + " viajeros.");

        %>
    </body>


</html>