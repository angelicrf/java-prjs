<%@ page import="org.json.JSONObject" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
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
    <title>calculator</title>
</head>
<body class="btn-light" style="height: 1300px;">
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
<div class="container">
 <div class="text-center mt-4">
     <form method="get" action="players">
         <input class="btn btn-info" name="getPlayers"  type="submit" value="GetPlayers"/>
     </form>
 <%ArrayList<String> listPlayers = (ArrayList<String>) request.getAttribute("playerNames");%>
 <%ArrayList<String> listFirstNamePlayers = (ArrayList<String>) request.getAttribute("playersFirstNames");%>
 <%ArrayList<String> listCountry = (ArrayList<String>) request.getAttribute("country");%>
     <%String[] testNames = new String[]{"tg", "tf"};
         List<String> valueArray = new ArrayList<String>();
       %>
     <table class="mt-4 table text-center table-responsive table-hover table-striped tbStyle" id="myTable">
     <tr><th>Like</th><th>First Name</th><th>Id</th><th>Favorite</th></tr>
     <% for (int i=0; i< testNames.length;i++){ %>
     <tr>
         <td>
             <button id="thumbsUp<%=i%>"><i class="fa fa-thumbs-up myThmbUp"></i></button>
             <span id="thmbUp<%=i%>"></span>
             <button id="thumbsDown<%=i%>"><i class="fa fa-thumbs-down ml-2 myThmbDown"></i></button>
             <span id="thmbDown<%=i%>"></span>
         </td>
         <td><span id="custName"><%=testNames[i] %></span></td>
         <td><p id="spcId"><%=i%></p></td>
         <td><button id="heartBtn<%=i%>"><i class="far fa-heart myLike<%=i%>"></i></button></td>
     </tr>
         <%}%>
     </table>
     <div style="visibility: hidden" id="dsPlayers">
     <form action="players" method="get" id="frmSbt">
         <input type="hidden"  id="sbtInfo"/>
     </form>
         <form action="players" method="get" id="frmRmv">
             <input type="hidden"  id="rmvInfo"/>
         </form>
     </div>
     <script type="text/javascript">
         let table = document.getElementById("myTable");
         let divPlayer = document.getElementById("dsPlayers");
         let formSbt = document.getElementById("sbtInfo");
         let formDiv = document.getElementById("frmSbt");
         let formRmv = document.getElementById("frmRmv");
         let rmvDiv = document.getElementById("rmvInfo");
         let getLength = <%=testNames.length%>;
         let mdRowInfo = "";
         let secCount = 0;
         let getSelectedRow;
         let rw;
         let isHaerted = false;

             for(let h = 0; h < parseInt(getLength); h++) {
                 if(localStorage.getItem("setLiked" + h) != null || localStorage.getItem("setDisLike" + h != null)){
                     document.getElementById("thmbUp" + h).innerHTML = localStorage.getItem("setLiked" + h);
                     document.getElementById("thmbDown" + h).innerHTML = localStorage.getItem("setDisLike" + h);
                 }
                 if(localStorage.getItem("setPlayerLiked" + h) === null) {
                     document.getElementById("heartBtn" + h).addEventListener("click", e => {
                         document.querySelectorAll('.myLike' + h).forEach(item => {
                             if (item.classList.contains("heart")) {
                                 item.classList.remove("heart");
                                 item.classList.toggle("far");
                             } else {
                                 console.log("has heart");
                                 item.classList.toggle("fas");
                                 item.classList.add("heart");
                                 getSelectedRow = item.closest("td");
                                 rw = getSelectedRow.parentElement;
                                 isHaerted = true;
                             }
                             if (isHaerted) {
                                 console.log("rw " + rw + "getSelectedRow " + getSelectedRow);
                                 let rowInfo = '';
                                 for (let i = 0, row; row = table.rows[i]; i++) {
                                     for (let j = 0, col; col = row.cells[j]; j++) {
                                         rowInfo = table.rows[parseInt(rw.rowIndex)].textContent.trim();
                                     }
                                 }
                                 let stRowInfo = rowInfo.toString().split('\n').filter(el => String(el).trim());
                                 mdRowInfo = stRowInfo.map(el => String(el).trim());
                                 localStorage.setItem("setPlayerLiked" + h, mdRowInfo[0]);
                                 formSbt.setAttribute("value", localStorage.getItem("setPlayerLiked" + h));
                                 formSbt.setAttribute("name", "favName");
                                 formDiv.submit();
                             }
                         });
                     });
                 }else{
                     document.querySelectorAll('.myLike' + h).forEach(item => {
                         console.log("there is liked in local...");
                         item.classList.toggle("fas");
                         item.classList.add("heart");
                     });
                     document.getElementById("heartBtn" + h).addEventListener("click", e => {
                         document.querySelectorAll('.myLike' + h).forEach(item => {
                             if (item.classList.contains("heart")) {
                                 item.classList.remove("heart");
                                 item.classList.toggle("far");
                                 rmvDiv.setAttribute("name", "favRmv");
                                 formRmv.submit();
                                 localStorage.removeItem("setPlayerLiked" + h);
                             }
                         });
                     });
                 }

                 document.getElementById("thumbsUp" + h).addEventListener("click", (e) => {
                     console.log("button clicked ");
                     getDataUp(h);
                 });
                 document.getElementById("thumbsDown" + h).addEventListener("click", (e) => {
                     console.log("buttonDown clicked ");
                     let getSelectedRow = e.target.closest('td').cellIndex;
                     getDataDown(h);
                     localStorage.setItem("setPlayerDisLike" + h, mdRowInfo);
                 });
             }

         function getDataUp(h){
             let valLike = localStorage.getItem("setLiked" + h);
             let count = 3;
             if(valLike === null) {
                 console.log("getDataUp Called ");
                 count++;
                 document.getElementById("thmbUp" + h).innerHTML = count;
                 secCount = count;
                 localStorage.setItem("setLiked" + h, secCount);
             }else{
                 valLike++;
                 localStorage.setItem("setLiked" + h, valLike);
                 document.getElementById("thmbUp" + h).innerHTML = valLike;
                 secCount = valLike;
                 localStorage.setItem("setLiked" + h, secCount);
             }
             return secCount;
         }
        function getDataDown(h){
            let valLike = localStorage.getItem("setLiked" + h);
            let valDislike = localStorage.getItem("setDisLike" + h);
            let count = 0;
            let disCount = 3;
                 if(valDislike === null) {
                     console.log("val dislike null");
                     disCount++;
                     localStorage.setItem("setDisLike" + h, disCount);
                     document.getElementById("thmbDown" + h).innerHTML = disCount;
                     if(valLike === null) {
                         count = secCount;
                         count--;
                         localStorage.setItem("setLiked" + h, count);
                         document.getElementById("thmbUp" + h).innerHTML = count;
                         return count;
                     }else{
                         console.log("vallike-dislike not null");
                         count = valLike;
                         valLike--;
                         localStorage.setItem("setLiked" + h, valLike);
                         document.getElementById("thmbUp" + h).innerHTML = valLike;
                         return count;
                     }
                 } else{
                     console.log("dislike notnull");
                     valDislike++;
                     localStorage.setItem("setDisLike" + h, valDislike);
                     document.getElementById("thmbDown" + h).innerHTML = valDislike;
                     if(valLike === null) {
                         count = secCount;
                         count--;
                         localStorage.setItem("setLiked" + h, count);
                         document.getElementById("thmbUp" + h).innerHTML = count;
                         return count;
                     }else{
                         console.log("vallike-dislike2 not null");
                         count = valLike;
                         valLike--;
                         localStorage.setItem("setLiked" + h, valLike);
                         document.getElementById("thmbUp" + h).innerHTML = valLike;
                         return  count;
                     }
                 }
         }
     </script>

     <%--<%if(listCountry != null){%>
     <h2 class="mt-4 btn-danger text-center"><%= request.getAttribute("tournamentName")%></h2>
    <table class="mt-4 table text-center table-responsive table-hover table-striped tbStyle">
        <tr><th>Players First Name</th><th>Players Last Name</th><th>Country</th></tr>
        <% for (int i=0; i< listPlayers.size();i++){ %>
        <tr>
            <td>
                <div id="hlId" data-value="<%=i%>"></div>
                <i onclick="myFunction(this)" class="fa fa-thumbs-up myThmbUp"></i>
                <span id="countedNum<%=i%>"></span>
                <i onclick="myFunctionTwo(this)" class="fa fa-thumbs-down ml-2 myThmbDown"></i>
                <span id="countedTwo<%=i%>"></span>
                <script type="text/javascript">
                    let count = 3;
                    let disCount = 3;
                    function myFunction(x) {
                        count ++;
                        document.getElementById("countedNum<%=i%>").innerHTML = count;
                        return count;
                    }
                    function myFunctionTwo(x) {
                        disCount ++;
                        document.getElementById("countedTwo<%=i%>").innerHTML = disCount;
                        count --;
                        document.getElementById("countedNum").innerHTML = count;
                        return count;
                    }
                </script>
                <span><%=listPlayers.get(i) %></span>  </td>
            <td> <%=listFirstNamePlayers.get(i) %>  </td>
            <td> <%=listCountry.get(i) %>  </td>
            <%} %>
        </tr>
    </table>
     <%}else%>
     <h3>players page</h3>--%>
</div>
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
