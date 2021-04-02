package com.example.web_app;

import com.mongodb.client.*;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.bson.Document;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.List;
import java.util.concurrent.CompletableFuture;

@WebServlet(name = "login", value = "/login")
@MultipartConfig

public class Login extends HttpServlet {
   String fl = "";
   Boolean imgUpdated = false;
   String flName = "";
   Boolean isPostCalled = false;

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            System.out.println("doPost Called");
            //List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(new ServletRequestContext(request));
            if (ServletFileUpload.isMultipartContent(request)) {
                System.out.println("it is maltipart");
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload fileUpload = new ServletFileUpload(factory);
                System.out.println("afterfileUpload " + fileUpload);
                List <FileItem> items = fileUpload.parseRequest(request);
                System.out.println("items are " + items);
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
                        String getFilePath = getServletContext().getRealPath("/");
                        String mdFilePath = "";
                        if (getFilePath.contains("target")) {
                            mdFilePath = getFilePath.split("/target")[0];
                            System.out.println("without target " + mdFilePath);
                        }
                        String filePath = mdFilePath + "/src/main/webapp/images/" + fileName;
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
                            isPostCalled = true;
                        } else {
                            System.out.println("there is an error");
                        }
                    }
                }}} catch(FileUploadException e){
                    e.printStackTrace();
                }
            }
        @Override
    public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
        String getName = request.getParameter("name");
        String getPassword = request.getParameter("password");
        String getCheckBox = request.getParameter("signUp");
        System.out.println("signUp value" + getCheckBox);

        if(request.getSession().getAttribute("imgName") == null) {
            CompletableFuture.runAsync(() -> {
                cltMongoDb(request, getName, getPassword, getCheckBox);
            });
        }
        try{
            Thread.sleep(5000);
            RequestDispatcher dispatcherOne = null;
            RequestDispatcher dispatcherTwo = null;

              System.out.println( "values of request is " + request.getSession().getAttribute("imgName"));
           if( request.getSession().getAttribute("imgName") == null) {
                dispatcherOne = request.getRequestDispatcher("/index.jsp");
                dispatcherOne.forward(request,response);
               // response.reset();
            }
            else{
            dispatcherTwo = request.getRequestDispatcher("/login.jsp");
            dispatcherTwo.forward(request,response);
            }

        } catch (IOException | InterruptedException e) {
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
                }
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