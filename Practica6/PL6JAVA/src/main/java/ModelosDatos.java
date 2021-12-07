
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

    // COCHES
    
    public boolean existeCoche(String nombre) {
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

    public void insertarCoche(String nombre, float ganancia) {
        try {
            set = con.createStatement();
            set.executeUpdate("INSERT INTO COCHES " + " (NOMBRE,GANANCIA) VALUES ('" + nombre + "'," + ganancia + ")");
            rs.close();
            set.close();
        } catch (Exception e) {
            System.out.println("No inserta en la tabla");
        }
    }
    
    // CIRCUITOS
    
    public boolean existeCircuito(String nombre) {
        boolean existe = false;
        String cad;
        try {
            set = con.createStatement();
            rs = set.executeQuery("SELECT * FROM CIRCUITOS");
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

    public void insertarCircuito(String nombre, String ciudad, String pais, int num_vueltas, int long_vueltas, int num_curvas) {
        try {
            set = con.createStatement();
            set.executeUpdate("INSERT INTO CIRCUITOS " + " (NOMBRE,CIUDAD,PAIS,NUMERO_VUELTAS,LONGITUD_VUELTAS,NUMERO_CURVAS) VALUES ('" + nombre + "','" + ciudad + "','" + pais + "'," + num_vueltas + "," + long_vueltas + "," + num_curvas + ")");
            rs.close();
            set.close();
        } catch (Exception e) {
            System.out.println("No inserta en la tabla");
        }
    }
    
    //

    public void cerrarConexion() {
        try {
            con.close();
        } catch (Exception e) {
        }
    }
}
