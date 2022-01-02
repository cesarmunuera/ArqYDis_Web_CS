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
                        <!--HAY QUE HACER LO DE LA ID Q SERA NUMERO ELEMENTOS DE LA TABLA++ -->
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
                        <input type="num" name="precio"/>
                    </td>
                </tr>
        </table>

        <br>
        <br>
        <br>
        <br>

        <input type="submit" id="Generar Vuelo" value="Generar Vuelo" class="botonesGenerarVuelo">
    </form>

    <br>
    <br>
    <br>

    <a href="estadisticas.jsp" class="botonesGenerarVuelo"><button>Mirar estadist&iacute;cas</button></a>

    <%!
        Connection con;
        Statement set;
        ResultSet rs;

        public boolean existeVuelo(String id) {
            boolean existe = false;
            String cad;
            try {
                set = con.createStatement();
                rs = set.executeQuery("SELECT * FROM USUARIOS");
                while (rs.next()) {
                    cad = rs.getString("ID");
                    System.out.println("------------------" + cad);
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
        }
    %>
    <%
        //Creamos la conexion con la base de datos, esto es el driver
        con = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

        //Obtenemos parametros del submit del html
        String origen = (String) request.getParameter("origen");
        String destino = (String) request.getParameter("origen");
        String fecha = (String) request.getParameter("origen");//esta hay q mirar q retorna la mierda esa del input
        int precio = Integer.parseInt(request.getParameter("precio"));

        System.out.println("El origen recibido es" + origen);
        System.out.println("El destino recibido es" + destino);
        //System.out.println("La fecha recibids es" + fecha);
        System.out.println("El precio recibido es" + precio);

        //Primero generamos una id aleatoria de 6 numeros (6 por ejemplo)
        //Math random, checkeo de id existente, inserccion en la bbdd

    %>





</body>

</html>
