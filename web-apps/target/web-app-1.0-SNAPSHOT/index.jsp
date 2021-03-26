<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="google-signin-scope" content="https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile openid">
    <meta name="google-signin-client_id" content="502305783354-sr48jg1hnse1lehoce3au065rquob8f0">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="index.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"></script>
    <script src="https://use.fontawesome.com/releases/v5.15.2/js/all.js" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body style="height: 1300px;">
<div class="pos-f-t">
    <nav class="navbar navbar-dark bg-dark">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div id="userName"></div>
        <div id="userLastName"></div>
        <div id="userId"></div>
        <div id="displayData"></div>
        <div id="userImage"></div>
    </nav>
    <div class="collapse" id="navbarToggleExternalContent">
        <div class="bg-dark p-1">
               <p><label><i class="fas fa-home mr-3 ml-2"></i></label><a class="navbar-brand" href="${pageContext.request.contextPath}/">Home</a></p>
               <p><label><i class="fas fa-rainbow mr-3 ml-2"></i></label><a class="navbar-brand" href="${pageContext.request.contextPath}/tours.jsp">Tours</a></p>
               <p><label><i class="fas fa-users mr-3 ml-2"></i></label><a class="navbar-brand" href="${pageContext.request.contextPath}/players.jsp">Golf Players</a></p>
               <p><label><i class="fas fa-users mr-3 ml-2"></i></label><a class="navbar-brand" href="${pageContext.request.contextPath}/soccers.jsp">Soccer Players</a></p>
               <p><label><i class="fas fa-calendar mr-3 ml-2"></i></label><a class="navbar-brand" href="${pageContext.request.contextPath}/calendarclbs.jsp">Calendar</a></p>
               <p><label><i class="fas fa-users mr-3 ml-2"></i></label><a class="navbar-brand" href="${pageContext.request.contextPath}/users.jsp">Users</a></p>
               <p><label><i class="fas fa-login mr-3 ml-2"></i></label><a class="navbar-brand" href="${pageContext.request.contextPath}/login.jsp">Login</a></p>
        </div>
    </div>
</div>
<div class="container mt-4 text-center pt-4 calcMain">
    <h2>Golf Clubs Login</h2>
    <% if (request.getAttribute("clientName") == null){ %>
        <p>client</p>
    <%} else {%>
    <%Object usrName = request.getAttribute("clientName");%>
    <p id="dispInfo" >Welcome  <%=usrName%> </p>
    <script type="text/javascript">
        function signedInUser(){
            console.log("info hit");
            let testData = <%=usrName%>;
            console.log(testData)
            let userName = document.getElementById("dispInfo").innerHTML;
            let mduserName = userName.substring(9, userName.length);
            console.log( "paramName is " + mduserName);
            localStorage.setItem('userName', mduserName);
        }
        signedInUser();
    </script>
    <%}%>
    <form action="login" method="get">
        <label class="mb-2" >
            <input type="text" name="name">
        </label>
        <label class="mb-2">
            <input type="text" name="password">
        </label>
        <br>
        <input type="submit" class="text-center mb-3 btn btn-info border-dark newBtn" value="Login">
        <br>
        <label>
            <input type="checkbox" name="signUp" value="signUp">
            <span class="checkmark">Create an Account</span>
        </label>
        <input type="submit" class="text-center mb-3 btn btn-danger border-dark newBtn" value="SignUp">
    </form>

    <div class="g-signin2" style="width: 280px;margin-left: 45px;" data-onsuccess="onSignIn" data-theme="dark"></div>
    <a class="btn btn-danger mb-2 mt-2" style="width: 280px;border: #616161; border-radius: 15px;" href="${pageContext.request.contextPath}/" onclick="signOut();">Sign out</a>
</div>
<script>
    function onSignIn(googleUser) {
        // Useful data for your client-side scripts:
        let profile = googleUser.getBasicProfile();
        let id_token = googleUser.getAuthResponse().id_token;
        let keepAccessToken = googleUser.getAuthResponse().acess_token;
        console.log(id_token);
        console.log(keepAccessToken);


        let usrFirst = document.getElementById("userName");
            usrFirst.title = profile.getGivenName();
        let usrLName = document.getElementById("userLastName");
            usrLName.title = profile.getFamilyName();
        let usrId_ = document.getElementById("userId");
            usrId_.title = profile.getId();

        let textFive = document.createElement("img");
        let getUserImg = document.getElementById("userImage");
        textFive.height = 100;
        textFive.width = 100;
        textFive.title = "userImageShow";
        textFive.src = profile.getImageUrl();

        localStorage.setItem('userName', usrFirst.title);
        localStorage.setItem('userLName', usrLName.title);
        localStorage.setItem('userId',  usrId_.title);
        localStorage.setItem('userAccessToken',  keepAccessToken);

        getUserImg.appendChild(textFive);
        let dsPlData = document.getElementById("displayData");
            dsPlData.style.color = "white";
            dsPlData.style.marginLeft = "800px";
            dsPlData.innerText = "Hello " + usrFirst.title + " " + usrLName.title + " " + usrId_.title;
    }
    function signOut() {
        let auth2 = gapi.auth2.getAuthInstance();
        auth2.signOut().then(function () {
            console.log('User signed out.');
        });
    }

</script>

<script src="https://apis.google.com/js/platform.js"  async defer></script>
<footer style="position: absolute; margin-left: -70px; margin-right: -60px; bottom: 0;">
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
</body>
</html>