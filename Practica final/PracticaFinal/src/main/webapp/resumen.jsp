<%@page import="java.security.SecureRandom"%>
<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>


<html lang="es" manifest="mimanifest.manifest">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inicio</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>
        <h1>Resumen de la compra</h1>
        <%!
            Connection con;
            Statement set, set2;

            String idVuelo, localizador = generarLocalizador();

            private String generarLocalizador() {
                String s = "";
                int valor;

                for (int i = 0; i < 3; i++) {
                    Random random = new Random();
                    char letraRandom = (char) (random.nextInt(26) + 'a');
                    s = s + String.valueOf(letraRandom).toUpperCase();
                }

                for (int i = 0; i < 3; i++) {
                    valor = (int) Math.floor(Math.random() * 9);
                    s = s + valor;
                }

                return s;
            }
        %>



        Su localizador es : <%=localizador%>
        <br>
        <br>
        El numero de billetes es: <%=session.getAttribute("NumeroViajeros")%>, 
        con origen <%=session.getAttribute("Origen")%> y destino
        <%=session.getAttribute("Destino")%>,
        con fecha <%=session.getAttribute("Fecha")%>.
        <br>
        <br>
        PRECIO TOTAL: <%=session.getAttribute("Precio")%>

        <%
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");
            set2 = con.createStatement();
            set = con.createStatement();
            rs = set2.executeQuery("SELECT ID FROM VUELOS WHERE ORIGEN = '" + session.getAttribute("Origen") + "' AND DESTINO = '" + session.getAttribute("Destino") + "' AND FECHA = '" + session.getAttribute("Fecha") + "'");

            while (rs.next()) {
                idVuelo = rs.getString("ID");
            }

            set.executeUpdate("INSERT INTO ESTADISTICAS VALUES ('" + session.getAttribute("Nombre").toString() + "', " + Integer.parseInt(session.getAttribute("NumeroViajeros").toString()) + ", '" + localizador + "', '" + idVuelo + "')");
        %>

    </body>
</html>