<%--
  Created by IntelliJ IDEA.
  User: bcuser
  Date: 5/18/21
  Time: 4:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Comments</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="google-signin-scope" content="https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile openid">
    <meta name="google-signin-client_id" content="502305783354-sr48jg1hnse1lehoce3au065rquob8f0">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="index.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"></script>
    <script src="https://js.pusher.com/7.0/pusher.min.js"></script>
    <script src="https://use.fontawesome.com/releases/v5.15.2/js/all.js" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #9E9E9E">
    <div class="container" style="margin-top: 30px;">
        <form style="text-align: center;" method="get" action="comments" id="clComments">
            <input style="text-align: center; width: 250px; border-radius: 20px;" type="submit" name="allReviews" value="Reviews" class="btn-danger btn">
        </form>
    </div>
 <%if(request.getAttribute("seeReviews") != null){%>
    <% Object showRev = request.getAttribute("seeReviews");%>
   <div style="background-color: red; color: #1f1fc6">All received <%=showRev%></div>
 <%}%>
</body>
</html>
