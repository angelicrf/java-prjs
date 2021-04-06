<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="./index.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"></script>
    <script src="https://use.fontawesome.com/releases/v5.15.2/js/all.js" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <title>tours</title>
</head>
<body style="height: 2100px;">
<script src="https://use.fontawesome.com/releases/v5.15.2/js/all.js" crossorigin="anonymous"></script>
<div class="pos-f-t">
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
<h1>Tours Info</h1>
<div class="container mt-4">
    <form method="post" action="tours">
        <input class="btn btn-danger" type="submit" value="GetEvents"/>
    </form>
    <%ArrayList<String> listTours = (ArrayList<String>) request.getAttribute("golfTopics");%>
    <%ArrayList<String> listDescriptions = (ArrayList<String>) request.getAttribute("golfDescriptions");%>
    <%ArrayList<String> listMarketNames = (ArrayList<String>) request.getAttribute("golfMarketNames");%>
    <%ArrayList<Integer> listPriceAmns = (ArrayList<Integer>) request.getAttribute("golfPriceAmt");%>
       <%ArrayList<String> listAddresses = (ArrayList<String>) request.getAttribute("golfAddresses");%>
       <%ArrayList<String> listCityNames = (ArrayList<String>) request.getAttribute("golfCityNames");%>
       <%ArrayList<String> listStateNames = (ArrayList<String>) request.getAttribute("golfStateProvince");%>
       <%ArrayList<String> listContactPhone = (ArrayList<String>) request.getAttribute("golfContactPhone");%>
       <%ArrayList<String> listPlaceNames = (ArrayList<String>) request.getAttribute("golfPlaceNames");%>
       <%ArrayList<String> listImageUrls = (ArrayList<String>) request.getAttribute("golfImageUrls");%>
       <%ArrayList<String> listAssetNames = (ArrayList<String>) request.getAttribute("golfAssetNames");%>
       <%ArrayList<String> listOrgNames = (ArrayList<String>) request.getAttribute("golfOrgNames");%>
       <%ArrayList<String> listSalesStats = (ArrayList<String>) request.getAttribute("golfSalesStats");%>
<%-- <%ArrayList<String> listTrsPhotos = (ArrayList<String>) request.getAttribute("golfTrPhotos");%>;--%>
    <%if(listTours != null) {%>
     <div class="row">
     <%  for (int i =0; i < listTours.size(); i++) { %>
         <div class="col-lg-8 btn btn-primary px-1 mx-1 mb-2" role="button" aria-expanded="false" aria-controls="tours-headers">
             <h2><a data-toggle="collapse" href="#tours-headers-<%=i%>" style="color: beige"><%=listTours.get(i)%></a></h2>
         </div>
         <div class="collapse" id="tours-headers-<%=i%>" >
             <div class="card col-lg-8 card-body">
             <p>Description: <%=listDescriptions.get(i)%></p>
                 <p>MarketNames: <%=listMarketNames.get(i)%></p>
                 <p>AssetPrice: <%=listPriceAmns.get(i)%></p>
                 <p>Address: <%=listAddresses.get(i)%></p>
                 <p>City: <%=listCityNames.get(i)%>, <%=listStateNames.get(i)%></p>
                 <p>Place Name: <%=listPlaceNames.get(i)%></p>
                 <img src="<%=listImageUrls.get(i)%>" alt="tourImg" style="width: 150px; height: 150px; border-radius: 10px;" />
                 <p>Asset Name: <%=listAssetNames.get(i)%></p>
                 <p>Organization Name: <%=listOrgNames.get(i)%></p>
                 <p>Sales Status: <%=listSalesStats.get(i)%></p>
                 <p>Phone: <%= listContactPhone.get(i)%></p>
             </div>
         </div>
         <%} %>
     </div>
    <% }%>
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
</body>
</html>
