<%--
  Created by IntelliJ IDEA.
  User: 李凌耀
  Date: 2017/12/4
  Time: 19:39
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
%>
<html>
<head>
    <title>hello:<%=uname%></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="assets/css/main.css" />
</head>
<body>
<header id="header">
    <h1>coding by <a href="https://github.com/leo019527">leo019527</a></h1>
    <nav id="nav">
        <ul>
            <li style="white-space: nowrap;"><a href="index.jsp">Home</a></li>
            <li style="-moz-user-select: none; cursor: pointer; white-space: nowrap; opacity: 1;" class="opener">
                <a href="#" class="icon fa-angle-down"><%=uname%></a>

                <ul style="-moz-user-select: none; display: none; position: absolute;" class="">
                    <li style="white-space: nowrap;"><a href="logoutServlet" style="display: block;">LOGOUT</a></li>
                </ul>
            </li>
        </ul>
    </nav>
</header>
<section id="main" class="container">
    <section class="box special features">
        <div class="features-row">
            <section>
                <span class="icon major fa-bolt accent2"></span>
                <h3>查询图书信息</h3>
            </section>
            <section>
                <span class="icon major fa-area-chart accent3"></span>
                <h3>借阅信息</h3>
            </section>
        </div>
        <div class="features-row">
            <section>
                <span class="icon major fa-cloud accent4"></span>
                <h3>读者信息统计</h3>
            </section>
        </div>
    </section>
</section>
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/jquery.dropotron.min.js"></script>
<script src="assets/js/jquery.scrollgress.min.js"></script>
<script src="assets/js/skel.min.js"></script>
<script src="assets/js/util.js"></script>
<script src="assets/js/main.js"></script>
</body>
</html>
