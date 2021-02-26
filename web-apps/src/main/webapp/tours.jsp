<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="./index.css">
    <title>tours</title>
</head>
<body style="background-color: #ceceb8">
<h1>Tours Info</h1>
<div class="container mt-4">
    <p><%= request.getAttribute("tourDescript")%></p>
    <%ArrayList<String> listTours = (ArrayList<String>) request.getAttribute("golfTours");%>
<%--    <%ArrayList<String> listTrsPhotos = (ArrayList<String>) request.getAttribute("golfTrPhotos");%>--%>
    <div class="row">
    <%for (int i =0; i < listTours.size(); i++) { %>
        <div class="col-lg-8 btn-light px-1 mx-1 mb-2 border border-dark trStyle"
             style="height: 500px; border-radius: 15px; background-color: #e7dbcc">
             <h2><%=listTours.get(i)%></h2>
            <img src="./images/golf-<%=i%>.jpg" alt="tourImg" style="width: 650px; height: 300px; border-radius: 10px;"/>
        </div>
        <%} %>
    </div>
</div>

</body>
</html>
