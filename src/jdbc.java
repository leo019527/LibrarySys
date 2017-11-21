import java.sql.*;

/**
 * Created by 李凌耀 on 2017/11/21.
 */
public class jdbc {
    private final String url = "jdbc:mysql://127.0.0.1/spj?useSSL=true";
    private final String name = "com.mysql.jdbc.Driver";
    private final String user = "root";
    private final String password = "";
    private Connection conn = null;
    Statement statement = null;

    private static final jdbc instance = new jdbc();

    private jdbc()
    {
        try{
            Class.forName(name);
            conn = DriverManager.getConnection(url,user,password);
            if(!conn.isClosed())
                System.out.println("Succeeded connecting to the Database!");
            statement = conn.createStatement();
        }catch (ClassNotFoundException e) {
            System.out.println("创建类错误");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("登录错误");
            e.printStackTrace();
        }
    }

    public static jdbc getInstance()
    {
        return instance;
    }

    public ResultSet select(String sql)
    {
        try {
            ResultSet rs = statement.executeQuery(sql);
            return rs;
        } catch (SQLException e) {
            System.out.println("查询错误");
            e.printStackTrace();
        }
        return null;
    }

    public void insertUpdateDelete(PreparedStatement psql)
    {
        try {
            psql.executeUpdate();
            psql.close();
        } catch (SQLException e) {
            System.out.println("增删改错误");
            e.printStackTrace();
        }
    }
}
