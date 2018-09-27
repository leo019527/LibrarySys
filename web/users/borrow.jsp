<%@ page import="jdbc.Jdbc" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: 李凌耀
  Date: 2017/12/12
  Time: 0:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Cookie[] cookies = request.getCookies();
    Cookie username = null;
    for(Cookie c:cookies)
    {
        if(c.getName().equals("loginname"))
        {
            username = c;
            break;
        }
    }
    String uname = null;
    if(username != null) {
        uname = username.getValue();
    }else {
        request.setAttribute("error","未登录");
        request.getRequestDispatcher("error.jsp").forward(request,response);
    }
    request.setCharacterEncoding("UTF-8");
    Jdbc instance = Jdbc.getInstance();
    String sql = "";
    String start = request.getParameter("start");
    String end = request.getParameter("end");
    if (start != null && end != null) {
        sql = "select bookname,dateborrow,datereturn,loss,outofdate from borrow inner join books on borrow.bookid=books.bookid where readerid=(select readerid from user where username='" + uname + "') and dateborrow between '" + start + "' and '" + end + "'";
    } else {
        sql = "select bookname,dateborrow,datereturn,loss,outofdate from borrow inner join books on borrow.bookid=books.bookid where readerid=(select readerid from user where username='" + uname + "')";
    }
    ResultSet selected = instance.select(sql);
%>
<html>
<head>
    <title>借阅信息查询</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="../assets/css/main.css" />
</head>
<body>
<header id="header">
    <h1>coding by <a href="https://github.com/leo019527">leo019527</a></h1>
    <nav id="nav">
        <ul>
            <li style="white-space: nowrap;"><a href="../index.jsp">Home</a></li>
            <li style="-moz-user-select: none; cursor: pointer; white-space: nowrap; opacity: 1;" class="opener">
                <a href="#" class="icon fa-angle-down"><%=uname%></a>

                <ul style="-moz-user-select: none; display: none; position: absolute;" class="">
                    <li style="white-space: nowrap;"><a href="logoutServlet" style="display: block;">LOGOUT</a></li>
                </ul>
            </li>
        </ul>
    </nav>
</header>
<section id="main" class="container" style="width:70em">
    <section class="box special features">
        <form action="borrow.jsp" method="post">
            <div class="12u(mobilep)" style="width: 10%">
                <p style="margin: 0.5em 0 0 1em;">开始时间：</p>
            </div>
            <div class="6u 12u(mobilep)" style="width: 30%;padding-left: 0">
                <input id="start" name="start" value="" placeholder="开始时间（2000-01-01）" type="text">
            </div>
            <div class="12u(mobilep)" style="width: 10%">
                <p style="margin: 0.5em 0 0 1em;">终止时间：</p>
            </div>
            <div class="6u 12u(mobilep)" style="width: 30%;padding-left: 0">
                <input id="end" name="end" value="" placeholder="终止时间（2000-01-01）" type="text">
            </div>
            <div class="12u(mobilep)" style="width: 5%;padding-top: 1em">
                <input class="button special icon fa-search" type="submit" value="搜索">
            </div>
        </form>
        <div class="table-wrapper">
            <table class="alt">
                <thead>
                <tr>
                    <th>bookname</th>
                    <th>dateborrow</th>
                    <th>datereturn</th>
                    <th>loss</th>
                    <th>outofdate</th>
                </tr>
                </thead>
                <tbody>
                    <%try{
                        while(selected.next()){%>
                            <tr>
                                <td><%=selected.getString("bookname")%></td>
                                <td><%=selected.getString("dateborrow")%></td>
                                <td><%=selected.getString("datereturn")==null ? "未还":selected.getString("datereturn")%></td>
                                <td><%=selected.getString("loss").equals("0") ? "未丢失":"丢失"%></td>
                                <td><%=selected.getString("outofdate").equals("0") ? "未超时":"超时"%></td>
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
