
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Servlet extends HttpServlet {

    private ModelosDatos bd;

    public void init(ServletConfig cfg) throws ServletException {
        bd = new ModelosDatos();
        bd.abrirConexion();
    }

    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String user = (String) req.getParameter("user");
        String password = (String) req.getParameter("password");
        
       if (bd.existeUsuario(user)){
           if(bd.comprobarPassword(user, password)){
               if (bd.tipoUsuario(user)){
                   //El usuario existe y su contraseña es correcta, es un administrador
                   res.sendRedirect(res.encodeRedirectURL("/PracticaFinal/admin.html"));
               }else{
                   //El usuario existe y su contraseña es correcta, es un cliente
                   res.sendRedirect(res.encodeRedirectURL("/PracticaFinal/cliente.html"));
               }
           }else{
               System.out.println("La contraseña introducida es incorrecta");
           }
       }else{
           System.out.println("El usuario no existe");
       }
        
    }

    public void destroy() {
        bd.cerrarConexion();
        super.destroy();
    }
}
