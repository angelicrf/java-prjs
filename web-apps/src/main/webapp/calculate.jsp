<%--
  Created by IntelliJ IDEA.
  User: bcuser
  Date: 2/20/21
  Time: 3:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="index.css">
    <title>calculator</title>
</head>
<body class="btn-light">
<div class="container">
<h2 class="btn-danger text-center ">The result is: <%= request.getAttribute("numCalc")%></h2>
    <div class="border border-dark btn-outline-secondary mt-4 text-center">
        <%  int[] numArray = {65,73,79,54}; %>
        <% for (int j : numArray) {
            out.print("<p> " + j + " </p>");
        }%>
    </div>
</div>
</body>
</html>
