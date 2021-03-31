package com.example.web_app;

import com.mongodb.client.*;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.bson.Document;
import sun.text.resources.FormatData;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.util.List;
import java.util.concurrent.CompletableFuture;

@WebServlet(name = "login", value = "/login")
public class Login extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String getName = request.getParameter("name");
        String getPassword = request.getParameter("password");
        String getCheckBox = request.getParameter("signUp");
        System.out.println("signUp value" + getCheckBox);
        CompletableFuture.runAsync(() -> {
            cltMongoDb(request,getName,getPassword,getCheckBox);
        });

        try{
            Thread.sleep(5000);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
            dispatcher.forward(request,response);
        } catch (ServletException | IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }

    private void cltMongoDb(HttpServletRequest request,String clName,String clPassword,String sinUp) {
        MongoClient mongoClient = MongoClients.create("mongodb+srv://new-admin-calc:123456calc@clustercalc.xuacu.mongodb.net/calculate?retryWrites=true&w=majority");
        MongoDatabase database = mongoClient.getDatabase("calculate");
        MongoCollection<Document> collection = database.getCollection("inventory");
            Document doc = new Document("name", clName)
                    .append("password", clPassword);
            FindIterable<Document> iter = collection.find(doc);
            MongoCursor<Document> cursor = iter.iterator();
        if(sinUp == null || sinUp.equals("")) {
            try {
                if (cursor.hasNext()) {
                    Document document = cursor.next();
                    request.setAttribute("clientName", document.getString("name"));
                } else {

                    request.setAttribute("clientName", "not-client");
                }
                //org.bson.Document nextDocument = iter.next()
                // nextDocument.get("name").toString());
            } catch (RuntimeException e) {
                e.printStackTrace();
            }
        }
        else{
            collection.insertOne(doc);
            request.setAttribute("clientName", clName);
        }
      };

}