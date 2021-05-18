package com.example.web_app;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "comments", value = "/comments")
@MultipartConfig
public class Comments extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
       String showMsReview = request.getParameter("allReviews");
       System.out.println(showMsReview);
       if(showMsReview != null){
           request.setAttribute("seeReviews", "allSet");
       }
        RequestDispatcher dispatcher= request.getRequestDispatcher("/comments.jsp");
        dispatcher.forward(request,response);
    }
}
