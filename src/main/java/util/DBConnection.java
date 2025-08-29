package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBConnection {
    private final String serverName = "localhost";   
    private final String instance   = "";  
    private final Integer port      = 1433;      
    private final String dbName     = "WebAppDB";    
    private final String userID     = "sa";
    private final String password   = "123456";

    private final boolean encrypt = true;
    private final boolean trustServerCertificate = true;

    // --- Lấy Connection ---
    public Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String url = buildJdbcUrl();
        return DriverManager.getConnection(url, userID, password);
    }

    // Xây dựng chuỗi JDBC: ưu tiên INSTANCE; nếu không có thì dùng PORT
    private String buildJdbcUrl() {
        StringBuilder sb = new StringBuilder("jdbc:sqlserver://").append(serverName);
        if (instance != null && !instance.trim().isEmpty()) {
            sb.append("\\\\").append(instance.trim());       
        } else if (port != null) {
            sb.append(":").append(port);                     
        }
        sb.append(";databaseName=").append(dbName);
        sb.append(";encrypt=").append(encrypt);
        sb.append(";trustServerCertificate=").append(trustServerCertificate);
        return sb.toString();
    }

    // --- Tiện ích kiểm tra nhanh đang nối tới DB nào ---
    public String ping() {
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement("SELECT DB_NAME() AS db, @@SERVERNAME AS srv");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return "Connected DB=" + rs.getString("db") + " | Server=" + rs.getString("srv");
            }
            return "Ping failed: no rows";
        } catch (Exception e) {
            return "Ping failed: " + e.getMessage();
        }
    }
}
