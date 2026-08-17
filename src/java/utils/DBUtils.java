package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtils {

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        String dbName = EnvUtils.get("DB_NAME", "PRJ301_Ecommerce");
        String dbUser = EnvUtils.get("DB_USERNAME", "sa");
        String dbPass = EnvUtils.get("DB_PASSWORD", "12345");
        String dbHost = EnvUtils.get("DB_HOST", "localhost");
        String dbPort = EnvUtils.get("DB_PORT", "1433");

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        
        // Optimized JDBC connection string with adaptive buffering and fast packet size
        String url = "jdbc:sqlserver://" + dbHost + ":" + dbPort + ";databaseName=" + dbName 
                   + ";encrypt=true;trustServerCertificate=true;packetSize=8192;responseBuffering=adaptive;applicationName=One61Garment;";
        
        return DriverManager.getConnection(url, dbUser, dbPass);
    }
}
