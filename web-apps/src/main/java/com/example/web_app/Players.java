package com.example.web_app;

import com.mongodb.client.*;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.Response;
import org.bson.Document;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;

@WebServlet(name = "players", value = "/players")

public class Players extends HttpServlet {

    OkHttpClient client = new OkHttpClient();
    Object tournamentName = new Object();
    List<String> nameArray = new ArrayList<String>();
    List<String> firstnameArray = new ArrayList<String>();
    List<String> countryArray = new ArrayList<String>();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Object getPlayerValue = request.getParameter("favName");
        Object getAllPlayers = request.getParameter("getPlayers");
        Object getRmvPlayer = request.getParameter("favRmv");
        if(getAllPlayers != null) {
            CompletableFuture.runAsync(() -> {
                try {
                    getTournamentInfo(request);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            });
        }
        if(getPlayerValue != null) {
            CompletableFuture.runAsync(() -> {
                try {
                    Thread.sleep(3000);
                    System.out.println("getName is " + getPlayerValue);
                    mongodbAddLikePlayers(getPlayerValue.toString(), "LikedHeart", "Germany");
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            });
        }
      if(getRmvPlayer != null){
          CompletableFuture.runAsync(() -> {
             try {
                 Thread.sleep(2000);
                 removeFromMongo(getRmvPlayer.toString());
             }catch (InterruptedException e){
                 e.printStackTrace();
             }
          });
      }
       try{
            Thread.sleep(5000);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/players.jsp");
            dispatcher.forward(request,response);
        } catch (ServletException | IOException | InterruptedException e) {
            e.printStackTrace();
        }
        //out.println("Num One is " +  getNumOne + " Num two is " + getNUmTwo + " result is " + calcResult);
    }
 private void mongodbAddLikePlayers(String plLikedName,String plLikedLName,String plLikeCountry){
     MongoClient mongoClient = MongoClients.create("mongodb+srv://new-admin-calc:123456calc@clustercalc.xuacu.mongodb.net/calculate?retryWrites=true&w=majority");
     MongoDatabase database = mongoClient.getDatabase("calculate");
     MongoCollection<Document> collection = database.getCollection("likedplayers");
     Document doc = new Document("likedPlName", plLikedName)
             .append("likedPlLName", plLikedLName)
             .append("likedPlCountry",plLikeCountry);
     FindIterable<Document> iterLiked = collection.find(doc);
     MongoCursor<Document> cursor = iterLiked.iterator();
         try {
             if (cursor.hasNext()) {
                 Document document = cursor.next();
                 System.out.println("not found");
             }
             else{
                 collection.insertOne(doc);
                 System.out.println("sent to mongo");
             }
         } catch (RuntimeException e) {
             e.printStackTrace();
         }
     }
 private void removeFromMongo(String fvName) {
     MongoClient mongoClient = MongoClients.create("mongodb+srv://new-admin-calc:123456calc@clustercalc.xuacu.mongodb.net/calculate?retryWrites=true&w=majority");
     MongoDatabase database = mongoClient.getDatabase("calculate");
     MongoCollection<Document> collection = database.getCollection("likedplayers");
     try {
       collection.deleteOne(new Document("likedPlName", fvName));
     }catch (Exception e){
         e.printStackTrace();
     }
 }
 private void getTournamentInfo(HttpServletRequest request) throws IOException {
     Request request2 = new Request.Builder()
             .url("https://golf-leaderboard-data.p.rapidapi.com/entry-list/219")
             .method("GET", null)
             .addHeader("Content-Type", "application/json")
             .addHeader("x-rapidapi-key", "5ff79c8426msh12670cfaa225a29p18acffjsn568144cb720f")
             .addHeader("x-rapidapi-host", "golf-leaderboard-data.p.rapidapi.com")
             .build();
     Response response2 = this.client.newCall(request2).execute();

     String json = response2.body().string();
     System.out.println("Json is " + json);
     JSONArray playerName = new JSONArray();

     try {
         JSONObject jst = new JSONObject(json);
         this.tournamentName = jst.getJSONObject("results").getJSONObject("tournament").get("name");
         request.setAttribute("tournamentName", this.tournamentName.toString());

         playerName = jst.getJSONObject("results").getJSONArray("entry_list");
         for (int i = 0 ; i < playerName.length(); i++){
             JSONObject obj = playerName.getJSONObject(i);
             this.nameArray.add(obj.getString("last_name"));
             this.firstnameArray.add(obj.getString("first_name"));
             this.countryArray.add(obj.getString("country"));
         }

         request.setAttribute("playerNames", this.nameArray);
         request.setAttribute("playersFirstNames", this.firstnameArray);
         request.setAttribute("country", this.countryArray);
         System.out.println(this.countryArray);
     } catch (JSONException e) {
         e.printStackTrace();
     }
 }

}