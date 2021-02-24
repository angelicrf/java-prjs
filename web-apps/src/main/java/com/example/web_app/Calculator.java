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

@WebServlet(name = "calculator", value = "/calculate")

public class Calculator extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
       // response.setContentType("text/html");

        String getNumOne = request.getParameter("numOne");
        String getNUmTwo = request.getParameter("numTwo");

        int calcResult = Integer.parseInt(getNumOne) + Integer.parseInt(getNUmTwo);


        PrintWriter out = response.getWriter();
        MongoClient mongoClient = MongoClients.create("mongodb+srv://new-admin-calc:123456calc@clustercalc.xuacu.mongodb.net/calculate?retryWrites=true&w=majority");
        MongoDatabase database =  mongoClient.getDatabase("calculate");
        MongoCollection<Document> collection = database.getCollection("inventory");
        Document doc = new Document("name", "FromServer")
                .append("type", "SimpleData")
                .append("count", 32)
                .append("versions", Arrays.asList("One", "Two", "Three"))
                .append("info", new Document("DataOne", 769).append("CalcResult", calcResult));
        Iterator<Document> iter = collection.find(doc).iterator();
        org.bson.Document nextDocument = iter.next();
        Object myData = nextDocument.get("name");
        //collection.insertOne(doc);
        OkHttpClient client = new OkHttpClient();

        Request request2 = new Request.Builder()
                .url("https://golf-leaderboard-data.p.rapidapi.com/entry-list/219")
                .method("GET", null)
                .addHeader("Content-Type", "application/json")
                .addHeader("x-rapidapi-key", "5ff79c8426msh12670cfaa225a29p18acffjsn568144cb720f")
                .addHeader("x-rapidapi-host", "golf-leaderboard-data.p.rapidapi.com")
                .build();
        Response response2 = client.newCall(request2).execute();
        String json = response2.body().string();
        Object tournamentName = new Object();
        JSONArray playerName = new JSONArray();
        List<String> nameArray = new ArrayList<String>();

        try {
            JSONObject jst = new JSONObject(json);
            tournamentName = jst.getJSONObject("results").getJSONObject("tournament").get("name");
            playerName = jst.getJSONObject("results").getJSONArray("entry_list");
            for (int i = 0 ; i < playerName.length(); i++){
                JSONObject obj = playerName.getJSONObject(i);
                nameArray.add(obj.getString("last_name"));
            }

        } catch (JSONException e) {
            e.printStackTrace();
        }
        request.setAttribute("numCalc", Integer.toString(calcResult));
        request.setAttribute("clientName", myData.toString());
        request.setAttribute("tournamentName", tournamentName.toString());
        request.setAttribute("playerNames", nameArray);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/calculate.jsp");
        dispatcher.forward(request,response);
        //out.println("Num One is " +  getNumOne + " Num two is " + getNUmTwo + " result is " + calcResult);
    }

}