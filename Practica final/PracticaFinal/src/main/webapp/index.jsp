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
        <link rel="stylesheet" type="text/css" href="estilo.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>

    <body>
        <h1 id="iniciosesion">
             Inicio de sesi&oacute;n
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

                <input type="checkbox" name="registro" value="true">¿Registrarse?

                <br>
                <br>

                <input type="submit" name="enviar" value="Enviar" class="botonEnviar">


                </div>
            </form>

            <%!
                Connection con;
                Statement set;
                ResultSet rs;
                String incorrecto = "";

                // ---------------------------------  METODOS DE INICIO DE SESION
                public int numeroViajes(String user) {
                    int numViajes = 0;
                    try {
                        set = con.createStatement();
                        rs = set.executeQuery("SELECT VIAJES FROM USUARIOS WHERE NOMBRE='" + user + "'");
                        while (rs.next()) {
                            numViajes = Integer.parseInt(rs.getString("VIAJES"));
                        }
                        rs.close();
                        set.close();
                    } catch (Exception e) {
                        System.out.println("No lee de la tabla numeroViajes");
                        System.out.println(e);
                    }
                    return (numViajes);
                }

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
                        if (existeUsuario(user)) {
                            System.out.println("El usuario ya existe");
                        } else {
                            set = con.createStatement();
                            set.executeUpdate("INSERT INTO USUARIOS VALUES ('" + user + "', '" + password + "', FALSE, 0)");
                            insertado = true;
                            System.out.println("Usuario introducido correctamente");
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

            <%
                //Creamos la conexion con la base de datos, esto es el driver
                con = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

                //Obtenemos el parametro del boton
                String boton = request.getParameter("enviar");

                if (boton != null) {
                    //Obtenemos los parametros del HTML
                    String user = request.getParameter("user");
                    String password = request.getParameter("password");
                    String regist = request.getParameter("registro");
                    incorrecto = "";
                    //Logica de funcionamiento
                    if (regist != null) {
                        System.out.println("Entramos al modo registro");
                        if (insertarUsuario(user, password)) {
                            //Iniciamos sesion con el cliente que se acaba de registrar
                            session.setAttribute("tipoUsuario", "cliente");
                            response.sendRedirect(response.encodeRedirectURL("/PracticaFinal/cliente.jsp"));
                        } else {
                            System.out.println("El usuario ya existe");
                            incorrecto = "El usuario ya existe";
                        }

                    } else {
                        System.out.println("Entramos en el modo inicio de sesion");
                        if (existeUsuario(user)) {
                            if (comprobarPassword(user, password)) {
                                if (tipoUsuario(user)) {
                                    System.out.println("El usuario existe y su contraseña es correcta, es un administrador");
                                    //Aqui no tiene sentido setear el numero de viajes, ya que el admin no compra
                                    session.setAttribute("Nombre", user);
                                    incorrecto = "";
                                    session.setAttribute("tipoUsuario", "admin");

                                    response.sendRedirect(response.encodeRedirectURL("/PracticaFinal/admin.jsp"));
                                } else {
                                    System.out.println("El usuario existe y su contraseña es correcta, es un cliente");
                                    session.setAttribute("Nombre", user);
                                    session.setAttribute("Viajes", numeroViajes(user));
                                    incorrecto = "";
                                    session.setAttribute("tipoUsuario", "cliente");
                                    response.sendRedirect(response.encodeRedirectURL("/PracticaFinal/cliente.jsp"));
                                }
                            } else {
                                System.out.println("La contraseña introducida es incorrecta");
                                incorrecto = "La contraseña es incorrecta";
                            }
                        } else {
                            System.out.println("El usuario no existe");
                            incorrecto = "El usuario no existe";
                        }
                    }
                } else {
                    System.out.println("Modo null ...");
                }


            %>

            <label class="correcion"> <%=incorrecto + ""%></label>

    </body>

</html>