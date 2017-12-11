<%@ page import="java.sql.SQLException" %>
<%@ page import="jdbc.Jdbc" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: 李凌耀
  Date: 2017/12/11
  Time: 23:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    Jdbc instance = Jdbc.getInstance();
    String item = request.getParameter("item");
    if(item != null)
    {
        instance.insertUpdateDelete("INSERT INTO lossreporting values("+item+",CURDATE())");
        instance.insertUpdateDelete("UPDATE readers SET cardname=null,cardid=null,level=0,day=null");
    }
    String sql = "select readerid,readername from readers where readerid not in (select readerid from lossreporting)";
    ResultSet selected = instance.select(sql);
%>
<html>
<head>
    <title>借书证挂失</title>
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
        <p style="font-size: 2.5em;border-top: none;border-bottom: solid 2px #d5d5d5;padding: 0 0 1em 0">借书证挂失</p>
    </header>
    <section class="box special features">
        <div class="table-wrapper">
            <table class="alt">
                <thead>
                <tr>
                    <th>readername</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <%try{
                    while (selected.next()) {%>
                <tr>
                    <td><%=selected.getString("readername")%></td>
                    <td>
                        <form action="cardloss.jsp" method="post">
                            <input type="hidden" name="item" value="<%=selected.getString("readerid")%>">
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
