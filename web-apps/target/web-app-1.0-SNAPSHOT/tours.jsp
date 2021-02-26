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
    <p><%= request.getAttribute("trPhDescript")%></p>
    <%ArrayList<String> listTours = (ArrayList<String>) request.getAttribute("golfTours");%>
<%--    <%ArrayList<String> listTrsPhotos = (ArrayList<String>) request.getAttribute("golfTrPhotos");%>--%>
    <%ArrayList<String> listToursPhs = new ArrayList<>();
        listToursPhs.add("https://i.picsum.photos/id/353/6016/3376.jpg?hmac=nxXyXOzuXlHPPWsAwB2kOv-rQTBz4Brg6u49weMZqOw");
        listToursPhs.add("https://i.picsum.photos/id/393/2560/1707.jpg?hmac=4gZo23a5TRIswQ6myyjh3EcK7lVgvQz1l49LKrNo_po");
        listToursPhs.add("https://i.picsum.photos/id/459/2310/1534.jpg?hmac=3GuIBHCecDx0ymJJzLe_lGSQDAlbf-PiXYnCc7iM2MI");
        listToursPhs.add("https://i.picsum.photos/id/542/3648/2736.jpg?hmac=NjN7FoNzU50GYV3TjY5bGwdjqHX3YxTjAMLALGvitcc");
        listToursPhs.add("https://i.picsum.photos/id/563/3872/2592.jpg?hmac=0IrQ3rYsIWh7eNXUWlmVPJCOZt1V2vgenFWm6a-2Pz0");
        listToursPhs.add("https://i.picsum.photos/id/840/2424/3620.jpg?hmac=EQAGAcDjg4cRVQyuezhKjaSc-roDb3gfyvKfo60BPgY");
    %>
    <div class="row">
    <%for (int i =0; i < listTours.size(); i++) { %>
        <div class="col-lg-8 btn-light px-1 mx-1 mb-2 border border-dark trStyle"
             style="height: 500px; border-radius: 15px; background-color: #e7dbcc">
             <h2><%=listTours.get(i)%></h2>
            <img src="<%=listToursPhs.get(i)%>" alt="tourImg" style="width: 200px; height: 250px;"/>
        </div>
        <%} %>
    </div>
</div>

</body>
</html>
