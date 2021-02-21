<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="index.css">
    <title>Angelique-web-app</title>
</head>
<body class="btn-info">
<div class="container btn-primary mt-4 text-center pt-4 calcMain">
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
<br/>
</body>
</html>