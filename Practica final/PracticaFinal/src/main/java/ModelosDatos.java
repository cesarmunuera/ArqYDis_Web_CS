
import java.util.*;
import java.sql.*;

public class ModelosDatos {

    private Connection con;
    private Statement set;
    private ResultSet rs;

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
            set = con.createStatement();
            rs = set.executeQuery("SELECT * FROM COCHES");
            while (rs.next()) {
                cad = rs.getString("NOMBRE");
                cad = cad.trim();
                if (cad.compareTo(nombre.trim()) == 0) {
                    existe = true;
                }
            }
            rs.close();
            set.close();
        } catch (Exception e) {
            System.out.println("No lee de la tabla");
        }
        return (existe);
    }

    public boolean comprobarPassword(String user, String password) {
        boolean correcta = false;
        return (correcta);
    }

    public boolean tipoUsuario(String nombre) {
        boolean Admin = false;
        return (Admin);
    }

    
    
    
    
    
    
    public void cerrarConexion() {
        try {
            con.close();
        } catch (Exception e) {
        }
    }
}
