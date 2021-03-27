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
    <title>Login</title>
</head>
<body style="height: 1300px;">
<div class="pos-f-1t">
    <nav class="navbar navbar-dark bg-dark">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
    </nav>
    <div class="collapse" id="navbarToggleExternalContent">
        <div class="bg-dark p-1">
            <p><label><i class="fas fa-home mr-3 ml-2"></i></label><a class="navbar-brand" href="${pageContext.request.contextPath}/">Home</a></p>
            <p><label><i class="fas fa-rainbow mr-3 ml-2"></i></label><a class="navbar-brand" href="${pageContext.request.contextPath}/tours.jsp">Tours</a></p>
            <p><label><i class="fas fa-users mr-3 ml-2"></i></label><a class="navbar-brand" href="${pageContext.request.contextPath}/players.jsp">Players</a></p>
        </div>
    </div>
</div>
<div class="container" style="margin-top: 100px">
    <h2>LoginPage</h2>
    <div id="displayData"></div>
<%--    <button class="btn btn-info mt-4" onclick="userDisplayInfo()">userInfo</button>--%>
</div>
<footer style="position: absolute; margin-left: -50px; margin-right: -60px; bottom: 0;">
    <div class='container-fluid'>
        <div class="card">
            <div class="heading text-center">
                <div class="head1">Just Scratching the Surface</div>
                <p class="bdr"></p>
            </div>
            <div class="card-body">
                <div class="row m-0 pt-5">
                    <div class="card col-12 col-md-3">
                        <div class="card-content"> <i class="fas fa-hand-holding-usd fa-3x"></i>
                            <div class="card-title"> RECHARGE REPEAT CUSTOMER </div>
                            <p><small>Save customers' cards for future phone orders</small></p>
                            <div class="learn-more">
                                <p> <small> LEARN MORE <label><i class="fas fa-angle-right"></i></label> </small> </p>
                            </div>
                        </div>
                    </div>
                    <div class="card col-12 col-md-3">
                        <div class="card-content"> <i class="far fa-handshake fa-3x"></i>
                            <div class="card-title"> ACCEPT ELECTRONIC CHECK </div>
                            <p><small>Save customers' cards for future phone orders</small></p>
                            <div class="learn-more">
                                <p> <small> LEARN MORE <label><i class="fas fa-angle-right"></i></label> </small> </p>
                            </div>
                        </div>
                    </div>
                    <div class="card col-12 col-md-3">
                        <div class="card-content"> <i class="fas fa-mobile-alt fa-3x"></i>
                            <div class="card-title"> STREAMLINE PHONE PAYMENTS </div>
                            <p><small>Save customers' cards for future phone orders</small></p>
                            <div class="learn-more">
                                <p> <small> LEARN MORE <label><i class="fas fa-angle-right"></i></label> </small> </p>
                            </div>
                        </div>
                    </div>
                    <div class="card col-12 col-md-3">
                        <div class="card-content"> <i class="fas fa-user-secret fa-3x"></i>
                            <div class="card-title"> STAY<br /> SECURE </div>
                            <p><small>Save customers' cards for future phone orders</small></p>
                            <div class="learn-more">
                                <p> <small> LEARN MORE <label><i class="fas fa-angle-right"></i></label> </small> </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-footer row m-0">
                <p> <label> <i class="fas fa-phone fa-rotate-90 text-primary"></i> </label> 800-601-0230</p>
                <div>
                    <p> <small class="follow-text">FOLLOW US ON SOCIAL MEDIA</small> <label class="footer-right"> <i class="fab fa-instagram"></i> <i class="fab fa-facebook-square"></i> <i class="fab fa-linkedin"></i> <i class="fab fa-twitter-square"></i> </label> </p>
                </div>
            </div>
        </div>
    </div>
</footer>
<script>
    setTimeout(() => {
        if(localStorage.getItem('userName') != null) {
            let getName = localStorage.getItem('userName');
            document.getElementById("displayData").innerText = "Username is " + getName;
           if(localStorage.getItem('userLName') != null){
               let getLName = localStorage.getItem('userLName');
               let getId = localStorage.getItem('userId');
               let getAccessToken = localStorage.getItem('userAccessToken');
               document.getElementById("displayData").innerText = "Username is " + getName +
                     " userLastName " + getLName
                   + " userid " + getId
                   + " userAccessToken " + getAccessToken;
           }
        }else{
            document.getElementById("displayData").innerText = "Please Login ...";
            setTimeout(() => {
                location.replace("http://localhost:8081/web_app_war_exploded/");
            },2000);
        }
    },2000);

</script>
</body>
</html>
