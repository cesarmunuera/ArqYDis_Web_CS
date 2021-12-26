<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <title>C&aacute;lculo del KERS</title>
    <h1>
        <center>C&aacute;lculo del KERS</center>
    </h1>

</head>

<body>

    <%
        String nombreCoche = (String) session.getAttribute("nombreCoche");
        String nombreCircuito = (String) session.getAttribute("nombreCircuito");
    %>

    <label>Para el veh&iacute;culo <%=nombreCoche%>, y el circuito <%=nombreCircuito%>, el KERS calculado es: </label>

    <%@ page import="java.sql.*" %>
    <%!
        Connection c;
        Statement sCoches;
        Statement sCircuitos;
        ResultSet rsCoches;
        ResultSet rsCircuitos;
        float ganancia;
        int num_vueltas, num_curvas;
    %>
    <%
        c = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

        sCircuitos = c.createStatement();
        sCoches = c.createStatement();

        rsCoches = sCoches.executeQuery("SELECT GANANCIA FROM COCHES WHERE NOMBRE='" + nombreCoche + "'");
        rsCircuitos = sCircuitos.executeQuery("SELECT NUMERO_VUELTAS, NUMERO_CURVAS FROM CIRCUITOS WHERE NOMBRE='" + nombreCircuito + "'");

    %>

    <%while (rsCoches.next()) {%>
    Ganancia:
    <%= ganancia = Float.parseFloat(rsCoches.getString(1))%>
    <%}%>

    <%while (rsCircuitos.next()) {%>
    * Numero de vueltas: 
    <%=num_vueltas = Integer.parseInt(rsCircuitos.getString(1))%>
    * Numero de curvas: 
    <%=num_curvas = Integer.parseInt(rsCircuitos.getString(2))%>
    <%}%>
    = 
    <input type="text" id="cajaPrecio" value="<%=ganancia * num_vueltas * num_curvas%>" readonly onmousedown="return false;" />


    <a href="index.html" class="boton"><button>Volver a inicio</button></a>

</body>
</html>
