<%--
  Created by IntelliJ IDEA.
  User: 李凌耀
  Date: 2017/12/5
  Time: 16:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jdbc.Jdbc" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%
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
%>
<html>
<head>
    <title>查询和统计图书信息</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="../assets/css/main.css" />
</head>
<body>
<header id="header">
    <h1>coding by <a href="https://github.com/leo019527">leo019527</a></h1>
    <nav id="nav">
        <ul>
            <li style="white-space: nowrap;"><a href="../rootuser.jsp">Home</a></li>
        </ul>
    </nav>
</header>
<section id="main" class="container" style="width:70em">
    <section class="box special features">
        <form action="book.jsp" method="post">
            <div class="row uniform 50%" style="border-bottom: 1px solid #CCC;padding-bottom: 0.5em;">
                <div class="12u(mobilep)" style="width: 10%">
                    <p style="margin: 0.5em 0 0 1em;">书名：</p>
                </div>
                <div class="6u 12u(mobilep)" style="width: 10%;padding-left: 0">
                    <input id="name" name="name" value="" placeholder="书名" type="text">
                </div>
                <div class="12u(mobilep)" style="width: 10%">
                    <p style="margin: 0.5em 0 0 1em;">作者：</p>
                </div>
                <div class="6u 12u(mobilep)" style="width: 10%;padding-left: 0">
                    <input id="author" name="author" value="" placeholder="作者" type="text">
                </div>
                <div class="12u(mobilep)" style="width: 15%">
                    <p style="margin: 0.5em 0 0 1em;">出版社：</p>
                </div>
                <div class="6u 12u(mobilep)" style="width: 10%;padding-left: 0">
                    <input id="publishing" name="publishing" value="" placeholder="出版社" type="text">
                </div>
                <div class="12u(mobilep)" style="width: 25%">
                    <select id="category" name="category">
                        <option value="">- 类别 -</option>
                        <option value="1">计算机技术</option>
                        <option value="2">自然科学</option>
                        <option value="3">医学</option>
                        <option value="4">农林</option>
                        <option value="5">建筑</option>
                        <option value="6">科普</option>
                        <option value="7">通信</option>
                        <option value="8">化学</option>
                        <option value="9">物理</option>
                        <option value="10">美文</option>
                    </select>
                </div>
                <div class="12u(mobilep)" style="width: 5%">
                    <input class="button special icon fa-search" type="submit" value="搜索">
                </div>
            </div>
        </form>
        <div class="table-wrapper">
            <table class="alt">
                <thead>
                    <tr>
                        <th>book-id</th>
                        <th>book-name</th>
                        <th>author</th>
                        <th>publishing</th>
                        <th>price</th>
                        <th>date-in</th>
                        <th>quantity-in</th>
                        <th>quantity-out</th>
                        <th>quantity-loss</th>
                        <th>category</th>
                    </tr>
                </thead>
                <tbody>
                    <%try{
                        while (selected.next()) {%>
                        <tr>
                            <td><%=selected.getString("bookid")%></td>
                            <td><%=selected.getString("bookname")%></td>
                            <td><%=selected.getString("author")%></td>
                            <td><%=selected.getString("publishing")%></td>
                            <td><%=selected.getString("price")%></td>
                            <td><%=selected.getString("datein")%></td>
                            <td><%=selected.getString("quantity_in")%></td>
                            <td><%=selected.getString("quantity_out")%></td>
                            <td><%=selected.getString("quantity_loss")%></td>
                            <td><%=cat[Integer.parseInt(selected.getString("categoryid"))-1]%></td>
                        </tr>
                    <%}
                    }catch (SQLException e)
                    {}%>
                </tbody>
            </table>
        </div>
    </section>
</section>
</body>
</html>
