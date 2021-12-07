<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>

        <title>Base de datos</title>
    <h1>
        <center>Base de datos</center>
    </h1>

</head>

<body>
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

        rsmdCoches = rsCoches.getMetaData();
        rsmdCircuitos = rsCircuitos.getMetaData();
    %>

    <table>
        <tr class="cajasConfiguracion">
            <td>
                <h2>Configuraci&oacute;n del circuito</h2>
                <select id="CajaCircuitos" name="CajaCircuitos" multiple>
                    <% for (int i = 1; i <= rsmdCircuitos.getColumnCount(); i++) {%>
                    <option><%= rsCircuitos.getString(i)%></option>
                    <%}%>
                </select>
            </td>


            <td class="cajaTitulo">
                <h2>Configuraci&oacute;n del coche</h2>
                <select id="CajaCoches" name="CajaCoches"multiple>
                    <% for (int i = 1; i <= rsmdCoches.getColumnCount(); i++) {%>
                    <option><%= rsCoches.getString(i)%></option>
                    <%}%>
                </select>
            </td>
        </tr>
    </table>

</body>

</html>
