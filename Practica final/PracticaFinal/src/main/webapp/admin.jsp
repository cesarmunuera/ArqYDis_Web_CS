<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Random"%>

<!DOCTYPE html>
<% try {
        if (session.getAttribute("tipoUsuario").toString().compareTo("admin") != 0) {
            session.invalidate();
            response.sendRedirect(response.encodeRedirectURL("index.jsp"));
        }
    } catch (Exception e) {
        response.sendRedirect(response.encodeRedirectURL("index.jsp"));

    }

%>
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
                        <input type="date" id="fechas" name="fechas" value="2022-01-03" min="2021-01-01" max="2023-12-31">
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

        <input type="submit" name="volver" value="Volver a inicio" class="botonesGenerarVuelo">

    </form>

    <br>
    <br>
    <br>

    <a href="estadisticas.jsp" class="botonesGenerarVuelo"><button>Mirar estadist&iacute;cas</button></a>

    <%!
        Connection con;
        Statement set;
        ResultSet rs;
        int valor;
        String resultado = "";

        // Funciones auxiliares
        public boolean existeID(String id) {
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
        }

        public boolean insertarVuelo(String id, String origen, String destino, int precio, String fecha) {
            boolean insertado = false;
            try {
                if (existeID(id)) {
                    System.out.println("El vuelo ya existe");
                    insertado = false;
                } else {
                    set = con.createStatement();
                    set.executeUpdate("INSERT INTO VUELOS VALUES ('" + id + "', '" + origen.toUpperCase() + "', '" + destino.toUpperCase() + "', '" + fecha + "', 75, " + precio + ")");
                    insertado = true;               //Suponemos que los vuelos siempre parten de 75 plazas
                }
                rs.close();
                set.close();
            } catch (Exception e) {
                System.out.println("No lee de la tabla insertarUsuario");
                System.out.println(e);
            }
            return insertado;
        }
    %>
    <%        //Creamos la conexion con la base de datos, esto es el driver
        con = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

        //Comprobamos primero que el boton este marcado para evitar errores
        String regist = (String) request.getParameter("registro");

        if (regist != null) {
            //Obtenemos parametros del submit del html
            String origen = request.getParameter("origen");
            String destino = request.getParameter("destino");
            int precio = Integer.parseInt(request.getParameter("precio"));
            String fecha = request.getParameter("fechas");

            //Logica de funcionamiento
            valor = (int) Math.floor(Math.random() * 100 + 1);  //Sacamos un random para la id del vuelo
            String id = String.valueOf(valor);                  //Pasamos a String para poder comparar

            if (insertarVuelo(id, origen, destino, precio, fecha)) {
                System.out.println("Vuelo insertado correctamente");
                resultado = "Vuelo insertado correctamente";
            } else {
                System.out.println("Fallo al insertar el vuelo");
                resultado = "Fallo al insertar el vuelo";
            }
        } else {
            System.out.println("Modo null ...");
        }

        //Comprobamos primero que el boton este marcado para evitar errores
        String r = (String) request.getParameter("volver");
        if (r != null) {
            session.invalidate();
            response.sendRedirect(response.encodeRedirectURL("index.jsp"));
        }
    %>

    <%=resultado + ""%>

</body>

</html>
