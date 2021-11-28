<html>
    <body>

        <!-- Esto de aqui sirve para capturar el post generado por el index.html-->
        <%
            String val = request.getParameter("nombre");
            if (val != null) {
                session.setAttribute("Nombre", val);
            }
        %>

        <title> Los alumnos de <%=session.getAttribute("Nombre")%> son; </title>

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
            rs = s.executeQuery("SELECT * FROM LIBROS");
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
                <% for (int i = 1; i <= rsmd.getColumnCount(); i++) {%>
                <td><%= rs.getString(i)%></td>
            </tr>
                <% }%>
        </table>

    </body>
</html>
