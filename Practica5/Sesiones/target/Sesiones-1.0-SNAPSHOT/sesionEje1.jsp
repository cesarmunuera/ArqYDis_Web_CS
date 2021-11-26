<HTML>
    <head> 
        <title> Ejemplo de Sesion </title> 
    </head>
    <body>
        <%
            String val = request.getParameter("nombre");
        if (val != null) {
                session.setAttribute("Nombre",val);
        }
        %>
    <center> <h1>Ejemplo de Sesion</h1>
        Donde quieres ir!!!
        <a href="sesionEje1.jsp">Ir a Página 1</a>
        <a href="sesionEje2.jsp">Ir a Página 2</a>
    </body>
</HTML>