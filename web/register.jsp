<!DOCTYPE HTML>
<%--
  Created by IntelliJ IDEA.
  User: 李凌耀
  Date: 2017/11/7
  Time: 9:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="assets/css/main.css" />
</head>
<body>
<div id="page-wrapper">
    <!-- Header -->
    <header id="header">
        <h1>coding by <a href="https://github.com/leo019527">leo019527</a></h1>
        <nav id="nav">
            <ul>
                <li style="white-space: nowrap;"><a href="index.jsp">Home</a></li>
            </ul>
        </nav>
    </header>

    <!-- Main -->
    <section id="main" class="container 75%">
        <header>
            <h2><b>register</b></h2>
            <p style="">Tell us some information about you</p>
        </header>
        <div class="box">
            <form method="post" action="register">
                <div class="row uniform 50%">
                    <div class="6u 12u(mobilep)">
                        <input value="" id="username" name="username" placeholder="用户名" autocomplete="off" maxlength="10" type="text">
                    </div>
                    <div class="6u 12u(mobilep)">
                        <input value="" id="psw" name="psw" placeholder="密码" autocomplete="off" maxlength="16" type="password" pattern="[0-9a-zA-Z]+">
                    </div>
                </div>
                <div class="row uniform 50%">
                    <div class="12u" style="float: left;">

                        <input value="" id="readername" name="readername" autocomplete="off" placeholder="姓名" type="text">
                    </div>
                </div>
                <div class="row uniform 50%">
                    <div class="12u">
                        <div class="select-wrapper">
                            <select name="sex" id="sex">

                                <option value="男">男</option>
                                <option value="女">女</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row uniform 50%">
                    <div class="12u">
                        <input value="" id="birthday" name="birthday" pattern="[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])" maxlength="10" placeholder="生日 (1996-01-01)" type="text">
                    </div>
                </div>
                <div class="row uniform 50%">
                    <div class="12u">
                        <input value="" placeholder="手机号码" maxlength="11" pattern="1[34578]\d{9}" id="phone" name="phone" type="text">
                    </div>
                </div>
                <div class="row uniform 50%">
                <div class="12u">
                    <input value="" id="day" name="day" type="hidden">
                </div>

            </div>

                <div class="row uniform">
                    <div class="12u">
                        <ul class="actions align-center">
                            <li><input value="注册" type="submit"></li>
                        </ul>
                    </div>
                </div>
            </form>
        </div>
    </section>

    <!-- Footer -->


</div>

<!-- Scripts -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/jquery.dropotron.min.js"></script>
<script src="assets/js/jquery.scrollgress.min.js"></script>
<script src="assets/js/skel.min.js"></script>
<script src="assets/js/util.js"></script>
<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
<script src="assets/js/main.js"></script>



</body>
</html>
