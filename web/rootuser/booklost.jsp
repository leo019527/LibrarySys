<%@ page import="java.sql.ResultSet" %>
<%@ page import="jdbc.Jdbc" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: 李凌耀
  Date: 2017/12/11
  Time: 23:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    Jdbc instance = Jdbc.getInstance();
    String item = request.getParameter("item");
    if(item != null)
    {
        String[] split = item.split("sep");
        String sql2 = "UPDATE borrow SET loss=1 WHERE readerid="+split[0] + " and bookid='"+split[1]+"' and dateborrow='"+split[2]+"'";
        instance.insertUpdateDelete(sql2);
    }
    String sql = "select borrow.readerid,borrow.bookid,readername,bookname,dateborrow from readers,books,borrow where borrow.readerid=readers.readerid and borrow.bookid=books.bookid and borrow.datereturn is null and borrow.loss=0";
    ResultSet selected = instance.select(sql);
%>
<html>
<head>
    <title>图书挂失</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="../assets/css/main.css" />
</head>
<body>
<head>
    <title>图书挂失</title>
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
    <header style="margin-top: 0;">
        <p style="font-size: 2.5em;border-top: none;border-bottom: solid 2px #d5d5d5;padding: 0 0 1em 0">书籍借阅与归还</p>
    </header>
    <section class="box special features">
        <div class="table-wrapper">
            <table class="alt">
                <thead>
                <tr>
                    <th>readername</th>
                    <th>bookname</th>
                    <th>dateborrow</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <%try{
                    while (selected.next()) {%>
                <tr>
                    <td><%=selected.getString("readername")%></td>
                    <td><%=selected.getString("bookname")%></td>
                    <td><%=selected.getString("dateborrow")%></td>
                    <td>
                        <form action="booklost.jsp" method="post">
                            <input type="hidden" name="item" value="<%=selected.getString("readerid")%>sep<%=selected.getString("bookid")%>sep<%=selected.getString("dateborrow")%>">
                            <input type="submit" value="挂失">
                        </form>
                    </td>
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
