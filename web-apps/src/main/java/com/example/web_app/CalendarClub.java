package com.example.web_app;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.squareup.okhttp.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.concurrent.CompletableFuture;

@WebServlet(name = "calendarclub", value = "/calendarclbs")
public class CalendarClub extends HttpServlet{
    ///auth/calendar.calendarlist.readonly
    String storeCode = null;
    String storeAccTkn = null;
    String API_KEY = "AIzaSyCDxl-kP_cWQXry6FO7lpewcZ6OvIVmbkg";
    OkHttpClient client = new OkHttpClient();

    public void doGet(HttpServletRequest request, HttpServletResponse response) {

        CompletableFuture.runAsync(() -> {
            request.setAttribute("msgData", "Received");
         });

        if(request.getParameter("code") != null || request.getRequestURI().contains("code")) {
            CompletableFuture.runAsync(() -> {
                try {
                    Thread.sleep(3000);
                    this.storeCode = getCodeFromUrl(request);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            });
            CompletableFuture.runAsync(() -> {
                try {
                    Thread.sleep(3000);
                    System.out.println("this.storecode is " + this.storeCode);
                    this.storeAccTkn = generateAccessToken(this.storeCode);

                } catch (IOException | InterruptedException e) {
                    e.printStackTrace();
                }
            });
        }
       CompletableFuture.runAsync(() -> {
            try {
                Thread.sleep(4000);
                System.out.println("AccessToken is " + this.storeAccTkn);
                getCalendarListGolf(this.storeAccTkn , this.API_KEY);
            } catch (InterruptedException | IOException e) {
                e.printStackTrace();
            }
        });
        try{
            Thread.sleep(9000);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/calendarclbs.jsp");
            dispatcher.forward(request,response);
        } catch (ServletException | IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
   public String getCodeFromUrl(HttpServletRequest request){
        System.out.println("getCodeFromUrl called");
        this.storeCode = request.getParameter("code");
        return this.storeCode;
   }
   public String generateAccessToken(String cd) throws IOException {
        System.out.println("generateAccessToken is called");

       MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
       RequestBody body = RequestBody.create(mediaType, "grant_type=authorization_code&redirect_uri=http://localhost:8081/web_app_war_exploded/calendarclbs&client_secret=I3lNn3gT6gIbwmanrQtbFyj1&client_id=502305783354-sr48jg1hnse1lehoce3au065rquob8f0.apps.googleusercontent.com&code=" + cd);
       Request request2 = new Request.Builder()
               .url("https://oauth2.googleapis.com/token")
               .method("POST", body)
               .addHeader("Content-Type", "application/x-www-form-urlencoded")
               .build();
       Response response2 = this.client.newCall(request2).execute();
       JsonObject jsonObject = new JsonParser().parse(response2.body().string()).getAsJsonObject();
       JsonElement jsonElement = jsonObject.get("access_token");

       return jsonElement.toString().substring(1,jsonElement.toString().length() -1);
   }

    public void getCalendarListGolf(String acTkn, String apiKey) throws IOException {
        System.out.println("getCalList Called " + acTkn + " api key is " + apiKey);
        Request request2 = new Request.Builder()
                .url("https://www.googleapis.com/calendar/v3/users/me/settings?key=" + apiKey)
                .method("GET", null)
                .addHeader("Authorization", acTkn)
                .addHeader("Content-Type", "applicationx-www-form-urlencoded")
                .build();
        System.out.println("after request2");
        Response response2 = this.client.newCall(request2).execute();
        System.out.println("items are " + response2.body().string());

        JsonObject jsonObject = new JsonParser().parse(response2.body().string()).getAsJsonObject();
        JsonElement jsonElement = jsonObject.get("items");
        JsonArray jsonArray = jsonElement.getAsJsonArray();

       for (int i = 0; i < jsonArray.size(); i++) {
           System.out.println(i + ". Array element Content:" + jsonArray.get(i));
           JsonObject jsonObj = jsonArray.get(i).getAsJsonObject();
           System.out.println("\t value:" + jsonObj.get("value") + " id:" + jsonObj.get("id"));
       }
    }

   /*
   public void readMyFile() throws IOException {
    InputStream input = getClass().getResourceAsStream("/client_secret_502305783354-oscnu3587fcbeha1p1h0uk681qpgapmi.apps.googleusercontent.com.json");
       InputStreamReader isr = new InputStreamReader(input,StandardCharsets.UTF_8);
       BufferedReader br = new BufferedReader(isr);
         String line;
           while ((line = br.readLine()) != null) {
               System.out.println(line);
    }*/
}
