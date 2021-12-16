<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <link rel="stylesheet" type="text/css" href="estilo.css">
    </head>

    <body>
        <title>Base de datos</title>
        <h1>
            <center>Base de datos</center>
        </h1>
        <br>

        <%@ page import="java.sql.*" %>
        <%!
            Connection c;
            Statement sCoches;
            Statement sCircuitos;
            ResultSet rsCoches;
            ResultSet rsCircuitos;
            ResultSetMetaData rsmdCoches;
            ResultSetMetaData rsmdCircuitos;
        %>
        <%
            c = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

            sCircuitos = c.createStatement();
            sCoches = c.createStatement();

            rsCoches = sCoches.executeQuery("SELECT NOMBRE FROM COCHES");
            rsCircuitos = sCircuitos.executeQuery("SELECT NOMBRE FROM CIRCUITOS");
        %>

        <form action="/PL6JAVA/ServletBBDD" method="POST">
            <table>
                <tr class="cajasConfiguracion">
                    <td>
                        <h2>Configuraci&oacute;n del circuito</h2>
                        <select id="CajaCircuitos" name="CajaCircuitos" multiple>
                            <% while (rsCircuitos.next()) {%>
                            <option value="<%= rsCircuitos.getString(1)%>" name="circuito">
                                <%= rsCircuitos.getString(1)%>
                            </option>
                            <% }%>
                        </select>
                    </td>


                    <td class="cajasConfiguracion">
                        <h2>Configuraci&oacute;n del coche</h2>
                        <select id="CajaCoches" name="CajaCoches" multiple>
                            <% while (rsCoches.next()) {%>
                            <option value="<%= rsCoches.getString(1)%>" name="coche">
                                <%= rsCoches.getString(1)%>
                            </option>
                            <% }%>
                        </select>
                    </td>
                </tr>
            </table>
                        
            <br>
            <br>
            
            <input type="submit" id="botonEnviar" value="Calcular KERS" class="boton">
        </form>

    </body>

</html>
