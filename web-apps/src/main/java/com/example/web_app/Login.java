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
import javax.servlet.annotation.MultipartConfig;
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
@MultipartConfig

public class Login extends HttpServlet {
   String fl = "";
   Boolean imgUpdated = false;
   String flName = "";
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    System.out.println("isTextFile");
                    String fieldName = item.getFieldName();
                    System.out.println("fieldNAme " + fieldName);
                    String fieldValue = item.getString();
                    System.out.println("fieldValue " + fieldValue);

                } else {
                    System.out.println("isFile");
                    response.setContentType("image/jpeg");
                    String fileName = FilenameUtils.getName(item.getName());
                    InputStream fileContent = new BufferedInputStream(item.getInputStream());
                    String filePath = "/home/bcuser/Git/java-prjs/web-apps/src/main/webapp/images/" + fileName;
                    Boolean getResult = getFileUpload(fileContent, filePath);
                    if (getResult) {
                        this.flName = fileName;
                        this.imgUpdated = true;
                        this.fl = filePath;
                        response.setContentType("image/jpeg");
                        request.getSession().setAttribute("imgUploaded", this.imgUpdated);
                        request.getSession().setAttribute("imgName", this.flName);
                        request.getSession().setAttribute("newPath", this.fl);
                        doGet(request, response);

                    } else {
                        System.out.println("there is an error");
                    }
                }
            }
        } catch (Exception e) {
            throw new ServletException("Cannot parse multipart request.", e);
        }
    }
    @Override
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
      }

    public Boolean getFileUpload(InputStream is, String fPath) {
        boolean uploaded = false;
        try {
            byte[] byt = new byte[is.available()];
            System.out.println("is available " + is.available());
            ByteArrayOutputStream bArray = new ByteArrayOutputStream();
            int i = 0;
            while ((i = is.read(byt)) > -1) {
                System.out.println("is Read done");
                bArray.write(byt,0,i);
            }
            bArray.close();
            is.close();

            byte [] res = bArray.toByteArray();
            FileOutputStream fs = new FileOutputStream(fPath);
            fs.write(res);
            fs.close();

            uploaded = true;
            return uploaded;
        } catch (IOException fileNotFoundException) {
            fileNotFoundException.printStackTrace();
        }
        return uploaded;
    }

}