package com.example.web_app;

import java.io.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "helloServlet", value = "/calculate")
public class HelloServlet extends HttpServlet {
    /*private String message;

    public void init() {
        message = "New text";
    }*/

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
       // response.setContentType("text/html");

        String getNumOne = request.getParameter("numOne");
        String getNUmTwo = request.getParameter("numTwo");

        int calcResult = Integer.parseInt(getNumOne) + Integer.parseInt(getNUmTwo);
        PrintWriter out = response.getWriter();
        out.println("Num One is " +  getNumOne + " Num two is " + getNUmTwo + " result is " + calcResult);
    }

    public void destroy() {
    }
}