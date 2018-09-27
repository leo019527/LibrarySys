<%@ page import="java.sql.SQLException" %>
<%@ page import="jdbc.Jdbc" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: 李凌耀
  Date: 2017/12/10
  Time: 13:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    Jdbc instance = Jdbc.getInstance();
    String sql = "select readername,bookname,dateborrow from readers,books,borrow where borrow.readerid=readers.readerid and borrow.bookid=books.bookid and borrow.outofdate=1";
    ResultSet selected = instance.select(sql);
%>
<html>
<head>
    <title>逾期未还</title>
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
        <p style="font-size: 2.5em;border-top: none;border-bottom: solid 2px #d5d5d5;padding: 0 0 1em 0">逾期未还</p>
    </header>
    <section class="box special features">
        <div class="table-wrapper">
            <table class="alt">
                <thead>
                <tr>
                    <th>readername</th>
                    <th>bookname</th>
                    <th>dateborrow</th>
                </tr>
                </thead>
                <tbody>
                <%try{
                    while (selected.next()) {%>
                <tr>
                    <td><%=selected.getString("readername")%></td>
                    <td><%=selected.getString("bookname")%></td>
                    <td><%=selected.getString("dateborrow")%></td>
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
