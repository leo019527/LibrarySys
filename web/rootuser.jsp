<%--
  Created by IntelliJ IDEA.
  User: 李凌耀
  Date: 2017/12/5
  Time: 14:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>后台管理</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="assets/css/main.css" />
</head>
<body>
<header id="header">
    <h1>coding by <a href="https://github.com/leo019527">leo019527</a></h1>
    <nav id="nav">
        <ul>
            <li style="white-space: nowrap;"><a href="rootuser.jsp">Home</a></li>
        </ul>
    </nav>
</header>
<section id="main" class="container">
    <section class="box special features">
        <div class="features-row">
            <section>
                <span class="icon major fa-cloud accent2"></span>
                <h3><a href="rootuser/book.jsp"> 查询图书信息</a></h3>
            </section>
            <section>
                <span class="icon major fa-cloud accent3"></span>
                <h3><a href="rootuser/user.jsp"> 查询读者信息</a></h3>
            </section>
        </div>
        <div class="features-row">
            <section>
                <span class="icon major fa-cloud accent4"></span>
                <h3><a href="rootuser/bookin.jsp"> 图书入库</a></h3>
            </section>
            <section>
                <span class="icon major fa-cloud accent3"></span>
                <h3><a href="rootuser/outofdate.jsp"> 逾期未还</a></h3>
            </section>
        </div>
        <div class="features-row">
            <section>
                <span class="icon major fa-cloud accent2"></span>
                <h3><a href="rootuser/borrowandreturn.jsp"> 图书借阅</a></h3>
            </section>
            <section>
                <span class="icon major fa-cloud accent4"></span>
                <h3><a href="rootuser/booklost.jsp"> 图书挂失</a></h3>
            </section>
        </div>
        <div class="features-row">
            <section>
                <span class="icon major fa-cloud accent2"></span>
                <h3><a href="rootuser/cardloss.jsp">借书证挂失</a></h3>
            </section>
        </div>
    </section>
</section>
</body>
</html>
