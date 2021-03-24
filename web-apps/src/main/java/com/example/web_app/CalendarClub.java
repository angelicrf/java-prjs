package com.example.web_app;

import com.squareup.okhttp.*;
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

@WebServlet(name = "calendarclub", value = "/calendarclbs")
public class CalendarClub extends HttpServlet{
    ///auth/calendar.calendarlist.readonly
    String storeCode = null;
    String storeAccTkn = null;
    String API_KEY = "AIzaSyCDxl-kP_cWQXry6FO7lpewcZ6OvIVmbkg";
    List<String> valueSetting = new ArrayList<String>();
    List<String> idSetting = new ArrayList<String>();
    OkHttpClient client = new OkHttpClient();

    public void doPost(HttpServletRequest request, HttpServletResponse response) {
        CompletableFuture.runAsync(() -> {
            try {
                Thread.sleep(3000);
                System.out.println("from golfList ");
                System.out.println("AccessToken from golfList is " + this.storeAccTkn);
                getCalendarListGolf(request, this.storeAccTkn, this.API_KEY);
            } catch (InterruptedException | IOException | JSONException e) {
                e.printStackTrace();
            }
        });
        try {
            Thread.sleep(7000);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/calendarclbs.jsp");
            dispatcher.forward(request, response);
        } catch (ServletException | IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) {

        CompletableFuture.runAsync(() -> {
            request.setAttribute("msgData", "Received");
        });

        if (request.getParameter("code") != null || request.getRequestURI().contains("code")) {
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
                    this.storeAccTkn = generateAccessToken(this.storeCode);
                    System.out.println("accessToken from generateToken is " + this.storeAccTkn);

                } catch (IOException | InterruptedException | JSONException e) {
                    e.printStackTrace();
                }
            });
           //old function
        } //closed if
        try {
                Thread.sleep(7000);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/calendarclbs.jsp");
                dispatcher.forward(request, response);
            } catch (ServletException | IOException | InterruptedException e) {
                e.printStackTrace();
            }
        }

   public String getCodeFromUrl(HttpServletRequest request){
        System.out.println("getCodeFromUrl called");
        this.storeCode = request.getParameter("code");
        return this.storeCode;
   }
   public String generateAccessToken(String cd) throws IOException, JSONException {
        System.out.println("generateAccessToken is called");

       MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
       RequestBody bodyInfo = RequestBody.create(mediaType, "grant_type=authorization_code&redirect_uri=http://localhost:8081/web_app_war_exploded/calendarclbs&client_secret=I3lNn3gT6gIbwmanrQtbFyj1&client_id=502305783354-sr48jg1hnse1lehoce3au065rquob8f0.apps.googleusercontent.com&code=" + cd);
       Request request2 = new Request.Builder()
               .url("https://oauth2.googleapis.com/token")
               .method("POST", bodyInfo)
               .addHeader("Content-Type", "application/x-www-form-urlencoded")
               .build();
       System.out.println("after build");
       //create another promise
       Response response2 = this.client.newCall(request2).execute();
       String bodyData = response2.body().string();
       JSONObject jsonObject = new JSONObject(bodyData);
       String mdAccessTken =  jsonObject.getString("access_token");
       this.storeAccTkn = mdAccessTken.substring(1, mdAccessTken.length() -1);
       return  this.storeAccTkn;
    }

    public void getCalendarListGolf(HttpServletRequest request,String acTkn, String apiKey) throws IOException, JSONException {
        System.out.println("getCalList Called " + acTkn + " api key is " + apiKey);
        Request request3 = new Request.Builder()
                .url("https://www.googleapis.com/calendar/v3/users/me/settings?key=" + apiKey)
                .method("GET", null)
                .addHeader("Authorization", acTkn)
                .addHeader("Content-Type", "applicationx-www-form-urlencoded")
                .build();
        System.out.println("after request2");
        Response response3 = this.client.newCall(request3).execute();
        String dataObj = response3.body().string();
        System.out.println("dataObj " + dataObj);
        JSONObject jsObject = new JSONObject(dataObj);
        System.out.println("jsObject is " + jsObject);
        //JSONParser.parse(response2.body().string()).getAsJsonObject();
        //JsonElement jsonElement = jsonObject.get("items");
        JSONArray jsArray = jsObject.optJSONArray("items");

       for (int i = 0; i < jsArray.length(); i++) {
           System.out.println(i + ". Array element Content:" + jsArray.get(i));
           String value = jsArray.getJSONObject(i).getString("value");
           String id = jsArray.getJSONObject(i).getString("id");
           System.out.println("\t value:" + value + " id:" + id);
           this.valueSetting.add(value);
           this.idSetting.add(id);
           request.setAttribute("setId", this.idSetting);
           request.setAttribute("setValue", this.valueSetting);
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
