<!DOCTYPE HTML>
<%--
  Created by IntelliJ IDEA.
  User: 李凌耀
  Date: 2017/11/4
  Time: 14:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Cookie[] cookies = request.getCookies();
    Cookie username = null;
    for(Cookie c:cookies) {
        if(c.getName().equals("loginname")) {
            username = c;
            break;
        }
    }
    String uname = null;
    if(username != null) {
        uname = username.getValue();
        request.getRequestDispatcher("user.jsp").forward(request,response);
    }
%>
<html>
  <head>
    <title>图书馆管理系统——登录页面</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="assets/css/main.css" />
  </head>
  <body class="landing">
  <div id="page-wrapper">

      <!-- Header -->
      <header id="header" class="reveal alt">
          <h1>coding by <a href="https://github.com/leo019527">leo019527</a></h1>
          <nav id="nav">
              <ul>
                  <li style="white-space: nowrap;"><a href="index.jsp">Home</a></li>
              </ul>
          </nav>
      </header>

      <!-- Banner -->
      <section id="banner">
          <h2>library</h2>
          <p>From bjtu</p>
          <ul class="actions">
              <li><a href="login.jsp" class="button special">Sign Up</a></li>
              <li><a href="register.jsp" class="button">register</a></li>
          </ul>
      </section>

      <!-- Main -->

  </div>

  <!-- Scripts -->
  <script src="assets/js/jquery.min.js"></script>
  <script src="assets/js/jquery.dropotron.min.js"></script>
  <script src="assets/js/jquery.scrollgress.min.js"></script>
  <script src="assets/js/skel.min.js"></script>
  <script src="assets/js/util.js"></script>

  <script src="assets/js/main.js"></script>



  </body>
</html>
