package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * Created by 李凌耀 on 2017/11/14.
 */
public class testforjdbc {
    public static final String url = "jdbc:mysql://127.0.0.1/spj?useSSL=true";
    public static final String name = "com.mysql.jdbc.Driver";
    public static final String user = "root";
    public static final String password = "";
    public Connection conn = null;
    public PreparedStatement pst = null;

    public boolean connction() {
        try {
            Class.forName(name);//指定连接类型
            conn = DriverManager.getConnection(url, user, password);//获取连接
            pst = conn.prepareStatement("");//准备执行语句
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {
        System.out.println(new testforjdbc().connction());
    }
}
