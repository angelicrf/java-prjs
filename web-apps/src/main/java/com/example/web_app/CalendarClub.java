package com.example.web_app;

import com.squareup.okhttp.*;

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
    ///auth/userinfo.profile
    ///auth/userinfo.email
    String storeCode = null;
    String storeAccTkn = null;
    String API_KEY = "AIzaSyCDxl-kP_cWQXry6FO7lpewcZ6OvIVmbkg";
    List<Object> obj = new ArrayList<>();
    OkHttpClient client = new OkHttpClient();

    public void doGet(HttpServletRequest request, HttpServletResponse response) {

        CompletableFuture.runAsync(() -> {
            request.setAttribute("msgData", "Received");
         });
        //0 - 1- 5
   /*     CompletableFuture.runAsync(() -> {
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
                generateAccessToken(this.storeCode);
                this.storeAccTkn = this.obj.get(0).toString();
                System.out.println("this.accessTkn " + this.storeAccTkn);

            } catch (IOException | InterruptedException e) {
                e.printStackTrace();
            }
        });*/
        CompletableFuture.runAsync(() -> {
            try {
                Thread.sleep(3000);
                getCalendarListGolf("ya29.a0AfH6SMDnheYfEit0lHZoiC4snVNPkxx_jYOsFh39lqqopIyEY8lnU1xZwdB03KH2rK5p_w2Xv4CRkRjk5GAGpp4kN0YFP2VymHKxboDTq38k4gT8f678maZ_B3Mc6aUfMf8fSsavGbXReC8nPWH-qZO8Udt2" , this.API_KEY);
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
   public Object generateAccessToken(String cd) throws IOException {
        System.out.println("generateAccessToken is called");

       MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
       RequestBody body = RequestBody.create(mediaType, "grant_type=authorization_code&redirect_uri=http://localhost:8081/web_app_war_exploded/calendarclbs&client_secret=PPXJWw3HAFkrMZoI0XKmGDLY&client_id=502305783354-oscnu3587fcbeha1p1h0uk681qpgapmi.apps.googleusercontent.com&code=" + cd);
       Request request2 = new Request.Builder()
               .url("https://oauth2.googleapis.com/token")
               .method("POST", body)
               .addHeader("Content-Type", "application/x-www-form-urlencoded")
               .build();
       Response response2 = this.client.newCall(request2).execute();
       this.obj.add(response2.body());
       System.out.println("this.obj " + this.obj);
        return this.obj;
   }

    public Object getCalendarListGolf(String acTkn, String apiKey) throws IOException {
        System.out.println("getCalList Called");
        Request request2 = new Request.Builder()
                .url("https://www.googleapis.com/calendar/v3/calendars/golfclubsdata@gmail.com/events?key=" + apiKey)
                .method("GET", null)
                .addHeader("Authorization", acTkn)
                .addHeader("Content-Type", "application/x-www-form-urlencoded")
                .build();
        Response response2 = this.client.newCall(request2).execute();

        return response2.body().string();
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
