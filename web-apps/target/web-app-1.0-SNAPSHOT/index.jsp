<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="./index.css">
    <title>Angelique-web-app</title>
</head>
<body style="height: 1300px;
    background-image: url(./images/golfMain.jpg);
    background-repeat: no-repeat;
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;">
<div>
    <nav class="navbar navbar-dark bg-dark" style="height: 60px; color: #c6cece">
        <div style="text-align: center; margin: auto">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">Home</a>
        <a class="navbar-brand" href="${pageContext.request.contextPath}/calculate">Login</a>
        <a class="navbar-brand" href="${pageContext.request.contextPath}/tours">Tours</a>
        </div>
    </nav>
<div class="container mt-4 text-center pt-4 calcMain">
    <h2>Calculator app</h2>
    <form action="calculate" method="post">
    <label class="mb-2">
        <input type="text" name="numOne">
    </label>
        <br>
    <label class="mb-2">
        <input type="text" name="numTwo">
    </label>
        <br>
        <input type="submit" class="text-center mb-3 btn btn-danger border-dark newBtn" value="Calculate">
    </form>

</div>
<div class="container mt-4 text-center pt-4 calcMain">
    <h2>ToursInfo</h2>
    <form action="tours" method="post">
        <input type="submit" class="text-center mb-3 btn btn-dark border-dark newBtn" value="ToursInfo">
    </form>
</div>
<br/>
</div>
</body>
</html>