<%--
  Created by IntelliJ IDEA.
  User: 李凌耀
  Date: 2017/12/4
  Time: 18:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String error = (String) request.getAttribute("error");%>
<html>
<head>
    <title>error:<%=error%></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="assets/css/main.css" />
</head>
<body>
<div class="page-wrapper">
    <!-- Header -->
    <header id="header">
        <h1>coding by <a href="https://github.com/leo019527">leo019527</a></h1>
        <nav id="nav">
            <ul>
                <li style="white-space: nowrap;"><a href="index.jsp">Home</a></li>
            </ul>
        </nav>
    </header>
    <section id="main" class="container">
        <header>
            <br/>
            <br/>
            <br/>
            <br/>
            <h2><b>ERROR</b></h2>
            <p>An error happens : <%=error%></p>
        </header>
    </section>
</div>

</body>
</html>
