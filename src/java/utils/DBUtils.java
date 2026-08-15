package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBUtils {
    // Configuration loaded from .env via EnvUtils
    private static final String DB_NAME = EnvUtils.get("DB_NAME", "PRJ301_Ecommerce"); 
    private static final String DB_USERNAME = EnvUtils.get("DB_USERNAME", "sa");
    private static final String DB_PASSWORD = EnvUtils.get("DB_PASSWORD", "12345"); 
    private static final String DB_HOST = EnvUtils.get("DB_HOST", "localhost"); 
    private static final String DB_PORT = EnvUtils.get("DB_PORT", "1433"); 

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Connection conn = null;
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String url = "jdbc:sqlserver://" + DB_HOST + ":" + DB_PORT + ";databaseName=" + DB_NAME + ";encrypt=true;trustServerCertificate=true;";
        conn = DriverManager.getConnection(url, DB_USERNAME, DB_PASSWORD);
        return conn;
    }

    // Hàm test thử kết nối
    public static void main(String[] args) {
        try {
            Connection conn = getConnection();
            if (conn != null) {
                System.out.println("Kết nối Database thành công!");
                conn.close();
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBUtils.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
