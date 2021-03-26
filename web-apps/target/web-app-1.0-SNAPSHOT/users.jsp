<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link type="text/css" rel="stylesheet" href="index.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"
                integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
                crossorigin="anonymous"></script>
        <script src="https://use.fontawesome.com/releases/v5.15.2/js/all.js" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <title>Users</title>
</head>
<body>
<div class="container btn-light">
   <form action="users" method="get">
       <label class="mb-2">
           <input type="text" name="name">
       </label>
       <br>
       <input class="btn btn-danger btn mt-4" type="submit" value="getUser">
   </form>
   <% Object displayName = request.getAttribute("username");%>
   <% if (displayName != null){%>
       <h2><%=displayName%></h2>
   <%}%>
</div>
<script type="text/javascript">
    console.log("inside script");
    let stUserName = localStorage.getItem('userName');
    let stUserPass = localStorage.getItem('userPass');
    if(stUserName != null || stUserPass != null){
        console.log( "usersInfo is " + stUserPass + stUserName);
    }
</script>
</body>
</html>
