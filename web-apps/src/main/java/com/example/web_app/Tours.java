package com.example.web_app;


import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.Response;
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

@WebServlet(name = "toursInfo", value = "/tours")
public class Tours extends HttpServlet {

    OkHttpClient client = new OkHttpClient();
    List<String> tourArray = new ArrayList<String>();
    List<String> tourPhotosArray = new ArrayList<String>();
    Object toursInfo = new Object();

    public void doPost(HttpServletRequest request, HttpServletResponse response){
        CompletableFuture.runAsync(() -> {
            try {
                getGolfTours(request);
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    /*    CompletableFuture.runAsync(() -> {
            try {
                getSportPhotos(request);
            } catch (IOException e) {
                e.printStackTrace();
            }
        });*/
        try{
            Thread.sleep(2000);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/tours.jsp");
            dispatcher.forward(request,response);
        } catch (ServletException | IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
    public void doGet(HttpServletRequest request, HttpServletResponse response){
        CompletableFuture.runAsync(() -> {
            try {
                getGolfTours(request);
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
        try{
            Thread.sleep(2000);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/tours.jsp");
            dispatcher.forward(request,response);
        } catch (ServletException | IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
    private void getGolfTours(HttpServletRequest request) throws IOException {
        Request request2 = new Request.Builder()
                .url("https://golf-leaderboard-data.p.rapidapi.com/tours")
                .method("GET", null)
                .addHeader("Content-Type", "application/json")
                .addHeader("x-rapidapi-key", "5ff79c8426msh12670cfaa225a29p18acffjsn568144cb720f")
                .addHeader("x-rapidapi-host", "golf-leaderboard-data.p.rapidapi.com")
                .build();
        Response response2 = this.client.newCall(request2).execute();

        String json = response2.body().string();
        JSONArray allTours = new JSONArray();

        try {
            JSONObject jst = new JSONObject(json);
            this.toursInfo = jst.getJSONObject("meta").getString("description");
                    request.setAttribute("tourDescript", this.toursInfo.toString());
            allTours = jst.getJSONArray("results");
            for (int i = 0 ; i < allTours.length(); i++){
                JSONObject obj = allTours.getJSONObject(i);
                this.tourArray.add(obj.getString("tour_name"));
            }
            request.setAttribute("golfTours", this.tourArray);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }
    private void getSportPhotos(HttpServletRequest request) throws IOException {
        OkHttpClient client = new OkHttpClient();

        Request request2 = new Request.Builder()
                .url("https://bing-image-search1.p.rapidapi.com/images/trending")
                .get()
                .addHeader("Content-Type", "application/json")
                .addHeader("x-rapidapi-key", "5ff79c8426msh12670cfaa225a29p18acffjsn568144cb720f")
                .addHeader("x-rapidapi-host", "bing-image-search1.p.rapidapi.com")
                .build();

        Response response2 = client.newCall(request2).execute();
        String json = response2.body().string();
        JSONArray allTrsPhotos = new JSONArray();

        try {
            JSONObject jst = new JSONObject(json);
            //this.toursPhInfo = jst.getJSONArray("categories").getJSONObject(0).getJSONArray("tiles").getJSONObject(0).getJSONObject("image").getString("contentUrl");
                    //.getJSONObject("meta").getString("description");
            request.setAttribute("trPhDescript", this.toursInfo.toString());
            allTrsPhotos = jst.getJSONArray("categories");
            for (int i = 0 ; i < allTrsPhotos.length(); i++){
                JSONObject obj = allTrsPhotos.getJSONObject(i);
                this.tourPhotosArray.add(obj.getJSONArray("tiles").getJSONObject(0).getJSONObject("image").getString("contentUrl"));
            }
            request.setAttribute("golfTrPhotos", this.tourPhotosArray);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }
}
