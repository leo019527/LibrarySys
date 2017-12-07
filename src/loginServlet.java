import jdbc.Jdbc;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by 李凌耀 on 2017/12/5.
 */
@WebServlet(name = "loginServlet",urlPatterns = {"/loginServlet"})
public class loginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String psw = request.getParameter("psw");
        Jdbc instance = Jdbc.getInstance();
        ResultSet select = instance.select("SELECT psw FROM user WHERE username='"+username+"'");
        try {
            if(select.next())
            {
                String psw1 = select.getString("psw");
                if(!psw.equals(psw1)) {
                    request.setAttribute("error","密码错误");
                    request.getRequestDispatcher("error.jsp").forward(request,response);
                }else {
                    Cookie loginCookie = new Cookie("loginname",username);
                    response.addCookie(loginCookie);
                    response.sendRedirect("user.jsp");
                }
                return;
            }
        } catch (SQLException e) {
            request.setAttribute("error","用户不存在");
            request.getRequestDispatcher("error.jsp").forward(request,response);
        }
        request.setAttribute("error","用户不存在");
        request.getRequestDispatcher("error.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request,response);
    }
}
