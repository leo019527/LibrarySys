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
@WebServlet(name = "borrowUserLoginServlet",urlPatterns = {"/borrowUserLoginServlet"})
public class borrowUserLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String returnfiles = "";
        request.setCharacterEncoding("UTF-8");
        Jdbc instance = Jdbc.getInstance();
        String readerid = request.getParameter("readerid");
        String sql = "SELECT readerid,readername,level FROM readers WHERE readerid="+readerid;
        ResultSet select = instance.select(sql);
        try {
            if(select.next())
            {
                returnfiles +="1\001";
                String readerid1 = select.getString("readerid");
                String readername = select.getString("readername");
                String level = select.getString("level");
                returnfiles += "<p id='uid' style=\"font-size: 1em;margin-bottom: 0.5em;\">用户编号："+readerid1+"</p>";
                returnfiles += "<p style=\"font-size: 1em;margin-bottom: 0.5em;\">用户姓名："+readername+"</p>";
                returnfiles += "<p id='uvip'style=\"font-size: 1em;margin-bottom: 0.5em;\">VIP等级："+level+"</p>";
                returnfiles += "<a class=\"button special icon\" onClick=\"quit()\">退出</a>\001<div class='table-wrapper'><table class='alt'>" +
                        "<thead><tr><th>bookname</th><th>dateborrow</th><th>归还</th></tr></thead><tbody>";
                String sql1 = "select bookname,dateborrow FROM books inner join borrow on books.bookid=borrow.bookid WHERE readerid=" + readerid1 + " and loss<>1 and datereturn is NULL";
                ResultSet select1 = instance.select(sql1);
                while (select1.next())
                {
                    String tmp1 = select1.getString("bookname");
                    returnfiles += "<tr><td>" + tmp1 + "</td>";
                    String tmp = select1.getString("dateborrow");
                    returnfiles += "<td>" + tmp + "</td>";
                    returnfiles += "<td><a class='button alt small' onclick='reBooks(\"" + tmp + "\")'>归还</a></td></tr>";
                }
                returnfiles += "</tbody></table></div>\001";
                returnfiles += "<div class='table-wrapper'><table class='alt'>" +
                        "<thead><tr><th>bookname</th><th>dateborrow</th></tr></thead><tbody>";
                String sql2 = "select bookname,dateborrow FROM books,borrow WHERE readerid=\"" + readerid1 + "\" and loss=1";
                ResultSet select2 = instance.select(sql2);
                while(select2.next()){
                    returnfiles += "<tr><td>"+select2.getString("bookname")+"</td>";
                    returnfiles += "<td>"+select2.getString("dateborrow")+"</td></tr>";
                }
                returnfiles += "</tbody></table></div>";
            }else {
                returnfiles += "0\001<input id=\"userid\" name=\"userid\" value=\"用户编号不存在\" placeholder=\"用户编号\" type=\"text\">\n" +
                        "<input class=\"button special icon fa-search\" type=\"button\" onclick=\"submit2()\" style=\"margin-top: 0.5em;\" value=\"登录\">";
            }
        } catch (SQLException e) {
        }
        if(readerid.equals("-1"))
            returnfiles = "0\001<input id=\"userid\" name=\"userid\" value=\"\" placeholder=\"用户编号\" type=\"text\">\n" +
                    "<input class=\"button special icon fa-search\" type=\"button\" onclick=\"submit2()\" style=\"margin-top: 0.5em;\" value=\"登录\">";
        response.setContentType("text/xml;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.write(returnfiles);
        writer.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request,response);
    }
}
