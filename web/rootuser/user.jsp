<%@ page import="jdbc.Jdbc" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: 李凌耀
  Date: 2017/12/7
  Time: 14:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    Jdbc instance = Jdbc.getInstance();
    String checkin = request.getParameter("checkin");
    if(checkin != null) {
        String s = "select max(cardid) s from readers";
        ResultSet select = instance.select(s);
        int c = 0;
        try {
            select.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        String tmp = null;
        try {
            tmp = select.getString("s");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if(tmp != null)
            c = Integer.parseInt(tmp);
        String caid = request.getParameter("caid");
        String sqls = "UPDATE readers set cardname='图书证',cardid="+c+"+1,level="+caid+",day=curdate() where readerid="+checkin;
        instance.insertUpdateDelete(sqls);
        instance.insertUpdateDelete("delete from lossreporting where readerid="+checkin);
    }
    String name = request.getParameter("name");
    if(name == null) name="";
    String id = request.getParameter("id");
    if(id == null) id="";
    String sql = "SELECT * FROM readers INNER JOIN user ON readers.readerid=user.readerid";
    if(!name.equals("") || !id.equals(""))
    {
        sql += " where ";
        if(!name.equals(""))
            sql += "readername='"+name+"' ";
        if(!id.equals(""))
            sql += "readers.readerid=" + id + " ";
    }
    System.out.println(sql);
    ResultSet select = instance.select(sql);
%>
<html>
<head>
    <title>查询和统计读者信息</title>
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
    <section class="box special features">
        <form action="user.jsp" method="post">
            <div class="row uniform 50%" style="border-bottom: 1px solid #CCC;padding-bottom: 0.5em;">
                <div class="12u(mobilep)" style="width: 10%">
                    <p style="margin: 0.5em 0 0 1em;">编号：</p>
                </div>
                <div class="6u 12u(mobilep)" style="width: 20%;padding-left: 0">
                    <input id="id" name="id" value="" placeholder="编号" type="text">
                </div>
                <div class="12u(mobilep)" style="width: 10%">
                    <p style="margin: 0.5em 0 0 1em;">姓名：</p>
                </div>
                <div class="6u 12u(mobilep)" style="width: 20%;padding-left: 0">
                    <input id="name" name="name" value="" placeholder="姓名" type="text">
                </div>
                <div class="12u(mobilep)" style="width: 5%">
                    <input class="button special icon fa-search" type="submit" value="搜索">
                </div>
            </div>
        </form>
        <div class="table-wrapper">
            <table class="alt">
                <thead>
                    <tr>
                        <th>readerid</th>
                        <th>name</th>
                        <th>sex</th>
                        <th>birthday</th>
                        <th>phone</th>
                        <th>cardname</th>
                        <th>cardid</th>
                        <th>level</th>
                        <th>day</th>
                        <th>username</th>
                        <th>password</th>
                        <th>图书证办理</th>
                    </tr>
                </thead>
                <tbody>
                    <%try {
                        while(select.next()){%>
                        <tr>
                            <%
                                String tmpid = select.getString("readerid");
                            %>
                            <td><%=tmpid%></td>
                            <td><%=select.getString("readername")%></td>
                            <td><%=select.getString("sex")%></td>
                            <td><%=select.getString("birthday")%></td>
                            <td><%=select.getString("phone")%></td>
                            <%
                                String tmp = select.getString("cardname");
                            %>
                            <td><%=tmp%></td>
                            <td><%=select.getString("cardid")%></td>
                            <td><%=select.getString("level")%></td>
                            <td><%=select.getString("day")%></td>
                            <td><%=select.getString("username")%></td>
                            <td><%=select.getString("psw")%></td>
                            <%if(tmp == null){%>
                                <form action="user.jsp" method="post">
                                    <td>
                                        <select name="caid" style="width: 6em;height: 2em;margin-bottom: 0.5em;">
                                            <option value="1">vip 1</option>
                                            <option value="2">vip 2</option>
                                            <option value="3">vip 3</option>
                                        </select>
                                        <input type="submit" value="办理借书证" class="button small"/>
                                    </td>
                                    <input type="hidden" name="checkin" value="<%=tmpid%>">
                                </form>
                            <%}else {%>
                                <td></td>
                            <%}%>
                        </tr>
                        <%}
                        }catch (SQLException e){
                        }%>
                </tbody>
            </table>
        </div>
    </section>
</section>
</body>
</html>
