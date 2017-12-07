package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * Created by 李凌耀 on 2017/11/14.
 */
public class testforjdbc {
    public static final String url = "jdbc:mysql://localhost:3306/bookadmin";
    public static final String name = "com.mysql.jdbc.Driver";
    public static final String user = "root";
    public static final String password = "";
    public Connection conn = null;
    public PreparedStatement pst = null;

    private testforjdbc() {
        try {
            Class.forName(name);//指定连接类型
            conn = DriverManager.getConnection(url, user, password);//获取连接
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        System.out.println(new testforjdbc());
    }
}
