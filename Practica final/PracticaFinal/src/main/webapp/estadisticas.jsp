<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>

<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Panel de estad&iacute;sticas</title>
        <link rel="stylesheet" href="estilo.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>
        <h1>Panel de estad&iacute;sticas</h1>


        <%!
            Connection con;
            Statement setID, setViajeros, setPrecio, setNombre;
            ResultSet rsID, rsViajeros, rsPrecio, rsNombre;
            int contadorViajeros, gananciaTotal;
            ArrayList alViajeros = new ArrayList();
            ArrayList alGanancias = new ArrayList();
            ArrayList alNombres = new ArrayList();
        %>

        <%
            //Creamos la conexion con la base de datos, esto es el driver
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");
            setID = con.createStatement();
            rsID = setID.executeQuery("SELECT DISTINCT ID_VUELO FROM ESTADISTICAS");

            //Vaciamos los arrays para evitar datos duplicados por pantalla
            alViajeros.clear();
            alGanancias.clear();
            gananciaTotal = 0;

            while (rsID.next()) {
                contadorViajeros = 0;
                setViajeros = con.createStatement();
                rsViajeros = setViajeros.executeQuery("SELECT NUM_PERSONAS FROM ESTADISTICAS WHERE ID_VUELO = '" + rsID.getString("ID_VUELO") + "'");
                //Calculamos las personas por vuelo
                while (rsViajeros.next()) {
                    contadorViajeros += Integer.parseInt(rsViajeros.getString("NUM_PERSONAS"));
                }
                alViajeros.add("El vuelo con ID " + rsID.getString("ID_VUELO") + " tiene " + contadorViajeros + " persona(s).");

                //Calculamos las ganancias por vuelo
                setPrecio = con.createStatement();
                rsPrecio = setPrecio.executeQuery("SELECT PRECIO FROM VUELOS WHERE ID ='" + rsID.getString("ID_VUELO") + "'");
                while (rsPrecio.next()) {
                    alGanancias.add("El vuelo con ID " + rsID.getString("ID_VUELO") + " tiene unas ganacias de " + (contadorViajeros * Double.parseDouble(rsPrecio.getString("PRECIO"))) + " €.");
                    gananciaTotal += (Double.parseDouble(rsPrecio.getString("PRECIO")) * contadorViajeros);
                }

                //Obtenemos los usuarios por vuelo
                setNombre = con.createStatement();
                rsNombre = setNombre.executeQuery("SELECT DISTINCT NOMBRE_CLIENTE FROM ESTADISTICAS WHERE ID_VUELO ='" + rsID.getString("ID_VUELO") + "'");
                while (rsNombre.next()) {
                    alNombres.add("El vuelo con ID " + rsID.getString("ID_VUELO") + " tiene al usuario " + rsNombre.getString("NOMBRE_CLIENTE") + " .");
                }

            }

            setID.close();
            setViajeros.close();
            setPrecio.close();
            setNombre.close();
            rsID.close();
            rsNombre.close();
            rsViajeros.close();
            rsPrecio.close();

            for (int i = 0; i < alViajeros.size(); i++) {
        %>

        <br>
        <br>
        <%=alViajeros.get(i)%>  

        <%
            }
        %>
        <br>
        <br>
        <br>
        <br>
        <%
            for (int i = 0; i < alGanancias.size(); i++) {
        %>

        <br>
        <br>
        <%=alGanancias.get(i)%>  

        <%
            }
        %>
        <br>
        <br>
        <br>
        <br>
        <%="La ganancia total es de " + gananciaTotal + " €."%>  
        <br>
        <br>
        <%
            for (int i = 0; i < alNombres.size(); i++) {
        %>

        <br>
        <br>
        <%=alNombres.get(i)%>  

        <%
            }
        %>

    </body>
</html>
