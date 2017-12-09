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
 * Created by 李凌耀 on 2017/12/8.
 */
@WebServlet(name = "rootuserBookSearchServlet",urlPatterns = {"/rootuserBookSearchServlet"})
public class rootuserBookSearchServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String returnfiles = "";
        request.setCharacterEncoding("UTF-8");
        Jdbc instance = Jdbc.getInstance();
        String name = request.getParameter("name");
        if(name == null) name="";
        String author = request.getParameter("author");
        if(author==null) author="";
        String publishing = request.getParameter("publishing");
        if(publishing==null) publishing="";
        String category = request.getParameter("category");
        if(category==null) category="";
        String sql = "";
        if(!category.equals("")) {
            sql = "SELECT * FROM books where bookname like '%" + name + "%' and "
                    + "author like '%" + author + "%' and "
                    + "publishing like '%" + publishing + "%' and "
                    + "categoryid=" + category;
        }else {
            sql = "SELECT * FROM books where bookname like '%" + name + "%' and "
                    + "author like '%" + author + "%' and "
                    + "publishing like '%" + publishing + "%'";
        }
        System.out.println(sql);
        ResultSet selected = instance.select(sql);
        String[] cat = {"计算机技术","自然科学","医学","农林","建筑","科普","通信","化学","物理","美文"};
        try {
            while(selected.next()){
                int tmp = Integer.parseInt(selected.getString("bookid"));
                returnfiles += "<tr><td>";
                returnfiles += selected.getString("bookname")+"</td><td>";
                returnfiles += selected.getString("price")+"</td><td>";
                int quantity_in = Integer.parseInt(selected.getString("quantity_in"));
                returnfiles += quantity_in+"</td><td>";
                int quantity_out = Integer.parseInt(selected.getString("quantity_out"));
                returnfiles += quantity_out+"</td><td>";
                int quantity_loss = Integer.parseInt(selected.getString("quantity_loss"));
                returnfiles += quantity_loss+"</td><td>";
                if(quantity_in-quantity_loss-quantity_out > 0)
                    returnfiles += "<a onClick='return borrow(" + tmp + ")' class='button small'>借阅</a></td></tr>";
                else
                    returnfiles += "</td></tr>";
            }
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
