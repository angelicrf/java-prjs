package com.example.web_app;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

import javax.imageio.ImageIO;
import javax.imageio.stream.ImageInputStream;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.awt.image.BufferedImage;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "upImg", value = "/upImg")
@MultipartConfig
public class UpImg extends HttpServlet {
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
                        doGet(request, response, filePath);
                    } else {
                        System.out.println("there is an error");
                    }
                }
            }
        } catch (Exception e) {
            throw new ServletException("Cannot parse multipart request.", e);
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response, String f) throws IOException, ServletException {
        try {
            Thread.sleep(5000);
            response.setContentType("image/jpeg");
            request.getSession().setAttribute("newPath", f);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/upImg.jsp");
            System.out.println("done firstGet");
            dispatcher.forward(request, response);
            System.out.println("done secondGet");
        } catch (ServletException | IOException | InterruptedException e) {
            e.printStackTrace();
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
    public static void copyFile(String from, String to) throws IOException{
        Path src = Paths.get(from);
        Path dest = Paths.get(to);
        Files.copy(src, dest, StandardCopyOption.REPLACE_EXISTING);
    }
}