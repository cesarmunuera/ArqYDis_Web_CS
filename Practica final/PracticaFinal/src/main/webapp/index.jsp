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
        <link rel="stylesheet" href="estilo.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>

    <body>
        <h1>
            <center>Inicio de sesi&oacute;n</center>
        </h1>

        <form action="" method="POST">
            <div class="inicio">

                <label>Usuario</label>
                <input type="text" name="user" />

                <br>
                <br>
                <br>

                <label>Contraseña</label>
                <input type="text" name="password" />

                <br>
                <br>
                <br>

                <input type="radio" name="registro" value="Registrarse">¿Registrarse?

                <br>
                <br>

                <input type="submit" id="Enviar" value="Enviar" class="botonEnviar">


            </div>
        </form>

        <%!
            Connection con;
            Statement set;
            ResultSet rs;
            String incorrecto = "";

            // ---------------------------------  METODOS DE INICIO DE SESION
            public boolean existeUsuario(String user) {
                boolean existe = false;
                String cad;
                try {
                    set = con.createStatement();
                    rs = set.executeQuery("SELECT * FROM USUARIOS");
                    while (rs.next()) {
                        cad = rs.getString("NOMBRE");
                        cad = cad.trim();
                        if (cad.compareTo(user.trim()) == 0) {
                            existe = true;
                        }
                    }
                    rs.close();
                    set.close();
                } catch (Exception e) {
                    System.out.println("No lee de la tabla existeUsuario");
                    System.out.println(e);
                }
                return (existe);
            }

            public boolean comprobarPassword(String user, String password) {
                boolean correcta = false;
                String cad;
                try {
                    set = con.createStatement();
                    rs = set.executeQuery("SELECT PASSWORD FROM USUARIOS WHERE NOMBRE='" + user + "'");
                    while (rs.next()) {
                        cad = rs.getString("PASSWORD");
                        cad = cad.trim();
                        if (cad.compareTo(password.trim()) == 0) {
                            correcta = true;
                        }
                    }
                    rs.close();
                    set.close();
                } catch (Exception e) {
                    System.out.println("No lee de la tabla comprobarPassword");
                }
                return (correcta);
            }

            public boolean tipoUsuario(String user) {
                boolean cad = false;
                try {
                    set = con.createStatement();
                    rs = set.executeQuery("SELECT TIPO FROM USUARIOS WHERE NOMBRE='" + user + "'");

                    while (rs.next()) {
                        cad = rs.getBoolean("TIPO");
                    }
                    rs.close();
                    set.close();
                } catch (Exception e) {
                    System.out.println("No lee de la tabla tipoUsuario");
                }
                return (cad);
            }

            // ---------------------------------  METODOS DE REGISTRO
            public boolean insertarUsuario(String user, String password) {
                boolean insertado = false;
                try {
                    set = con.createStatement();

                    if (existeUsuario(user)) {
                        System.out.println("El usuario ya existe perraco");
                    } else {
                        System.out.println("El usuario sera introducido a continuacion con los valores " + user + password);
                        //set.executeUpdate("INSERT INTO USUARIOS VALUES ('User3', '1234', FALSE)");
                        //El sistema solo acepta registros de CLIENTES NO DE ADMINISTRADORES, no se especifica nada en la guia, lo dejamos asi
                        set.executeUpdate("INSERT INTO USUARIOS VALUES ('" + user + "', '" + password + "', FALSE)");
                        insertado = true;
                        System.out.println("Usuario introducido correctamente");
                    }

                    rs.close();
                    set.close();
                } catch (Exception e) {
                    System.out.println("No lee de la tabla insertarUsuario");
                }

                return insertado;
            }
        %>

        <%
            //Creamos la conexion con la base de datos, esto es el driver
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

            //Obtenemos parametros del submit del html
            String user = (String) request.getParameter("user");
            String password = (String) request.getParameter("password");
            String regist = (String) request.getParameter("registro");
            System.out.println(regist);
            //La linea 157 tendria q ser == pero no entra, esta asi para poder corregir mientras insertarUsuario()
            //Claro eso jode el inicio de sesion normal... no asustarse 
            //Logica de funcionamiento
            if (regist == "Registrarse") {
                System.out.println("Entramos al modo registro");
                insertarUsuario(user, password);
            } else {
                System.out.println("Entramos en el modo inicio de sesion");
                if (existeUsuario(user)) {
                    if (comprobarPassword(user, password)) {
                        if (tipoUsuario(user)) {
                            System.out.println("El usuario existe y su contraseña es correcta, es un administrador");
                            response.sendRedirect(response.encodeRedirectURL("/PracticaFinal/admin.jsp"));
                        } else {
                            System.out.println("El usuario existe y su contraseña es correcta, es un cliente");
                            //response.sendRedirect(response.encodeRedirectURL("/PracticaFinal/cliente.jsp"));
                        }
                    } else {
                        System.out.println("La contraseña introducida es incorrecta");
                        incorrecto = "La contraseña es incorrecta";
                    }
                } else {
                    System.out.println("El usuario no existe");
                }
            }

        %>

        Esto ponedlo como querais, lo he dejado asi pq se ve q funciona
        <%=incorrecto + ""%>

    </body>

</html>