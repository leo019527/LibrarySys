<%@ page import="jdbc.Jdbc" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: 李凌耀
  Date: 2017/12/12
  Time: 8:58
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
    if(start != null && end != null)
    {
        sql = "select categoryid from borrow inner join books on borrow.bookid=books.bookid where readerid=(select readerid from user where username='" + uname + "') and dateborrow between '" + start + "' and '" + end + "'";
    }else {
        sql = "select categoryid from borrow inner join books on borrow.bookid=books.bookid where readerid=(select readerid from user where username='" + uname + "')";
    }
    ResultSet select = instance.select(sql);
    int ca[] = {0,0,0,0,0,0,0,0,0,0};
    try {
        while (select.next())
        {
            int i = Integer.parseInt(select.getString("categoryid"));
            ca[i-1]++;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    String date = "["+ca[0]+","+ca[1]+","+ca[2]+","+ca[3]+","+ca[4]+","+ca[5]+","+ca[6]+","+ca[7]+","+ca[8]+","+ca[9]+"]";
    System.out.println(date);
%>
<html>
<head>
    <title>统计信息</title>
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
<section id="main2" class="container" style="width:70em">
    <section class="box special features">
        <form action="sum.jsp" method="post">
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
        <div id="main" style="height: 800px"></div>
    </section>
</section>
<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
<script type="text/javascript">
    require.config({
        paths:{
            echarts: 'http://echarts.baidu.com/build/dist'
        }
    });

    require(
        [
            'echarts',
            'echarts/chart/bar'
        ],
        function (ec){
            var myChart = ec.init(document.getElementById('main'));

            //设置数据
            option = {
                title: {
                    text: '图书类别借阅统计',
                    left: 'center',
                    top: 10
                },
                color: ['rgb(25, 183, 207)'],
                grid: {
                    top: 80,
                    containLabel: true
                },
                xAxis : [
                    {
                        type : 'category',
                        data : ["计算机技术","自然科学","医学","农林","建筑","科普","通信","化学","物理","美文"]
                    }
                ],
                yAxis: [{
                    type: 'value'
                }],
                series: [{
                    name: '数量',
                    type: 'bar',
                    data: <%=date%>
                }]
            };

            myChart.setOption(option);
        }

    );
</script>
</body>
</html>
