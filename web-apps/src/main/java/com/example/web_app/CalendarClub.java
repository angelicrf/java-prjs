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
    List<Object> obj = new ArrayList<>();
    public void doGet(HttpServletRequest request, HttpServletResponse response) {

        CompletableFuture.runAsync(() -> {
            request.setAttribute("msgData", "Received");
         });
        //0 - 1- 5
        CompletableFuture.runAsync(() -> {
            try {
                Thread.sleep(3000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            this.storeCode = getCodeFromUrl(request);
        });
        CompletableFuture.runAsync(() -> {
            try {
                Thread.sleep(3000);
                System.out.println("this.storecode is " + this.storeCode);
                generateAccessToken(this.storeCode);
                this.storeAccTkn = this.obj.get(0).toString();

            } catch (IOException | InterruptedException e) {
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
/*    private static final String CREDENTIALS_FILE_PATH = "/client_secret_502305783354-oscnu3587fcbeha1p1h0uk681qpgapmi.apps.googleusercontent.com.json";
    private static final List<String> SCOPES = Collections.singletonList(CalendarScopes.CALENDAR_READONLY);
    private static final String APPLICATION_NAME = "GolfClubsData";*/
    OkHttpClient client = new OkHttpClient();
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
       System.out.println("this.AccessTkn " + this.obj);
        return this.obj;
   }
   /*
   public void readMyFile() throws IOException {
       
    InputStream input = getClass().getResourceAsStream("/client_secret_502305783354-oscnu3587fcbeha1p1h0uk681qpgapmi.apps.googleusercontent.com.json");
       InputStreamReader isr = new InputStreamReader(input,StandardCharsets.UTF_8);
       BufferedReader br = new BufferedReader(isr);

         String line;
           while ((line = br.readLine()) != null) {
               System.out.println(line);
           }*//*

   }

    public static Credential getCredentials() throws IOException{
        System.out.println("getCredentials called");
        GoogleClientSecrets.Details tg = new GoogleClientSecrets.Details()
                .setClientId("502305783354-oscnu3587fcbeha1p1h0uk681qpgapmi.apps.googleusercontent.com")
                .setRedirectUris(Collections.singletonList("http://localhost"))
                .setClientSecret("PPXJWw3HAFkrMZoI0XKmGDLY")
                .setAuthUri("https://accounts.google.com/o/oauth2/auth")
                .setTokenUri("https://oauth2.googleapis.com/token");

        GoogleClientSecrets fr = new GoogleClientSecrets().setWeb(tg);
        System.out.println("gs is ");

        //FileDataStoreFactory fileDataStoreFactory = new FileDataStoreFactory(new File("/web-apps/src/main/java/resources/"));
        DataStore<String> dataStore = MemoryDataStoreFactory.getDefaultInstance().getDataStore("users");
                //fileDataStoreFactory.getDataStore("credentials");
        GoogleAuthorizationCodeFlow flow = (new GoogleAuthorizationCodeFlow.Builder(
                new NetHttpTransport(),JacksonFactory.getDefaultInstance(),
                //"502305783354-oscnu3587fcbeha1p1h0uk681qpgapmi.apps.googleusercontent.com",
                //"PPXJWw3HAFkrMZoI0XKmGDLY",
                fr,
                SCOPES
        ))
                .setAccessType("offline")
                //.setApprovalPrompt("auto")
               // .setCredentialDataStore(dataStore)
               .setCredentialCreatedListener((credential, tokenResponse) -> {
                    System.out.println("Token called ");
                    System.out.println("Credentials is " + credential);
                    dataStore.set("id_token", tokenResponse.get("id_token").toString());})
                .addRefreshListener(new CredentialRefreshListener() {
                    public void onTokenResponse(Credential credential, TokenResponse tokenResponse) throws IOException {
                        System.out.println("Token called2 ");
                        dataStore.set("id_token", tokenResponse.get("id_token").toString());
                    }
                    public void onTokenErrorResponse(Credential credential, TokenErrorResponse tokenErrorResponse) throws IOException {
                        //handle token error response
                        System.out.println("there is an error");
                    }
                })
                .build();
                System.out.println("MemoryStored " + flow.getRefreshListeners() + dataStore.values());

               //Credential credential = flow.loadCredential("user");
             Credential credential = new AuthorizationCodeInstalledApp(flow, new LocalServerReceiver()).authorize("user");
             System.out.println("credential is " + credential);

*//*        GoogleAuthorizationCodeRequestUrl authorizationUrl = flow.newAuthorizationUrl();
        authorizationUrl.setRedirectUri("http://localhost");
        System.out.println("url is " + authorizationUrl.getRedirectUri());*//*


        //System.out.println("receiver " + receiver.getRedirectUri());
                //.getRedirectUri());
        LocalServerReceiver receiver = new LocalServerReceiver.Builder().setPort(8082).build();
        Credential credential2 = new AuthorizationCodeInstalledApp(flow, new LocalServerReceiver()).authorize("user");
        System.out.println(credential2.getAccessToken());
        return credential2;
    };

    public static void getData() throws IOException, GeneralSecurityException, InstantiationException, IllegalAccessException {
  //request.getSession().getId()
        NetHttpTransport HTTP_TRANSPOR = new NetHttpTransport();
                //GoogleNetHttpTransport.newTrustedTransport();
        //System.out.println("before funcone" + getCredentials());
        Calendar service = new Calendar.Builder(HTTP_TRANSPOR, JacksonFactory.getDefaultInstance(), getCredentials())
                //.setApplicationName(APPLICATION_NAME)
                .build();
        System.out.println("inside function2");

        DateTime now = new DateTime(System.currentTimeMillis());
        Events events = service.events().list("primary")
                .setMaxResults(10)
                .setTimeMin(now)
                .setOrderBy("startTime")
                .setSingleEvents(true)
                .execute();
        List<Event> items = events.getItems();
        if (items.isEmpty()) {
            System.out.println("No upcoming events found.");
            events.setDescription("MyInterview")
                    .setTimeZone("America/Seattle");
        } else {
            System.out.println("Upcoming events");
            for (Event event : items) {
                DateTime start = event.getStart().getDateTime();
                if (start == null) {
                    start = event.getStart().getDate();
                }
                System.out.printf("%s (%s)\n", event.getSummary(), start);
            }
        }
    }*/
}
