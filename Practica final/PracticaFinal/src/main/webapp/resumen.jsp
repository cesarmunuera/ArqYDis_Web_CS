<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>

<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Resumen de la compra</title>
        <link rel="stylesheet" href="estilo.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>
        <h1>Resumen de la compra</h1>
        <%! 
            public String generarLocalizador(){
                String CHAR_LOWER = "abcdefghijklmnopqrstuvwxyz";
                String CHAR_UPPER = CHAR_LOWER.toUpperCase();
                String NUMBER = "0123456789";

                String DATA_FOR_RANDOM_STRING = CHAR_UPPER + NUMBER;
                SecureRandom random = new SecureRandom();
                StringBuilder sb = new StringBuilder(6);
                for (int i = 0; i < 6; i++) {
                    int rndCharAt = random.nextInt(DATA_FOR_RANDOM_STRING.length());
                    char rndChar = DATA_FOR_RANDOM_STRING.charAt(rndCharAt);
                    sb.append(rndChar);
                }
                return sb.toString();
            }
        %>
        Su localizador es : <%=generarLocalizador())%>
        El numero de billetes es: <%=session.getAttribute("NumeroViajeros")%>, 
        con origen <%=session.getAttribute("Origen")%> y destino
        <%=session.getAttribute("Destino")%>,
        con fecha <%=session.getAttribute("Fecha")%>.
        <br>
        PRECIO TOTAL: <%=session.getAttribute("Precio")%>
    </body>
</html>
