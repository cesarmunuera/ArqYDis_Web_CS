<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

                <input type="submit" id="Enviar" value="Enviar" class="botonEnviar">

            </div>
        </form>


        <%@ page import="java.util.*"%>
        <%@ page import="java.sql.*"%>

        <%!
            Connection con, con2;
            Statement set, set2;
            ResultSet rs, rss;
            String incorrecto = "";

            public boolean existeUsuario(String user) {
                boolean existe = false;
                String cad;
                try {
                    set = con.createStatement();
                    rs = set.executeQuery("SELECT * FROM USUARIOS");
                    while (rs.next()) {
                        cad = rs.getString("NOMBRE");
                        System.out.println("------------------" + cad);
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

        %>

        <%
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");
            String user = (String) request.getParameter("user");
            String password = (String) request.getParameter("password");
            //System.out.println(user);
            //System.out.println(password);

            if (existeUsuario(user)) {
                if (comprobarPassword(user, password)) {
                    System.out.println("alrright !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    if (tipoUsuario(user)) {
                        System.out.println("alrright ES UN ADMIN");
                        //El usuario existe y su contraseña es correcta, es un administrador
                        //response.sendRedirect(response.encodeRedirectURL("/PracticaFinal/admin.html"));
                    } else {
                        System.out.println("alrright ES UN CLIENTE");
                        //El usuario existe y su contraseña es correcta, es un cliente
                        //response.sendRedirect(response.encodeRedirectURL("/PracticaFinal/cliente.jsp"));
                    }
                } else {
                    System.out.println("La contraseña introducida es incorrecta");
                    incorrecto = "La contraseña es incorrecta";
                    
                }
            } else {
                System.out.println("El usuario no existe");
            }

        %>
        
        <%=incorrecto+""%>



    </body>

</html>
