<%@ page import="jdbc.Jdbc" %><%--
  Created by IntelliJ IDEA.
  User: 李凌耀
  Date: 2017/12/8
  Time: 16:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>图书借阅与归还</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="../assets/css/main.css" />
    <script>
        function submit1() {
            var xmlhttp;
            if(window.XMLHttpRequest){
                xmlhttp = new XMLHttpRequest();
            }else {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState==4 && xmlhttp.status==200){
                    document.getElementById("tbody1").innerHTML=xmlhttp.responseText;
                }
            };
            xmlhttp.open("GET","http://localhost:8080/library/rootuserBookSearchServlet?name="+document.getElementById("name").value
                + "&author="+document.getElementById("author").value
                + "&publishing="+document.getElementById("publishing").value
                + "&category="+document.getElementById("category").value,true);
            xmlhttp.send(null);
        }

        function submit2() {
            var xmlhttp;
            if(window.XMLHttpRequest){
                xmlhttp = new XMLHttpRequest();
            }else {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState==4 && xmlhttp.status==200){
                    var text = xmlhttp.responseText;
                    var type = text.split("\001");
                    if(type[0] == "1") {
                        document.getElementById("userlogin").innerHTML = type[1];
                        document.getElementById("borrowDIV").innerHTML = type[2];
                        document.getElementById("lossDIV").innerHTML = type[3];
                    }else {
                        document.getElementById("userlogin").innerHTML = type[1];
                    }
                }
            };
            xmlhttp.open("GET","http://localhost:8080/library/borrowUserLoginServlet?readerid="+document.getElementById("userid").value,true);
            xmlhttp.send(null);
        }

        function quit() {
            var xmlhttp;
            if(window.XMLHttpRequest){
                xmlhttp = new XMLHttpRequest();
            }else {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState==4 && xmlhttp.status==200){
                    document.getElementById("userlogin").innerHTML=xmlhttp.responseText;
                }
            };
            xmlhttp.open("GET","http://localhost:8080/library/borrowUserLoginServlet?readerid=-1",true)
            xmlhttp.send(null);
        }

        function borrow(bookid) {
            var uid = document.getElementById("uid");
            if(uid == null){
                alert("未登录");
                return false
            }
            uid = uid.innerHTML;
            var uvip = document.getElementById("uvip").innerHTML;
            var xmlhttp;
            if(window.XMLHttpRequest){
                xmlhttp = new XMLHttpRequest();
            }else {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState==4 && xmlhttp.status==200){
                    var text = xmlhttp.responseText;
                    if(text != "1") {
                        document.getElementById("borrowDIV").innerHTML = text;
                    }else {
                        alert("无法借书");
                    }
                    submit1();
                }
            };
            xmlhttp.open("GET","http://localhost:8080/library/borrowServlet?readerid="+uid+"&bookid="+bookid+"&vip="+uvip,true);
            xmlhttp.send(null);
        }

        function reBooks(borrowtime) {
            var uid = document.getElementById("uid");
            if(uid == null){
                alert("未登录");
                return false
            }
            uid = uid.innerHTML;
            var xmlhttp;
            if(window.XMLHttpRequest){
                xmlhttp = new XMLHttpRequest();
            }else {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState==4 && xmlhttp.status==200){
                    document.getElementById("borrowDIV").innerHTML=xmlhttp.responseText;
                    submit1()
                }
            };
            xmlhttp.open("GET","http://localhost:8080/library/returnServlet?uid="+uid+"&borrowtime="+borrowtime,true);
            xmlhttp.send(null);
        }
    </script>
</head>
<body>
<div id="page-wrapper">
    <header id="header">
        <h1>coding by <a href="https://github.com/leo019527">leo019527</a></h1>
        <nav id="nav">
            <ul>
                <li style="white-space: nowrap;"><a href="../rootuser.jsp">Home</a></li>
            </ul>
        </nav>
    </header>
    <section id="main" class="container" style="width: 70em;padding-top: 1em;">
        <header style="margin-top: 0;">
            <p style="font-size: 2.5em;border-top: none;border-bottom: solid 2px #d5d5d5;padding: 0 0 1em 0">书籍借阅与归还</p>
        </header>
        <div class="row">
            <div class="12u box" style="width: 70%;">
                <p style="font-size: 1em;border-top: none;border-bottom: solid 1px #d5d5d5;">书籍信息</p>
                <form action="book.jsp" method="post">
                    <div class="row uniform 50%" style="border-bottom: 1px solid #CCC;padding-bottom: 0.5em;">
                        <div class="6u 12u(mobilep)" style="width: 20%;padding-left: 1em">
                            <input id="name" name="name" value="" placeholder="书名" type="text">
                        </div>
                        <div class="6u 12u(mobilep)" style=" width: 20%;padding-left: 1em">
                            <input id="author" name="author" value="" placeholder="作者" type="text">
                        </div>
                        <div class="6u 12u(mobilep)" style="width: 20%;padding-left: 1em">
                            <input id="publishing" name="publishing" value="" placeholder="出版社" type="text">
                        </div>
                        <div class="12u(mobilep)" style="width: 25%">
                            <select id="category" name="category">
                                <option value="">- 类别 -</option>
                                <option value="1">计算机技术</option>
                                <option value="2">自然科学</option>
                                <option value="3">医学</option>
                                <option value="4">农林</option>
                                <option value="5">建筑</option>
                                <option value="6">科普</option>
                                <option value="7">通信</option>
                                <option value="8">化学</option>
                                <option value="9">物理</option>
                                <option value="10">美文</option>
                            </select>
                        </div>
                        <div class="12u(mobilep)" style="width: 6%">
                            <input class="button special icon fa-search" type="button" onclick="submit1()" value="搜索">
                        </div>
                    </div>
                </form>
                <div class="table-wrapper">
                    <table class="alt">
                        <thead>
                        <tr>
                            <th>书名</th>
                            <th>价格</th>
                            <th>库存</th>
                            <th>借出数量</th>
                            <th>丢失数量</th>
                            <th>借书</th>
                        </tr>
                        </thead>
                        <tbody id="tbody1">

                        </tbody>
                    </table>
                </div>
            </div>
            <div class="12u" style="width: 30%;float: right">
                <div class="12u box" style="width: 100%;border-bottom: solid 4px;border-right: solid;border-top: solid 1px;border-left: solid 1px;padding: 1em 1em 2em 1em;">
                    <p style="font-size: 1em;border-top: none;border-bottom: solid 1px #d5d5d5;margin-bottom: 0.5em;">登录信息</p>
                    <div id="userlogin">
                        <input id="userid" name="userid" value="" placeholder="用户编号" type="text">
                        <input class="button special icon" type="button" onclick="submit2()" style="margin-top: 0.5em;" value="登录">
                    </div>
                </div>
                <div class="12u box" style="width: 100%;border-bottom: solid 4px;border-right: solid;border-top: solid 1px;border-left: solid 1px;padding: 1em 1em 2em 1em;">
                    <p style="font-size: 1em;border-top: none;border-bottom: solid 1px #d5d5d5;margin-bottom: 0.5em;">借阅信息</p>
                    <div id="borrowDIV">
                    </div>
                </div>
                <div class="12u box" style="width: 100%;border-bottom: solid 4px;border-right: solid;border-top: solid 1px;border-left: solid 1px;padding: 1em 1em 2em 1em;">
                    <p style="font-size: 1em;border-top: none;border-bottom: solid 1px #d5d5d5;margin-bottom: 0.5em;">遗失信息</p>
                    <div id="lossDIV">
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
</body>
</html>
