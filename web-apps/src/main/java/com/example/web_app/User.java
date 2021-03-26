package com.example.web_app;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.concurrent.CompletableFuture;

@WebServlet(name = "usersInfo", value = "/users")
public class User extends HttpServlet {
    String userName = null;


    public void doGet(HttpServletRequest request, HttpServletResponse response){
        //String getPassword = request.getParameter("password");
        CompletableFuture.runAsync(() -> {
           String userNameReceived =  getUserInfo(request);
           System.out.println(userNameReceived);
           request.setAttribute("username" , userNameReceived);
        });
        try{
            Thread.sleep(3000);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/users.jsp");
            dispatcher.forward(request,response);
        } catch (ServletException | IOException | InterruptedException e) {
            e.printStackTrace();
        }

    }
    public String getUserInfo(HttpServletRequest request){
        this.userName= request.getParameter("name");
        return this.userName;
    }

}
