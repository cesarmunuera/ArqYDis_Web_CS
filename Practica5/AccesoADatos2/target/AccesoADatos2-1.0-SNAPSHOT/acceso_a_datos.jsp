<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- jsp0501.jsp

-->
<html>
    <head> <title> Acceso a datos 2 </title> </head>
    <body>

        <!-- Esto de aqui sirve para capturar el post generado por el index.html-->
        <%
            String val = request.getParameter("NOMBRE");
            if (val != null) {
                session.setAttribute("NOMBRE", val);
            }
        %>

        <center> Los alumnos de <%=session.getAttribute("NOMBRE")%> son: </center>
        <%
            String Nombre = (String) session.getAttribute("NOMBRE");
        %>
        

        <%@ page import="java.sql.*" %>
        <%!
            Connection c;
            Statement s;
            ResultSet rs;
            ResultSetMetaData rsmd;
        %>
        <%
            c = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");
            s = c.createStatement();
            rs = s.executeQuery("SELECT NOMBRE_ALUMNO, APELLIDO_ALUMNO FROM ((APP.PROFESOR INNER JOIN APP.ASIGNATURA ON DNI_PROFESOR=DNI_PROFESOR_ASIGNATURA) INNER JOIN APP.ALUMNO ON ASIGNATURA=ASIGNATURA_IMPARTIDA) WHERE NOMBRE_PROFESOR='" + Nombre +"'");
            rsmd = rs.getMetaData();
        %>
        <table width="100%" border="1">
            <tr>
                <% for (int i = 1; i <= rsmd.getColumnCount(); i++) {%>
                <th><%= rsmd.getColumnLabel(i)%></th>
                    <% } %>
            </tr>
            <% while (rs.next()) { %>
            <tr>
                <% for (int i = 1; i <= rsmd.getColumnCount(); i++) { %>
                <td><%= rs.getString(i) %></td>
                <%} %>
            </tr>
            <% }%>
        </table>

    </body>
</html>
