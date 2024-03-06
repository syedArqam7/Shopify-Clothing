import java.sql.Connection;
import java.sql.DriverManager;

public class Database {
    private static final String JDBC_URL = "jdbc:mysql:///scd";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "ARQAM$n1k1t$420$";

    public static Connection getConnection()  {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        } catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
}