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
    List<String> tourTopic = new ArrayList<String>();
    List<String> tourPhotosArray = new ArrayList<String>();
    List<String> tourDescription = new ArrayList<String>();
    List<String> tourMarketNames = new ArrayList<String>();
    List<Integer> tourPriceAmn = new ArrayList<Integer>();
    List<String> addressLineText = new ArrayList<String>();
    List<String> cityName = new ArrayList<String>();
    List<String> placeName = new ArrayList<String>();
    List<String> organizationName = new ArrayList<String>();
    List<String> imageUrlAdr = new ArrayList<String>();
    List<String> assetName = new ArrayList<String>();
    List<String> salesStatus = new ArrayList<String>();
    List<String> stateProvince = new ArrayList<String>();
    List<String> contactPhone = new ArrayList<String>();

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
            Thread.sleep(9000);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/tours.jsp");
            dispatcher.forward(request,response);
        } catch (ServletException | IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
    private void getGolfTours(HttpServletRequest request) throws IOException {
        Request request2 = new Request.Builder()
                .url("http://api.amp.active.com/v2/search/?near=Seattle&state=WA&query=golf&current_page=1&per_page=10&sort=distance&exclude_children=true&api_key=4edvmhsp6bxum82runu798xp")
                .method("GET", null)
                .addHeader("Content-Type", "application/json")
                .build();
        Response response2 = this.client.newCall(request2).execute();

        String json = response2.body().string();
        JSONArray allTours = new JSONArray();

        try {
            JSONObject jst = new JSONObject(json);
            allTours = jst.getJSONArray("results");
            for (int i = 0; i < allTours.length(); i++) {

                JSONObject toursImages = allTours.getJSONObject(i);
                //JSONObject toursNames = allTours.getJSONObject(i).getJSONArray("assetTopics").getJSONObject(0).getJSONObject("topic");
                String assetDescriptions = allTours.getJSONObject(i).getJSONArray("assetDescriptions").getJSONObject(0).optString("description");
                String market = allTours.getJSONObject(i).getJSONObject("market").optString("marketName");
                JSONArray assetPrices = toursImages.optJSONArray("assetPrices");
                JSONObject toursPlace = allTours.getJSONObject(i).getJSONObject("place");

                this.tourTopic.add(toursImages.getString("assetName"));
                this.tourDescription.add(assetDescriptions);
                this.tourMarketNames.add(market);
                if(assetPrices.optJSONObject(0) != null){
                    this.tourPriceAmn.add(assetPrices.optJSONObject(0).optInt("priceAmt"));
                }
                this.addressLineText.add(toursPlace.getString("addressLine1Txt"));
                this.cityName.add(toursPlace.getString("cityName"));
                this.stateProvince.add(toursPlace.getString("stateProvinceCode"));
                this.placeName.add(toursPlace.getString("placeName"));
                this.imageUrlAdr.add(toursImages.getString("urlAdr"));
                this.assetName.add(toursImages.getString("assetName"));
                this.contactPhone.add(toursImages.getString("contactPhone"));
                this.salesStatus.add(toursImages.getString("salesStatus"));
                this.organizationName.add(toursImages.getJSONObject("organization").getString("organizationName"));
                request.setAttribute("golfTopics", this.tourTopic);
                request.setAttribute("golfDescriptions", this.tourDescription);
                request.setAttribute("golfMarketNames", this.tourMarketNames);
                request.setAttribute("golfPriceAmt", this.tourPriceAmn);
                request.setAttribute("golfAddresses", this.addressLineText);
                request.setAttribute("golfCityNames", this.cityName);
                request.setAttribute("golfStateProvince", this.stateProvince);
                request.setAttribute("golfPlaceNames", this.placeName);
                request.setAttribute("golfImageUrls", this.imageUrlAdr);
                request.setAttribute("golfAssetNames", this.assetName);
                request.setAttribute("golfSalesStats", this.salesStatus);
                request.setAttribute("golfContactPhone", this.contactPhone);
                request.setAttribute("golfOrgNames", this.organizationName);

            }

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
                .build();

        Response response2 = client.newCall(request2).execute();
        String json = response2.body().string();
        JSONArray allTrsPhotos = new JSONArray();

        try {
            JSONObject jst = new JSONObject(json);
            //this.toursPhInfo = jst.getJSONArray("categories").getJSONObject(0).getJSONArray("tiles").getJSONObject(0).getJSONObject("image").getString("contentUrl");
                    //.getJSONObject("meta").getString("description");
            //request.setAttribute("trPhDescript", this.toursInfo.toString());
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
