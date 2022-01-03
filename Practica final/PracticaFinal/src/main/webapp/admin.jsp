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
        <title>Panel administrador</title>
        <link rel="stylesheet" href="estilo.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>

    <body>
        <h1>
            <center>Generador de vuelos (ADMINISTRADOR)</center>
        </h1>

        <br>
        <br>
        <br>

        <table>
            <form action="" method="POST">
                <tr class="inicioAdmin">
                    <td>    
                        <label>Origen</label>
                        <br>
                        <br>
                        <label>Destino</label>
                        <br>
                        <br>
                        <label>Fecha</label>
                        <br>
                        <br>
                        <label>Precio</label>
                    </td>
                    <td>
                        <input type="text" name="origen"/>
                        <br>
                        <br>
                        <input type="text" name="destino"/>
                        <br>
                        <br>
                        <input type="date" name="fecha">
                        <br>
                        <br>
                        <input type="text" name="precio"/>
                    </td>
                </tr>
        </table>

        <br>
        <br>
        <br>
        <br>

        <input type="submit" name="registro" id="Generar Vuelo" value="Generar Vuelo" class="botonesGenerarVuelo">
    </form>

    <br>
    <br>
    <br>

    <a href="estadisticas.jsp" class="botonesGenerarVuelo"><button>Mirar estadist&iacute;cas</button></a>

    <%!
        Connection con;
        Statement set;
        ResultSet rs;

        /*public boolean existeVuelo(String id) {
            boolean existe = false;
            String cad;
            try {
                set = con.createStatement();
                rs = set.executeQuery("SELECT * FROM VUELOS");
                while (rs.next()) {
                    cad = rs.getString("ID");
                    cad = cad.trim();
                    if (cad.compareTo(id.trim()) == 0) {
                        existe = true;
                    }
                }
                rs.close();
                set.close();
            } catch (Exception e) {
                System.out.println("No lee de la tabla existeVuelo");
                System.out.println(e);
            }
            return (existe);
        }*/
    %>
    <%
        //Creamos la conexion con la base de datos, esto es el driver
        con = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

        //Comprobamos primero que el boton este marcado para evitar errores
        String regist = (String) request.getParameter("registro");

        if (regist == null) {
            System.out.println("Modo fallo (null), ignorando ...");
        } else {
            //Obtenemos parametros del submit del html
            String origen = request.getParameter("origen");
            String destino = request.getParameter("destino");
            int precio = Integer.parseInt(request.getParameter("precio"));
            //Falta la fecha
        }

    %>





</body>

</html>
