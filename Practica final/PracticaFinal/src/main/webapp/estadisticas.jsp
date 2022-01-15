<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<% try {
        if (session.getAttribute("tipoUsuario").toString().compareTo("admin") != 0) {
            System.out.println("Estamos en el try, el usuario es: " + session.getAttribute("tipoUsuario").toString());
            session.invalidate();
            response.sendRedirect(response.encodeRedirectURL("index.jsp"));
        }
    } catch (Exception e) {
        System.out.println("Estamos en el catch");
        response.sendRedirect(response.encodeRedirectURL("index.jsp"));
    }
%>
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
            Statement setID, setViajeros, setPrecio, setNombre, setVuelos;
            ResultSet rsID, rsViajeros, rsPrecio, rsNombre, rsVuelos;
            int contadorViajeros, gananciaTotal;
            ArrayList alViajeros = new ArrayList();
            ArrayList alGanancias = new ArrayList();
            ArrayList alNombres = new ArrayList();
            ArrayList alVuelos = new ArrayList();
        %>

        <%
            //Creamos la conexion con la base de datos, esto es el driver
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");
            setID = con.createStatement();
            rsID = setID.executeQuery("SELECT DISTINCT ID_VUELO FROM ESTADISTICAS");

            //Vaciamos los arrays para evitar datos duplicados por pantalla
            alViajeros.clear();
            alGanancias.clear();
            alVuelos.clear();
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

            setVuelos = con.createStatement();
            rsVuelos = setNombre.executeQuery("SELECT COUNT(ORIGEN),FECHA FROM VUELOS GROUP BY FECHA");
            while (rsVuelos.next()) {
                alVuelos.add("La cantidad de vuelos es " + rsVuelos.getString("1") + " para la fecha " + rsVuelos.getString("FECHA") + " .");
            }

            setID.close();
            setViajeros.close();
            setPrecio.close();
            setNombre.close();
            setVuelos.close();
            rsID.close();
            rsVuelos.close();
            rsNombre.close();
            rsViajeros.close();
            rsPrecio.close();

        %>

        <table>

            <td>
                <ol>
                    <%                        for (int i = 0; i < alViajeros.size(); i++) {
                    %>
                    <br>
                    <%=alViajeros.get(i)%>  

                    <%
                        }
                    %>
                </ol>
            </td>

            <td><%="     "%></td>

            <td>
                <ol>
                    <%
                        for (int i = 0; i < alGanancias.size(); i++) {
                    %>
                    <br>
                    <%=alGanancias.get(i)%>  

                    <%
                        }
                    %>
                    <br>
                    <%="La ganancia total es de " + gananciaTotal + " €."%> 
                </ol>
            </td>

            <td><%="     "%></td>

            <td>
                <ol>
                    <%
                        for (int i = 0; i < alNombres.size(); i++) {
                    %>
                    <br>
                    <%=alNombres.get(i)%>  

                    <%
                        }
                    %>
                </ol>
            </td>

            <td><%="     "%></td>

            <td>
                <ol>
                    <%
                        for (int i = 0; i < alVuelos.size(); i++) {
                    %>
                    <br>
                    <li><%=alVuelos.get(i)%></li>

                    <%
                        }
                    %>
                </ol>
            </td>

        </table>


        <%
            session.invalidate();
        %>

        <a href="index.jsp">Volver a inicio</a>

    </body>
</html>
