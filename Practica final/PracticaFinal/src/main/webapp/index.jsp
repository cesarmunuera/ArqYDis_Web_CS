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


        <%!
            private ModelosDatos bd;

            public void init(ServletConfig cfg) throws ServletException {
                bd = new ModelosDatos();
                bd.abrirConexion();
            }
        %>
        <%
                String user = (String) request.getParameter("user");
                String password = (String) request.getParameter("password");

                if (bd.existeUsuario(user)) {
                    if (bd.comprobarPassword(user, password)) {
                        if (bd.tipoUsuario(user)) {
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
            }
        %>
        <%!
            public void destroy() {
                bd.cerrarConexion();
                super.destroy();
            }
        %>


    </body>

</html>
