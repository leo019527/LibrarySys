import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by 李凌耀 on 2017/11/8.
 */
@WebServlet(name = "RegisterServlet",urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        Jdbc instance = Jdbc.getInstance();

        //<editor-fold desc="表单获取">
        String username = request.getParameter("username");
        String psw = request.getParameter("psw");
            String readername = request.getParameter("readername");
        String sex = request.getParameter("sex");
        String birthdayS = request.getParameter("birthday");
        Date birthday = null;
        try {
            birthday = new SimpleDateFormat("yyyy-mm-dd").parse(birthdayS);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        String phone = request.getParameter("phone");
        String cardid = request.getParameter("cardid");
        Calendar now = Calendar.getInstance();
        String nowData = now.get(Calendar.YEAR)+"-"+now.get(Calendar.MONTH)+"-"+now.get(Calendar.DAY_OF_MONTH);
        //</editor-fold>

        String UsernameSQL = "SELECT username from user where username='"+username+"'";
        ResultSet SUsername = instance.select(UsernameSQL);
        try {
            if (SUsername.next()) {
                request.setAttribute("error","用户名重复");
                request.getRequestDispatcher("error.jsp").forward(request,response);
                return;
            }
        } catch (SQLException e) {
        }

        String sql = "INSERT INTO readers(readername,sex,birthday,phone,cardid,level,day) values('" +
                readername + "','" +
                sex + "','" +
                new java.sql.Date(birthday.getTime()) + "'," +
                phone + "," +
                cardid + "," +
                1 + ",'" +
                nowData +
                "')";
        instance.insertUpdateDelete(sql);
        sql = "INSERT INTO USER values('"+
                username+ "','"+
                psw + "'," +
                "(select max(readerid) from readers)" +
                ")";
        instance.insertUpdateDelete(sql);
        Cookie loginCookie = new Cookie("loginname",username);
        response.addCookie(loginCookie);
        response.sendRedirect("user.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request,response);
    }
}
