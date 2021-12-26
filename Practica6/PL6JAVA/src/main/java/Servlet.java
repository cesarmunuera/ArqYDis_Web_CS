
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Servlet extends HttpServlet {

    private ModelosDatos bd;

    public void init(ServletConfig cfg) throws ServletException {
        bd = new ModelosDatos();
        bd.abrirConexion();
    }

    // AQUI CODIGO
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // OBTENEMOS LOS PARAMETROS ENVIADOS DEL POST DEL HTML
        String nombre_circuito = (String) req.getParameter("nombre_circuito");
        String ciudad = (String) req.getParameter("ciudad");
        String pais = (String) req.getParameter("pais");
        int num_vueltas = Integer.parseInt(req.getParameter("num_vueltas"));
        int longitud = Integer.parseInt(req.getParameter("longitud"));
        int num_curvas = Integer.parseInt(req.getParameter("num_curvas"));
        String nombre_coche = (String) req.getParameter("nombre_coche");
        float ganancia = Float.parseFloat(req.getParameter("ganancia"));
        System.out.println(ganancia);
        // COMPROBAMOS SI EXISTE EL COCHE
        if (bd.existeCoche(nombre_coche)) {
            //System.out.println("Ya existe un coche con ese nombre");
            res.getWriter().write("Ya existe un coche con ese nombre");
        } else {
            bd.insertarCoche(nombre_coche, ganancia);
        }

        // COMPROBAMOS SI EXISTE EL CIRCUITO
        if (bd.existeCircuito(nombre_circuito)) {
            System.out.println("Ya existe un circuito con ese nombre");
        } else {
            bd.insertarCircuito(nombre_circuito, ciudad, pais, num_vueltas, longitud, num_curvas);
        }

        res.sendRedirect(res.encodeRedirectURL("/PL6JAVA/index.html"));
    }

    public void destroy() {
        bd.cerrarConexion();
        super.destroy();
    }

}
