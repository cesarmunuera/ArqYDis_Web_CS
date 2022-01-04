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
            Statement sprecio;
            ResultSet rsOrigen;
            ResultSet rsDestino;
            ResultSet rsCapacidad;
            ResultSet rsPrecio;
            int i = 1, precioTasas = 5;
            float precioFinal = 0;
            
        %>
        <%
            c = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

            sOrigen = c.createStatement();
            sDestino = c.createStatement();
            sCapacidad = c.createStatement();
            sprecio = c.createStatement();

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
                <input type="submit" id="calcularPrecio" value="Calcular Precio" name="botonPagar">
                <input type="text" id="cajaPrecio" value="<%= precioFinal%>" readonly onmousedown="return false;" />
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
            String pagar = request.getParameter("botonPagar");
            //Obtenemos parametros del submit del html
            if(pagar != null){
                String origen = request.getParameter("origen");
                String destino = request.getParameter("destino");
                String fecha = request.getParameter("fechas");
                String idaVuelta = (String) request.getParameter("idaVuelta");
                int numViajeros = Integer.parseInt(request.getParameter("num_viajeros"));

                rsCapacidad = sCapacidad.executeQuery("SELECT CAPACIDAD FROM VUELOS WHERE ORIGEN = '" + origen + "' AND DESTINO = '" + destino + "' AND FECHA = '"+ fecha +"'" );
                while (rsCapacidad.next()){
                    int capacidad = Integer.parseInt(rsCapacidad.getString("CAPACIDAD"));
                }
                if(capacidad !=null){
                    rsPrecio = sPrecio.executeQuery("SELECT PRECIO FROM VUELOS WHERE ORIGEN = '" + origen + "' AND DESTINO = '" + destino + "' AND FECHA = '"+ fecha +"'" );
                    while (rsPrecio.next()) {
                        int precio = Integer.parseInt(rsPrecio.getString("PRECIO"));
                    }
                
                    precioFinal = ((precio * 1.21) + precioTasas) * numViajeros;
                    if (idaVuelta!= null) {
                        precioFinal = precioFinal * 1.5; //la vuelta sale a la mitad del precio
                    }
                    System.out.println(precioFinal);
                }
            }else System.out.println('Boton pagar no pulsado');
                    
        %>
          
    </body>


</html>