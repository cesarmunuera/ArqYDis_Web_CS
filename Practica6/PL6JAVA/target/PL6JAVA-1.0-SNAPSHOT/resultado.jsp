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
    <input type="text" id="cajaPrecio" value="" readonly onmousedown="return false;" />

    <%@ page import="java.sql.*" %>
    <%!
        Connection c;
        Statement sCoches;
        Statement sCircuitos;
        ResultSet rsCoches;
        ResultSet rsCircuitos;
    %>
    <%
        c = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

        sCircuitos = c.createStatement();
        sCoches = c.createStatement();

        rsCoches = sCoches.executeQuery("SELECT GANANCIA FROM COCHES WHERE NOMBRE='" + nombreCoche + "'");
        rsCircuitos = sCircuitos.executeQuery("SELECT NUMERO_VUELTAS, NUMERO_CURVAS FROM CIRCUITOS WHERE NOMBRE='" + nombreCircuito + "'");

        System.out.println(rsCoches.getString(1));
        System.out.println(rsCircuitos.getString(1));
        //System.out.println(rsCircuitos.getString(2));
%>

</body>
</html>
