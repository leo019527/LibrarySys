<%@ page import="jdbc.Jdbc" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: 李凌耀
  Date: 2017/12/7
  Time: 16:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    Jdbc instance = Jdbc.getInstance();
    String bookid = request.getParameter("bookid");
    String bookname = request.getParameter("bookname");
    String author = request.getParameter("author");
    String publishing = request.getParameter("publishing");
    String categoryid = request.getParameter("categoryid");
    String price = request.getParameter("price");
    String quantity = request.getParameter("quantity");
    String sql = "INSERT INTO books VALUES('"+bookid
            +"','"+bookname+"','"+author+"','"
            +publishing+"',"+categoryid+","+price+",now(),"+quantity+",0,0)";
    System.out.println(sql);
    instance.insertUpdateDelete(sql);
    String sql2 = "SELECT * FROM books ORDER BY datein DESC";
    ResultSet selected = instance.select(sql2);
    String[] cat = {"计算机技术","自然科学","医学","农林","建筑","科普","通信","化学","物理","美文"};
%>
<html>
<head>
    <title>图书入库</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="../assets/css/main.css" />
    <script>
        function check() {
            var id = document.getElementById("id").value;
            if(id == ""){
                alert("编号不能为空！");
                return false;
            }
            var name = document.getElementById("bookname").value;
            if(name == ""){
                alert("姓名不能为空！");
                return false;
            }
            var author = document.getElementById("author").value;
            if(author == ""){
                alert("作者不能为空！");
                return false;
            }
            var publishing = document.getElementById("publishing").value;
            if(publishing == ""){
                alert("出版社不能为空！");
                return false;
            }
            var categoryid = document.getElementById("categoryid").value;
            if(categoryid == ""){
                alert("书籍分类不能为空！");
                return false;
            }
            var price = document.getElementById("price").value;
            if(price == ""){
                alert("价格不能为空！");
                return false;
            }
            var quantity = document.getElementById("quantity").value;
            if(quantity == ""){
                alert("数量不能为空！");
                return false;
            }
        }
    </script>
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
<section id="main" class="container"style="width:70em">
    <section class="box special features">
        <form action="bookin.jsp" method="post" onsubmit="return check()">
            <div class="row uniform 50%" style="border-bottom: 1px solid #CCC;padding-bottom: 0.5em;">
                <div class="6u 12u(mobilep)" style="width: 12%;padding-left: 1em;">
                    <input id="bookid" name="bookid" value="" placeholder="编号" type="text">
                </div>
                <div class="6u 12u(mobilep)" style="width: 12%;padding-left: 1em;">
                    <input id="bookname" name="bookname" value="" placeholder="书名" type="text">
                </div>

                <div class="6u 12u(mobilep)" style="width: 12%;padding-left: 1em;">
                    <input id="author" name="author" value="" placeholder="作者" type="text">
                </div>

                <div class="6u 12u(mobilep)" style="width: 12%;padding-left: 1em;">
                    <input id="publishing" name="publishing" value="" placeholder="出版社" type="text">
                </div>
                <div class="12u(mobilep)" style="width: 12%">
                    <select id="categoryid" name="categoryid">
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

                <div class="6u 12u(mobilep)" style="width: 12%;padding-left: 1em;">
                    <input id="price" name="price" value="" placeholder="价格" type="text">
                </div>

                <div class="6u 12u(mobilep)" style="width: 15%;padding-left: 1em;">
                    <input id="quantity" name="quantity" value="" placeholder="入库数量" type="text">
                </div>
                <div class="12u(mobilep)" style=" width: 6%">
                    <input class="button special icon fa-search" value="入库" type="submit">
                </div>
            </div>
        </form>
        <div class="table-wrapper">
            <table class="alt">
                <thead>
                    <tr>
                        <th>book-id</th>
                        <th>book-name</th>
                        <th>author</th>
                        <th>publishing</th>
                        <th>price</th>
                        <th>date-in</th>
                        <th>quantity-in</th>
                        <th>quantity-out</th>
                        <th>quantity-loss</th>
                        <th>category</th>
                    </tr>
                </thead>
                <tbody>
                <%try{
                    while (selected.next()) {%>
                <tr>
                    <td><%=selected.getString("bookid")%></td>
                    <td><%=selected.getString("bookname")%></td>
                    <td><%=selected.getString("author")%></td>
                    <td><%=selected.getString("publishing")%></td>
                    <td><%=selected.getString("price")%></td>
                    <td><%=selected.getString("datein")%></td>
                    <td><%=selected.getString("quantity_in")%></td>
                    <td><%=selected.getString("quantity_out")%></td>
                    <td><%=selected.getString("quantity_loss")%></td>
                    <td><%=cat[Integer.parseInt(selected.getString("categoryid"))-1]%></td>
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
