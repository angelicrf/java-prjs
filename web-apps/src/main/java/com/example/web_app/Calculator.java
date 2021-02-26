package com.example.web_app;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
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
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.CompletableFuture;

@WebServlet(name = "calculator", value = "/calculate")

public class Calculator extends HttpServlet {

    OkHttpClient client = new OkHttpClient();
    Object tournamentName = new Object();
    List<String> nameArray = new ArrayList<String>();
    List<String> firstnameArray = new ArrayList<String>();
    List<String> countryArray = new ArrayList<String>();

    int calcResult = 0;


    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
       // response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String getNumOne = this.strReqParam(request,"numOne");
        String getNumTwo = this.strReqParam(request,"numTwo");
        // FUNCS
        CompletableFuture.runAsync(() -> {
            calcResult = calcResultInts(getNumOne, getNumTwo);
        request.setAttribute("numCalc", Integer.toString(calcResult));
        });
        CompletableFuture.runAsync(() -> {
            cltMongoDb(request);
        });
        CompletableFuture.runAsync(() -> {
            try {
                getTournamentInfo(request);
            } catch (IOException e) {
                e.printStackTrace();
            }
        });


        try{
            Thread.sleep(5000);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/calculate.jsp");
            dispatcher.forward(request,response);
        } catch (ServletException | IOException | InterruptedException e) {
            e.printStackTrace();
        }
        //out.println("Num One is " +  getNumOne + " Num two is " + getNUmTwo + " result is " + calcResult);
    }
    public void doGet(HttpServletRequest request, HttpServletResponse response){
        try{
            Thread.sleep(2000);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/calculate.jsp");
            dispatcher.forward(request,response);
        } catch (ServletException | IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }

    private String strReqParam(HttpServletRequest request, String param){
        return request.getParameter(param);
    }
    private int calcResultInts(String a, String b){
        return Integer.parseInt(a) + Integer.parseInt(b);
    }
    private void cltMongoDb(HttpServletRequest request){
        MongoClient mongoClient = MongoClients.create("mongodb+srv://new-admin-calc:123456calc@clustercalc.xuacu.mongodb.net/calculate?retryWrites=true&w=majority");
        MongoDatabase database =  mongoClient.getDatabase("calculate");
        MongoCollection<Document> collection = database.getCollection("inventory");
        Document doc = new Document("name", "FromServer")
                .append("type", "SimpleData")
                .append("count", 32)
                .append("versions", Arrays.asList("One", "Two", "Three"))
                .append("info", new Document("DataOne", 769).append("CalcResult", this.calcResult));
        Iterator<Document> iter = collection.find(doc).iterator();
        //if else
        org.bson.Document nextDocument = iter.next();
        request.setAttribute("clientName", nextDocument.get("name").toString());
        //collection.insertOne(doc);
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
     } catch (JSONException e) {
         e.printStackTrace();
     }
 }

}