
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ServletBBDD extends HttpServlet {

    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession s = req.getSession(true);

        String nombreCircuito = (String) req.getParameter("CajaCircuitos");
        String nombreCoche= (String) req.getParameter("CajaCoches");

        s.setAttribute("nombreCircuito", nombreCircuito);
        s.setAttribute("nombreCoche", nombreCoche);

        res.sendRedirect(res.encodeRedirectURL("/PL6JAVA/resultado.jsp"));
    }
}
