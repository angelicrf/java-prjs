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
    <script src="https://js.pusher.com/7.0/pusher.min.js"></script>
    <script src="https://use.fontawesome.com/releases/v5.15.2/js/all.js" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body style="height: 4500px;">
<div class="pos-f-t">
    <nav class="navbar navbar-dark bg-dark">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <span id="userName"></span>
        <span id="gUserName"></span>
        <span id="userLastName"></span>
        <span id="userId"></span>
        <span id="displayData"></span>
        <span id="userImage"></span>
    </nav>
    <div class="collapse" id="navbarToggleExternalContent">
        <div class="bg-dark p-1">
               <p><label><i class="fas fa-home mr-3 ml-2"></i></label><a class="navbar-brand" href="${pageContext.request.contextPath}/">Home</a></p>
               <p><label><i class="fas fa-rainbow mr-3 ml-2"></i></label><a class="navbar-brand" href="${pageContext.request.contextPath}/tours.jsp">Tours</a></p>
               <p><label><i class="fas fa-golf-ball mr-3 ml-2"></i></label><a class="navbar-brand" href="${pageContext.request.contextPath}/players.jsp">Golf Players</a></p>
               <p><label><i class="fas fa-futbol mr-3 ml-2"></i></label><a class="navbar-brand" href="${pageContext.request.contextPath}/soccers.jsp">Soccer Players</a></p>
               <p><label><i class="fas fa-calendar mr-3 ml-2"></i></label><a class="navbar-brand" href="${pageContext.request.contextPath}/calendarclbs.jsp">Calendar</a></p>
               <p><label><i class="fas fa-user-circle mr-3 ml-2"></i></label><a class="navbar-brand" href="${pageContext.request.contextPath}/login.jsp">My Account</a></p>
               <p><label><i class="fas fa-user-circle mr-3 ml-2"></i></label><a class="navbar-brand" href="${pageContext.request.contextPath}/upImg.jsp">Gain Points</a></p>
        </div>
    </div>
</div>
<div class="container mt-4 text-center pt-4 calcMain">
    <h2>Golf Clubs Login</h2>
    <div id="stUserName"></div>
    <dialog open style="position: fixed; left: 0; top: 0; width: 320px; margin-left: 10px;">
        <div class="alert alert-warning" role="alert">
            <img src="images/golf-1.jpg" style="width: 50px; height: 50px; margin-left: -15px;"  alt="logo"/><span style="font-size: small; padding-left: 8px;">Subscribe to Golf Clubs Events?</span>
            <br>
            <button style="margin-top: -13px;" id="sbsOk">Ok</button>
            <button style="margin-left: 15px; margin-top: -13px;" id="sbsNo">No</button>
        </div>
    </dialog>
   <script type="text/javascript">
        console.log("newLogin local");
        let isSubscribe = false;
        document.getElementById("sbsOk").addEventListener('click', () => {
            document.querySelector('dialog').removeAttribute('open');
            localStorage.setItem("subscribed", "yes");
            return isSubscribe = true;
        });
        document.getElementById("sbsNo").addEventListener('click', () => {
            document.querySelector('dialog').removeAttribute('open');
            localStorage.setItem("subscribed", "no");
            return isSubscribe = false;
        });
        if(localStorage.getItem("subscribed")){
            document.querySelector('dialog').removeAttribute('open');
        }
       if(isSubscribe) {
           console.log("is cubsribed...");
           let pusher = new Pusher('f2e9aaeace529c524f7e', {
               cluster: 'us3'
           });
           let channel = pusher.subscribe('golf-clubs');
           channel.bind('golf-evt-clubs', function (data) {
               console.log("inside pusher....");
               alert('An event was triggered with message: channel Golf-Events ');
           });
       }
        if(localStorage.getItem("userName") != null){
            let stDataUser = localStorage.getItem("userName");
            document.getElementById("stUserName").innerText = "Welcome " + stDataUser;
        }
    </script>
    <% if (request.getAttribute("clientName") == null){ %>
        <div id="nonClient"></div>
        <script type="text/javascript">
            if(localStorage.getItem("userName") == null) {
                document.getElementById("nonClient").innerText = "client";
            }
        </script>
    <%} else {%>
    <%Object usrName = request.getAttribute("clientName");%>
    <div id="fromUserName" data-value="<%=usrName%>"></div>
    <script>
        let compareName = document.getElementById("fromUserName").getAttribute("data-value");
        console.log("pusher start..");
        if(localStorage.getItem("userName") !== compareName ){
            document.getElementById("fromUserName").innerText = Welcome + compareName;
        }
    </script>
    <div id="dispInfo" data-value=<%=usrName%>></div>
    <script type="text/javascript">
        function signedInUser(){
            console.log("info hit");
            let userName = document.getElementById("dispInfo").getAttribute("data-value");
            console.log( "paramName is " + userName);
            localStorage.setItem('userName', userName);
            localStorage.setItem('userLogin', "logged");
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
        let keepAccessToken = googleUser.getAuthResponse().access_token;
        console.log(id_token);
        console.log(keepAccessToken);


        let usrFirst = document.getElementById("gUserName");
            usrFirst.title = profile.getGivenName();
        let usrLName = document.getElementById("userLastName");
            usrLName.title = profile.getFamilyName();
        let usrId_ = document.getElementById("userId");
            usrId_.title = profile.getId();

        let textFive = document.createElement("img");
        let getUserImg = document.getElementById("userImage");
        textFive.borderRadius = "50%";
        textFive.height = 50;
        textFive.width = 50;
        textFive.title = "userImageShow";
        textFive.src = profile.getImageUrl();
        getUserImg.borderRadius = "50%";
        getUserImg.height = 50;
        getUserImg.width = 50;

        localStorage.setItem('gUserName', usrFirst.title);
        localStorage.setItem('userLName', usrLName.title);
        localStorage.setItem('userId',  usrId_.title);
        localStorage.setItem('userAccessToken',  keepAccessToken);
        localStorage.setItem('gUserImage', textFive.src);
        localStorage.setItem('userLogin', "logged");

        getUserImg.appendChild(textFive);
        let dsPlData = document.getElementById("displayData");
            dsPlData.style.color = "white";
           // dsPlData.style.marginLeft = "700px";
            dsPlData.innerText = "Hello " + usrFirst.title + " " + usrLName.title + " " + usrId_.title;
        let pusher = new Pusher('f2e9aaeace529c524f7e', {
            cluster: 'us3'
        });
        let channel = pusher.subscribe('my-channel');
        setTimeout(() => {
            channel.bind('my-event', function (data) {
                alert('An event was triggered with message: ' + data.message);
            }, 2000);
        });
    }
    function signOut() {
        let auth2 = gapi.auth2.getAuthInstance();
        auth2.signOut().then(function () {
            console.log('User signed out.');
        });
        if(localStorage.getItem("userLName") != null){
            localStorage.removeItem("userLName");
            localStorage.removeItem("userLogin");
            localStorage.removeItem("userId");
            localStorage.removeItem("userAccessToken");
            localStorage.removeItem("gUserName");
            localStorage.removeItem("gUserImage");
        }
        if(localStorage.getItem("userName") != null){
            localStorage.removeItem("userName");
            localStorage.removeItem("userLogin");
        }
    }

</script>
<script src="https://apis.google.com/js/platform.js"  async defer></script>
<div style="margin-top: 30px;">
<div style="margin: 0 auto; width: 1200px; height: 550px;">
    <div class="d-inline-flex p-3 bg-secondary text-white">
        <div class="row" style="width: 1200px;">
            <div class="col-sm bg-info">
                <img style="margin: 0 auto; width: 300px; height: 300px;" src="images/golf-2.jpg" alt="firstTitle"/>
                <h2>Title One</h2>
                <div style="width: 300px;" class="p-2">Just answer a few questions and your event website will be online in minutes, registering players and sponsors</div></div>
            <div class="col-sm bg-warning">
                <img style="margin: 0 auto; width: 300px; height: 300px;" src="images/golf-3.jpg" alt="firstTitle" />
                <h2>Title Two</h2>
                <div style="width: 300px;" class="p-2">Prizes and contests are essential for creating excitement and generating revenue for your golf event. Perfect Golf Event is the one-stop shop</div></div>
            <div class="col-sm bg-primary">
                <img style="margin: 0 auto; width: 300px; height: 300px;" src="images/golf-4.jpg" alt="firstTitle"/>
                <h2>Title Three</h2>
                <div style="width: 300px;" class="p-2">Our proven online and hands-on support helps you attract more players, sign more sponsors and deliver a Perfect Golf Event</div></div>
        </div>
    </div>
</div>
</div>
<div style="margin-top: 30px;">
    <div style="margin: 0 auto; width: 1200px; height: 550px;" class="btn-light">
        <div class="d-inline-flex p-3 bg-secondary text-white">
            <div class="row" style="width: 1200px;">
                <div id="fClassCol" class="col-sm">
                    <i style="margin: 0 auto; width: 300px; height: 300px;" class="fas fa-home"></i>
                    <div style="width: 300px;">
                        <h3>Par Package</h3>
                        <div class="p-2 text-white">Custom Golf Event Website</div>
                        <h2 style="color: #1f1fc6">FREE</h2>
                        <div class="p-2 text-white">No Credit Card Required to Get Started:</div>
                        <ul class="text-white">
                            <li>Accept Online Player/Sponsor Registrations</li>
                            <li>Outline Player and Sponsor Packages</li>
                            <li>Accept Donations</li>
                            <li>Fast and Easy Player Pairings</li>
                            <li>Track Revenue/Expenses</li>
                            <li>Communicate and Promote Event Details</li>
                            <li>Up to the Minute Reports</li>
                            <li>And Much More…</li>
                        </ul>
                        <br>
                        <input id="fBtnOne" width="110px" class="btn btn-primary" type="button" value="Compare Features"/>
                        <input id="fBtnTwo" style="margin-left: 20px" width="110px" class="btn btn-danger" value="Get Started" type="button" />
                    </div>
                </div>
                <div id="sClassCol" class="col-sm">
                    <i style="margin: 0 auto; width: 300px; height: 300px;" class="fas fa-home"></i>
                    <h3>Birdie Package</h3>
                    <div class="p-2 text-white">Custom, Full-Feature Website</div>
                    <h2 style="color: #1f1fc6">$246</h2>
                    <div style="width: 300px;" class="p-2">
                        <div class="text-white p-2">Includes everything in the Par Package plus</div>
                        <ul class="text-white">
                            <li>Ability to Feature Sponsor logos</li>
                            <li>Custom Top Banner on the Home Page, created by Perfect Golf Event Design Team</li>
                            <li>Quick Player Pairings</li>
                            <li>Free Domain Registration - Custom Domain Name (example: yourgolfevent.com)</li>
                            <li>Access Online Marketing Tools, Upload Lists and Email</li>
                            <li>Collect Payments Fast and Easy on the day of your event with our NEW Quick Pay option</li>
                        </ul>
                        <br>
                    <input id="sBtnOne" width="110px" class="btn btn-primary" type="button" value="Compare Features"/>
                    <input id="sBtnTwo" width="110px" class="btn btn-danger" value="Get Started" type="button" />
                    </div>
                  </div>
                <div id="tClassCol" class="col-sm">
                    <i style="margin: 0 auto; width: 300px; height: 300px;" class="fas fa-home"></i>
                    <h3>Eagle Package</h3>
                    <div style="width: 300px;" class="p-2 text-white">Full-Feature Website + Social Media Promotions + Hole-in-One Prizes</div>
                    <h2 style="color: #1f1fc6">$630</h2>
                <div style="width: 300px;" class="p-2">Includes everything in the Birdie Package plus:</div>
                 <ul>
                   <li>Custom Social Media Images to help promote your event</li>
                   <li>One-Page Guide on How to "Harness the Power of Social Media for Your Golf Event"</li>
                   <li>$10,000 Hole in One Contest</li>
                   <li>Three Other Hole-in-One Prizes!</li>
                   <li>Three Other Hole-in-One Prizes!</li>
                   <li>2’ x 6’ Sponsor "Thank You" Banner</li>
                </ul>
                    <br>
                    <input id="tBtnOne" width="110px" class="btn btn-primary" type="button" value="Compare Features"/>
                    <input id="tBtnTwo" width="110px" class="btn btn-danger" value="Get Started" type="button" />
                </div>
            </div>
        </div>
    </div>
</div>
<div style="width: 100%; height: 570px; background-color: #c3d0db; margin-top: 410px;">
    <div class="container" style="background-color: #9E9E9E">
        <div class="text-white" style="text-align: center">
            <h2>Watch your Introductory video!</h2>
        </div>
        <div style="text-align: center; position: relative;">
            <img src="./images/golf-5.jpg" style="width: 750px; height: 520px;"  alt="imgBcgrnd"/>
        </div>
            <div style="margin-top: -430px;">
               <div style="position: absolute; margin: auto; left: 0; right: 0;text-align: center; z-index: 1;">
                  <img src="./images/golfMain.jpg" style="width: 650px; border: 10px solid black; border-radius: 20px; height: 420px;"  alt="imgVideo"/>
                </div>
            </div>
            <div style="margin-top: 130px;">
                <div style="position: absolute; margin: auto; left: 0; right: 0;text-align: center; z-index: 1;">
                    <button type="button" onclick="watchVideo()">
                          <i style="width: 60px; height: 60px;" class="fa fa-play-circle"></i>
                      </button>
                </div>
            </div>
    </div>
</div>
<div style="margin-top: 30px;">
    <div style="margin: 0 auto; height: 610px; width: 100%;background-color: #cec9c9">
     <div style="margin-top: 15px; text-align: center;" class="text-white">
         <h2>GOLF TOURNAMENT IDEAS</h2>
     </div>
        <div style="margin-top: 20px;">
            <div class="container">
                <div class="row">
                    <div class="col">
                        <div style="position: relative;">
                        <img src="./images/golf-1.jpg" style="text-align: center; width:340px; height: 480px;" alt="fImg"/>
                        <div style="text-align: center; position: absolute;top: 50%;left: 50%;transform: translate(-50%, -50%);" class="p-2 text-white">A critical part of organizing a successful fundraising tournament is promoting a golf event website. Forget printing flyers and focus on great golf event software and technology.</div>
                            <input onclick="getGuideOne()" class="btn btn-primary" style="border-radius: 15px; position: absolute;bottom: 8px;left: 16px;" type="button" value="View the Guide" />
                        </div>
                    </div>
                    <div class="col">
                        <div style="position: relative;">
                            <img src="./images/golf-1.jpg" style="text-align: center; width:340px; height: 480px;" alt="fImg"/>
                            <div style="text-align: center; position: absolute;top: 50%;left: 50%;transform: translate(-50%, -50%);" class="p-2 text-white">Charity golf events with a Captain’s Choice format over a standard 18 holes are a dime a dozen. What’s the solution to a dwindling head count and repetitive event structure?.</div>
                            <input onclick="getGuideTwo()" class="btn btn-primary" style="border-radius: 15px; position: absolute; bottom: 8px;left: 16px;" type="button" value="View the Guide" />
                        </div>
                    </div>
                    <div class="col">
                        <div style="position: relative;">
                            <img src="./images/golf-1.jpg" style="text-align: center; width:340px; height: 480px;" alt="fImg"/>
                            <div style="text-align: center; position: absolute;top: 50%;left: 50%;transform: translate(-50%, -50%);" class="p-2 text-white">FREE Webinars for charity golf fundraising event organizers. Learn how to raise more money, attract sponsors/players and create a memorable golf tournament.</div>
                            <input onclick="getWebinars()" class="btn btn-primary" style="border-radius: 15px; position: absolute; bottom: 8px;left: 16px;" type="button" value="View webinars" />
                        </div>
                    </div>
                </div>
                    <div style="border-radius: 20px; text-align: center; margin-top: 10px;" >
                        <button onclick="allResources()" class="btn btn-info p-3">Check Out All of Our Resources</button>
                    </div>
            </div>
        </div>
    </div>
</div>
<div style="margin-top: 30px;">
    <div style="width: 100%; height: 550px; background-color: #7d7272">
    <div style="text-align: center; margin-top: 40px;">
        <h2 style="color: aliceblue">Perfect Golf Events Reviews</h2>
        <h3 style="color: white">Trusted by Thousands</h3>
    </div>
        <div id="carouselAuto" class="carousel slide" data-ride="carousel" data-interval="3000">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img style="height: 300px" class="d-block w-100" src="./images/golf-2.jpg" alt="slide_One">
                    </div>
                    <div class="carousel-item">
                        <img style="height: 300px;" class="d-block w-100" src="./images/golf-3.jpg" alt="slide_two">
                    </div>
                    <div class="carousel-item">
                        <img style="height: 300px;" class="d-block w-100" src="./images/golf-4.jpg" alt="slide_three">
                    </div>
                </div>
        </div>
        <div id="carouselComments" class="carousel slide carousel-multi-item" data-ride="carousel">
            <div style="display: flex; margin-left: 200px;" class="carousel-inner" role="listbox">
                <div class="carousel-item active">
                    <div class="col-md-3" style="float: left">
                        <div class="card mb-2">
                            <div id="cardStars1"></div>
                            <div class="card-content">
                              <h2> CommentOne</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3" style="float: left">
                        <div class="card mb-2">
                            <div id="cardStars2"></div>
                            <div class="card-content">
                                <h2> CommentOne-Two</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3" style="float: left">
                        <div class="card mb-2">
                            <div id="cardStars3"></div>
                            <div class="card-content">
                                <h2> CommentOne-Three</h2>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="col-md-3" style="float: left">
                        <div class="card mb-2">
                            <div id="cardStars4"></div>
                            <div class="card-content">
                                <h2> CommentTwo</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3" style="float: left">
                        <div class="card mb-2">
                            <div id="cardStars5"></div>
                            <div class="card-content">
                                <h2> CommentTwo-One</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3" style="float: left">
                        <div class="card mb-2">
                            <div id="cardStars6"></div>
                            <div class="card-content">
                                <h2> CommentTwo-Two</h2>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="col-md-3" style="float: left">
                        <div class="card mb-2">
                            <div id="cardStars7"></div>
                            <div class="card-content">
                                <h2> CommentThree-One</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3" style="float: left">
                        <div class="card mb-2">
                            <div id="cardStars8"></div>
                            <div class="card-content">
                                <h2> CommentThree-Two</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3" style="float: left">
                        <div class="card mb-2">
                            <div id="cardStars9"></div>
                            <div class="card-content">
                                <h2> CommentThree-Three</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <a class="carousel-control-prev" href="#carouselComments" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselComments" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>
</div>
<script>
    let firstBtnOne = document.getElementById("fBtnOne");
    let secondBtnTwo = document.getElementById("fBtnTwo");
    let firstClassCol = document.getElementById("fClassCol");

    let fBtnTwo = document.getElementById("sBtnOne");
    let secBtnTwo = document.getElementById("sBtnTwo");
    let secondClassCol = document.getElementById("sClassCol");

    let fBtnThree = document.getElementById("tBtnOne");
    let secBtnThree = document.getElementById("tBtnTwo");
    let thirdClassCol = document.getElementById("tClassCol");
    let cardStars = document.getElementById("cardStars");

    function msOver(stName, colorName) {
        stName.addEventListener('mouseover', () => {
            stName.style.backgroundColor = colorName;
            stName.style.border = "1px solid black";
        });
    }
    function msOut(stName,colorName) {
        stName.addEventListener('mouseout', () => {
            stName.style.backgroundColor = colorName;
            stName.style.border = "none !important;";
        });
    }
    function onClickedOne(stName) {
        stName.addEventListener('click', () => {
            console.log("btn one clicked");
        });
    }
    function onClickedTwo(stName) {
        stName.addEventListener('click', () => {
            console.log("btn two clicked");
        });
    }
    function watchVideo(){
        console.log("video watched");
    }
    function getGuideOne(){
        console.log("get GuideOne clicked..");
    }
    function getGuideTwo(){
        console.log("get GuideTwo clicked..");
    }
    function getWebinars(){
        console.log("get Webinars clicked..");
    }
    function  allResources(){
        console.log(" chek out all resources..");
    }
    function createStars(){
        let saveStars = [];
        let saveDivs = [];
       // let dispIds = getDivIds();
     /*   let j = 0;
        while(j < 10){
            console.log("inside firstFor..." + j);
            let showDiv = document.getElementById('cardStars' + j);
            console.log("insideShowDiv " + showDiv);
            //showDiv.style.color = "white";
            saveDivs.push(showDiv);
            return saveDivs;
        }*/
        console.log("saveDivs are " + JSON.stringify(saveDivs));
        let showDiv = document.getElementById('cardStars1');
        for (let i = 0; i < 6 ; i++){
         let myDiv = document.createElement("div");
         myDiv.setAttribute('class', 'fa fa-star');
         saveStars.push(myDiv);
         showDiv.appendChild(saveStars[i]);
        }
    }

    createStars();
    msOut(firstClassCol, 'yellow');
    msOver(firstClassCol, 'blue');
    onClickedOne(firstBtnOne);
    onClickedTwo(secondBtnTwo);
    //
    msOut(secondClassCol, 'red');
    msOver(secondClassCol, 'green');
    onClickedOne(fBtnTwo);
    onClickedTwo(secBtnTwo);
    //
    msOut(thirdClassCol, 'orange');
    msOver(thirdClassCol, 'purple');
    onClickedOne(fBtnThree);
    onClickedTwo(secBtnThree);

</script>
<footer style="position: absolute; left: 0; right: 0; bottom: 0;">
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