
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>upImage</title>
</head>
<body>
<h2>upImg page and <%=request.getSession().getAttribute("newPath")%></h2>
<% String newImage = "/target/images/bunny.jpeg";
   String ngImage = request.getContextPath() + newImage;
   System.out.println(ngImage);
%>
<img alt="uploaded image" src="./images/golf-0.jpg" style="width: 250px; height: 300px;"/>
<img alt="uploaded image" src="./images/bunny.jpeg" style="width: 250px; height: 300px;"/>
</body>
</html>
