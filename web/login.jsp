<%--
  Created by IntelliJ IDEA.
  User: 李凌耀
  Date: 2017/12/5
  Time: 9:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="assets/css/main.css" />
</head>
<body>
<header id="header">
    <h1>coding by <a href="https://github.com/leo019527">leo019527</a></h1>
    <nav id="nav">
        <ul>
            <li style="white-space: nowrap;"><a href="register.jsp">注册</a></li>
            <li style="white-space: nowrap;"><a href="index.jsp">Home</a></li>
        </ul>
    </nav>
</header>
<section id="banner" background="images/banner.jpg">
    <h2>登录</h2>
    <form action="loginServlet" method="post">
        <ul class="actions">
            <li><input name="username" id="username" value="" placeholder="用户名" type="text" style="color: black"></li>
        </ul>
        <ul class="actions">
            <li><input name="psw" id="psw" value="" placeholder="密码" type="password" style="color: black"></li>
        </ul>
        <input type="submit" value="登录">
    </form>
</section>
</body>
</html>
