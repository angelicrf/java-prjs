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

@WebServlet(name = "soccer", value = "/soccers")
public class Soccer extends HttpServlet {

    OkHttpClient client = new OkHttpClient();
    List<String> sFirstNameArray = new ArrayList<String>();
    List<String> sLastNameArray = new ArrayList<String>();
    List<String> sCountryArray = new ArrayList<String>();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        CompletableFuture.runAsync(() -> {
            try {
                getSoccerPlayersInfo(request);
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
        try{
            Thread.sleep(5000);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/soccers.jsp");
            dispatcher.forward(request,response);
        } catch (ServletException | IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
    private void getSoccerPlayersInfo(HttpServletRequest request) throws IOException {
        //https://app.sportdataapi.com/api/v1/soccer/players?apikey=4095cf70-81f4-11eb-bfee-21c43063180d&country_id=125
        Request request2 = new Request.Builder()
                .url("https://app.sportdataapi.com/api/v1/soccer/players?country_id=125")
                .method("GET", null)
                .addHeader("Content-Type", "application/json")
                .addHeader("apikey", "4095cf70-81f4-11eb-bfee-21c43063180d")
                .build();
        Response response2 = this.client.newCall(request2).execute();

        String json = response2.body().string();
        System.out.println("soccers are " + json);

        try {
            JSONObject jst = new JSONObject(json);
            JSONArray sPlayerNames = jst.getJSONArray("data");
            for (int i = 0 ; i < sPlayerNames.length(); i++){
                JSONObject obj = sPlayerNames.getJSONObject(i);
                this.sFirstNameArray.add(obj.getString("firstname"));
                this.sLastNameArray.add(obj.getString("lastname"));
            }
            request.setAttribute("sPlayersFirstNames", this.sFirstNameArray);
            request.setAttribute("sPlayersLastNames", this.sLastNameArray);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }
}
