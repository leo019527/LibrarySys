import jdbc.Jdbc;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by 李凌耀 on 2017/12/9.
 */
@WebServlet(name = "returnServlet",urlPatterns = {"/returnServlet"})
public class returnServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String returnfiles = "";
        request.setCharacterEncoding("UTF-8");
        Jdbc instance = Jdbc.getInstance();
        String uid = request.getParameter("uid").split("：")[1];
        String borrowtime = request.getParameter("borrowtime");
        String sql1 = "SELECT bookid FROM borrow WHERE readerid="+uid+" and dateborrow='"+borrowtime+"'";
        ResultSet select = instance.select(sql1);
        String bookid = null;
        try {
            select.next();
            bookid = select.getString("bookid");
        } catch (SQLException e) {
        }
        String sql = "UPDATE borrow SET datereturn=CURDATE() WHERE readerid="+uid+" and dateborrow='"+borrowtime+"'";
        instance.insertUpdateDelete(sql);
        String sql2 = "UPDATE books SET quantity_out=quantity_out-1 WHERE bookid='"+bookid+"'";
        instance.insertUpdateDelete(sql2);
        String sql3 = "select bookname,dateborrow FROM books inner join borrow on books.bookid=borrow.bookid WHERE readerid=" + uid + " and loss<>1 and datereturn is NULL";
        ResultSet select1 = instance.select(sql3);
        returnfiles += "<div class='table-wrapper'><table class='alt'>" +
                "<thead><tr><th>bookname</th><th>dateborrow</th><th>归还</th></tr></thead><tbody>";
        try {
            while (select1.next())
            {
                String tmp1 = select1.getString("bookname");
                returnfiles += "<tr><td>" + tmp1 + "</td>";
                String tmp = select1.getString("dateborrow");
                returnfiles += "<td>" + tmp + "</td>";
                returnfiles += "<td><a class='button alt small' onclick='reBooks(\"" + tmp + "\")'>归还</a></td></tr>";
            }
            returnfiles += "</tbody></table></div>";
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.setContentType("text/xml;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.write(returnfiles);
        writer.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request,response);
    }
}
