<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Calendar</title>
    <meta content="text/html;charset=utf-8" http-equiv="Content-Type">
    <meta content="utf-8" http-equiv="Content-Type">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="index.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"></script>
    <script src="https://use.fontawesome.com/releases/v5.15.2/js/all.js" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
<h2>CalendarPage</h2>
    <form method="get" action="calendarclbs">
    <input class="btn btn-danger mt-4" type="submit" value="CLDR Data"/>
    </form>
    <% Object getMsg = request.getAttribute("msgData");%>
   <% if(getMsg != null){%>
    <a href="https://accounts.google.com/o/oauth2/v2/auth?client_id=502305783354-sr48jg1hnse1lehoce3au065rquob8f0.apps.googleusercontent.com&response_type=code&scope=https://www.googleapis.com/auth/calendar.calendarlist.readonly https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar.settings.readonly https://www.googleapis.com/auth/calendar.events.public.readonly&redirect_uri=http://localhost:8081/web_app_war_exploded/calendarclbs&access_type=offline" role="button">GLogin</a>
    <br>
    <form method="post" action="calendarclbs">
        <input class="btn btn-danger mt-4" type="submit" value="Get AccessToken"/>
    </form>
    <br>
      <%}%>
    <% ArrayList<String> getId = (ArrayList<String>)  request.getAttribute("setId"); %>
    <% ArrayList<String> getValue = (ArrayList<String>) request.getAttribute("setValue");%>
    <%if(getId != null || getValue != null){
     for(int i = 0; i < Objects.requireNonNull(getId).size(); i ++){%>
        <ul class="list-group">
            <li class="list-group-item list-group-item-primary"><%= getId.get(i)%></li>
            <li class="list-group-item list-group-item-info"><%= getValue.get(i)%></li>
        </ul>
    <%}}%>
</div>
</body>
</html>
