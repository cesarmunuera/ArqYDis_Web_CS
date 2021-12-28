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
            public void abrirConexion() {
        String sURL = "jdbc:odbc:mvc";
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");
            System.out.println("Se ha conectado----------------------------------------------------------------------------------------------------------------------------------------");
        } catch (Exception e) {
            System.out.println("No se ha conectado");
        }
    }
        
public boolean existeUsuario(String user) {
        boolean existe = false;
        String cad;
        try {
            System.out.println("------------------CONTROL1----------");
            set = con.createStatement();
            System.out.println("------------------CONTROL2----------");
            rs = set.executeQuery("SELECT * FROM USUARIOS");
            while (rs.next()) {
                cad = rs.getString("NOMBRE");
                System.out.println("------------------"+cad);
                cad = cad.trim();
                if (cad.compareTo(user.trim()) == 0) {
                    existe = true;
                }
            }
            rs.close();
            set.close();
        } catch (Exception e) {
            System.out.println("No lee de la tabla");
            System.out.println(e);
        }
        return (existe);
    }
public boolean comprobarPassword(String user, String password) {
        boolean correcta = false;
        String cad;
        try {
            set = con.createStatement();
            rs = set.executeQuery("SELECT PASSWORD FROM USUARIOS WHERE USUARIO='" + user + "'");
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
            System.out.println("No lee de la tabla");
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
            System.out.println("No lee de la tabla");
        }
        return (cad);
    }

    public void cerrarConexion() {
        try {
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
             
            public void iniciar(ServletConfig cfg) throws ServletException {
                try {
                    abrirConexion();
                } catch (Exception e) {
                    System.out.println(e);
                }
            }

        private Connection con;
    private Statement set;
    private ResultSet rs;
        %>

        <%
            String user = (String) request.getParameter("user");
            String password = (String) request.getParameter("password");
            System.out.println(user);
            System.out.println(password);
            
            if (existeUsuario(user)) {
                    if (comprobarPassword(user, password)) {
                        if (tipoUsuario(user)) {
                            //El usuario existe y su contraseña es correcta, es un administrador
                            response.sendRedirect(response.encodeRedirectURL("/PracticaFinal/admin.html"));
                        } else {
                            //El usuario existe y su contraseña es correcta, es un cliente
                            response.sendRedirect(response.encodeRedirectURL("/PracticaFinal/cliente.html"));
                        }
                    } else {
                        System.out.println("La contraseña introducida es incorrecta");
                    }
                } else {
                    System.out.println("El usuario no existe");
                }
            
        %>
        


    </body>

</html>
