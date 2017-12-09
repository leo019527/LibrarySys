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
@WebServlet(name = "borrowServlet",urlPatterns = {"/borrowServlet"})
public class borrowServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String returnfiles = "<div class='table-wrapper'><table class='alt'>" +
                "<thead><tr><th>bookname</th><th>dateborrow</th><th>归还</th></tr></thead><tbody>";
        request.setCharacterEncoding("UTF-8");
        Jdbc instance = Jdbc.getInstance();
        String readerid = request.getParameter("readerid").split("：")[1];
        String bookid = request.getParameter("bookid");
        String sql1 = "UPDATE books SET quantity_out=quantity_out+1 WHERE bookid="+bookid;
        instance.insertUpdateDelete(sql1);
        String sql2 = "INSERT INTO borrow VALUES("+readerid+",'"+bookid+"',NOW(),NULL,0)";
        instance.insertUpdateDelete(sql2);
        String sql3 = "select bookname,dateborrow FROM books inner join borrow on books.bookid=borrow.bookid WHERE readerid=" + readerid + " and loss<>1 and datereturn is NULL";
        ResultSet select1 = instance.select(sql3);
        try {
            while (select1.next())
            {
                String tmp = select1.getString("bookname");
                returnfiles += "<tr><td>"+tmp+"</td>";
                returnfiles += "<td>"+select1.getString("dateborrow")+"</td>";
                returnfiles += "<td><a class='button alt small' onClick='returnBooks("+ tmp +")'>归还</a></td></tr>";
            }
            returnfiles += "</tbody></table></div>\001";
            returnfiles += "<div class='table-wrapper'><table class='alt'>" +
                    "<thead><tr><th>bookname</th><th>dateborrow</th></tr></thead><tbody>";
        } catch (SQLException e) {
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
