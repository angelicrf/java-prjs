<%@ page import="com.mongodb.client.MongoClient" %>
<%@ page import="com.mongodb.client.MongoClients" %>
<%@ page import="com.mongodb.client.MongoDatabase" %>
<%@ page import="com.mongodb.client.MongoCollection" %>
<%@ page import="org.bson.Document" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Locale" %><%--
  Created by IntelliJ IDEA.
  User: bcuser
  Date: 5/18/21
  Time: 4:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Comments</title>
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
<body style="background-color: #9E9E9E">
    <div class="container" style="margin-top: 30px;">
        <h2>Customer Review</h2>
         <%if(request.getParameter("value") != null){%>
            <% Object showRev = request.getParameter("value");
               Object showDate = request.getParameter("custDate");
               Object showHeader = request.getParameter("custHeader");
               Object showCustName = request.getParameter("custName");
            %>
                   <div class="card" style="width: 550px;">
                       <div style="background-color: #aa8a5b" class="card-title">
                           <div>
                             <img style="width: 80px; height: 80px;" src="images/icon_144.jpeg" alt="reviewImg"/>
                               <span style="font-size: 14px;margin-left: 20px;">Date: <%=showDate%></span>
                               <div style="font-size: 12px;margin-left: 105px; margin-top: -20px;">many reviews</div>
                           </div>
                           <div class="h3">
                               Title review : <%=showHeader%>
                           </div>
                       </div>
                       <div style="background-color: #8e8eb3" class="card-content">
                           <div style="background-color: #c66597; margin-left: -30px; margin-top: -10px; height: 50px; width: 550px;">
                               <div style="padding-top: 15px; padding-left: 15px;" id="showStars"><span style="float: right; margin-right: 20px;"><i style="width: 18px; height: 18px; margin-right: 15px;" class="fa fa-pen"></i>Customer Name : <%=showCustName%></span></div>
                           </div>
                           <div style="padding-top: 20px; padding-bottom: 20px;">Customer review: <%=showRev%></div>
                           <div style="margin-top: 20px; background-color: #7eb47e; margin-left: -30px; margin-bottom: -10px; bottom: 0; right: 0;left: 0; height: 50px; width: 550px;">
                               <div style="padding-top: 15px; padding-left: 15px;"><a onclick="upRate()"><i class="fa fa-thumbs-up"></i><span style="margin-left: 10px;">useful</span></a><a onclick="sharedCustomer()" style="margin-left: 20px;"><i class="fas fa-share-alt"></i><span style="margin-left: 10px;">share</span></a><a onclick="flagReview()" style="float: right;" ><i class="fas fa-flag"></i><span style="margin-left: 10px; margin-right: 20px;">flag</span></a></div>
                           </div>
                       </div>
                   </div>
        <script>
            let crStars = document.getElementById("showStars");

            setTimeout(() => {
                if(window.location.href.indexOf("value") > -1){
                    console.log("contains value...");
                    window.history.pushState({}, document.title, "/web_app_war_exploded/comments.jsp" );
                }
            },3000);
            function makeStars(useDiv) {
                for (let i = 0; i < 5; i++) {
                    let myDivStars = document.createElement("div");
                    myDivStars.style.color = "green";
                    myDivStars.setAttribute('class', 'fa fa-star');
                    useDiv.appendChild(myDivStars);
                }
            }
            function upRate(){
                console.log("thumbs up clicked..");
            }
            function sharedCustomer(){
                console.log("shared customer  clicked..");
            }
            function flagReview(){
                console.log("flag review clicked");
            }
            makeStars(crStars);
        </script>
         <%}%>
        <div style="margin-top: 50px;">
            <form style="text-align: center;" method="get" action="comments" id="clComments">
              <input style="text-align: center; width: 250px; border-radius: 20px;" type="submit" name="allReviews" value="Write a Review" class="btn-danger btn">
            </form>
            <%if(request.getAttribute("seeReviews") != null){%>
            <script>
                let disableClComment = document.getElementById("clComments");
                disableClComment.style.visibility = "hidden";
            </script>
            <div style="background-color: #e0a02b">
               <form method="get" action="comments" id="clNewComments">
                   <label>
                      Name: <input style=" margin-left: 20px; width: 350px; border-radius: 20px;" name="nameCust" type="text" />
                   </label>
                   <br>
                   <label>
                     Title: <input style="margin-left:20px;  width: 550px; border-radius: 20px;" name="titleCust" type="text" />
                   </label>
                   <br>
                   <label>
                       Comment: <textarea style="margin-left:20px; width: 250px; height: 450px; border-radius: 20px;" name="commentCust"> Start comment...</textarea>
                   </label>
                   <br>
                   <div id="orgStars"></div>
                   <input type="hidden" id="countId" />
                   <br>
               <input style="border-radius: 15px;width: 250px;" type="submit" class="btn-info" value="submitReview"/>
               </form>
            </div>
            <script>
                let orgStars = document.getElementById("orgStars");
                let countRT = document.getElementById("countId");
                function makeStarsOrg(useDiv) {
                    for (let i = 0; i < 5; i++) {
                        let divStar = document.createElement("div");
                        divStar.setAttribute('class', 'far fa-star');
                        useDiv.appendChild(divStar);
                    }
                }
                makeStarsOrg(orgStars);
                let count = 0;
                orgStars.addEventListener('click', (ev) => {
                    ev.target.classList.remove("far");
                    ev.target.classList.add("fas");
                    if(ev.target.classList.contains("fas")){
                        count++;
                        console.log("countRate is " + count);
                        sessionStorage.setItem("countStars", count.toString());
                        let getCountStars = parseInt(sessionStorage.getItem("countStars"));
                        if(getCountStars > 0){
                            console.log("we are inside of countRT");
                            countRT.setAttribute("name", "rateCust");
                            countRT.setAttribute("value", getCountStars.toString());
                        }
                    }
                })

            </script>
            <%}%>
        </div>
    </div>
    <div style="visibility: hidden; margin-top: 20px;background-color: #66baba"  class="container" id="newComment"></div>
    <%if(request.getParameter("nameCust") != null){%>
    <%Object newCustName = request.getParameter("nameCust");
        String titleCust = request.getParameter("titleCust");
        String commentCust = request.getParameter("commentCust");
        String cntRate = request.getParameter("rateCust");
    %>
    <div id="newCard" style="visibility: hidden; width: 550px;">
        <h2>Thanks for your feedback! We now posted your comment to our database...</h2>
        <div class="card">
            <div class="card-title">
                NewCustName : <%=newCustName%>
                CustTitle : <div><%=titleCust%></div>
            </div>
           <div class="card-content">
               CustComment: <%=commentCust%>
           </div>
        </div>
    </div>
    <% MongoClient mngdb = MongoClients.create("mongodb+srv://new-admin-calc:123456calc@clustercalc.xuacu.mongodb.net/calculate?retryWrites=true&w=majority");
       MongoDatabase db = mngdb.getDatabase("calculate");
       int currentDay = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
       int year = Calendar.getInstance().get(Calendar.YEAR);
       String month = Calendar.getInstance().getDisplayName(Calendar.MONTH, Calendar.LONG, Locale.getDefault());
       String todayDate = currentDay + " " + month + " " + year;
       MongoCollection<Document> col = db.getCollection("comments");

       Document doc = new Document("cmName", newCustName).append("cmStars" , cntRate).append("cmDate", todayDate).append("cmTitle", titleCust).append("cmComment", commentCust);
       col.insertOne(doc);
    %>
    <script>
        let visibleComment = document.getElementById("newComment");
        let newCard = document.getElementById("newCard");
        let disClComment = document.getElementById("clComments");

        disClComment.style.visibility = "hidden";
        newCard.style.visibility = "visible";
        visibleComment.style.visibility = "visible";
        visibleComment.appendChild(newCard);
        setTimeout(() => {
            if(window.location.href.indexOf("value") > -1){
                console.log("contains value...");
                window.history.pushState({}, document.title, "/web_app_war_exploded/comments.jsp" );
            }
        },3000);
    </script>
    <%}%>
</body>
</html>
