
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.mongodb.connection.ClusterSettings" %>
<%@ page import="static java.util.Arrays.asList" %>

<%@ page import="java.util.Arrays" %>

<%@ page import="com.mongodb.client.MongoClient" %>
<%@ page import="com.mongodb.client.MongoClients" %>
<%@ page import="com.mongodb.client.MongoDatabase" %>
<%@ page import="org.bson.Document" %>
<%@ page import="com.mongodb.client.MongoCollection" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.util.ArrayList" %>
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
        <%  int[] numArray = {65,73,79,54};%>

        <% for (int j : numArray) {
            out.print("<p>" + j + "</p>");
        }%>

    </div>
    <h2 class="mt-4 btn-danger text-center">Client Name is : <%= request.getAttribute("clientName")%></h2>
    <h2 class="mt-4 btn-danger text-center"><%= request.getAttribute("tournamentName")%></h2>
    <div class="text-center mt-4 border border-dark">
     <%  ArrayList<String> list = (ArrayList<String>) request.getAttribute("playerNames");%>
           <%
               for (String player : list) {
                   out.print("<p>" +  player + "</p>");
                   }
           %>

    </div>
</div>
</body>
</html>
