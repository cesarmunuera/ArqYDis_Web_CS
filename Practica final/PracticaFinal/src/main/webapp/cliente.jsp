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
        <%@ page import="java.sql.*" %>
        <%!
            Connection c;
            Statement sOrigen;
            Statement sDestino;
            ResultSet rsOrigen;
            ResultSet rsDestino;
        %>
        <%
            c = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

            sOrigen = c.createStatement();
            sDestino = c.createStatement();

            rsOrigen = sOrigen.executeQuery("SELECT ORIGEN FROM VUELOS");
            rsDestino = sDestino.executeQuery("SELECT DESTINO FROM VUELOS");
        %>
        <br>
        <br>

        <table>
            <tr class="espacioColumnas">
                <td class="espacioColumnas1">
                    <label>Origen</label>

                    <br>
                    <br>

                    <select name="origen">
                        <% while (rsOrigen.next()) {%>
                        <option value="<%= rsOrigen.getString(1)%>" name="circuito">
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
                        <option value="<%= rsDestino.getString(1)%>" name="circuito">
                            <%= rsDestino.getString(1)%>
                        </option>
                        <% }%>
                    </select>
                </td>

                <td class="espacioColumnas3">
                    <label>Fecha</label>

                    <br>
                    <br>

                    <select name="fecha">
                    </select>
                </td>

                <td class="espacioColumnas4">
                    <label>Ida y vuelta</label>
                    <br>
                    <br>
                    <label>Si</label>
                    <input type="checkbox" id="idavuelta">
                </td>

                <td class="espacioColumnas5">
                    <label>Numero de viajeros</label>
                    <br>
                    <br>
                    <input type="number" name="num_viajeros" required minlength="1" min="4" max="10" />
                </td>
            </tr>

        </table>

        <br>
        <br>
        <br>

        <div class="inicio">
            <input type="button" id="calcularPrecio" value="Calcular Precio">
            <input type="text" id="cajaPrecio" value="" readonly onmousedown="return false;" />
        </div>

        <br>
        <br>
        <br>

        <a href="pagar.jsp" class="botonPagar"><button>Pagar</button></a>


    </body>

</html>