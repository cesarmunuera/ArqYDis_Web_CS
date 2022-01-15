<%@page import="java.security.SecureRandom"%>
<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<% try {
        if (session.getAttribute("tipoUsuario").toString().compareTo("cliente") != 0) {
            System.out.println("Estamos en el try, el usuario es: " + session.getAttribute("tipoUsuario").toString());
            session.invalidate();
            response.sendRedirect(response.encodeRedirectURL("index.jsp"));
        }
    } catch (Exception e) {
        System.out.println("Estamos en el catch, el usuario es: " + session.getAttribute("tipoUsuario").toString());
        response.sendRedirect(response.encodeRedirectURL("index.jsp"));
    }
%>

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
            ResultSet rs, rs2;

            String idVuelo, localizador = generarLocalizador();

            private String generarLocalizador() {
                String s = "";
                int valor;
                boolean existe = true;

                while (existe) {
                    for (int i = 0; i < 3; i++) {
                        Random random = new Random();
                        char letraRandom = (char) (random.nextInt(26) + 'a');
                        s = s + String.valueOf(letraRandom).toUpperCase();
                    }

                    for (int i = 0; i < 3; i++) {
                        valor = (int) Math.floor(Math.random() * 9);
                        s = s + valor;
                    }

                    try {
                        con = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");
                        set2 = con.createStatement();

                        rs2 = set2.executeQuery("SELECT LOCALIZADOR FROM ESTADISTICAS");
                        while (rs2.next()) {
                            System.out.println("El localizador es: " + rs2.getString("LOCALIZADOR").toString());
                            if (rs2.getString("LOCALIZADOR").equals(s)) {
                                existe = true;
                                break;
                            } else {
                                existe = false;
                            }
                        }
                        rs2.close();
                        set2.close();
                    } catch (Exception e) {
                        System.out.println("No se ha podido actualizar el viaje");
                        System.out.println(e);
                    }
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
            set = con.createStatement();

            idVuelo = (String) session.getAttribute("idVuelo");

            set.executeUpdate("INSERT INTO ESTADISTICAS VALUES ('" + session.getAttribute("Nombre").toString() + "', " + Integer.parseInt(session.getAttribute("NumeroViajeros").toString()) + ", '" + localizador + "', '" + idVuelo + "')");
        %>

        <br>
        <br>

        <%
            session.invalidate();
        %>

        <a href="index.jsp">Volver a inicio</a>

    </body>
</html>