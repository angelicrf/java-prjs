package com.example.web_app;

import java.io.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "calculator", value = "/calculate")
public class Calculator extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
       // response.setContentType("text/html");

        String getNumOne = request.getParameter("numOne");
        String getNUmTwo = request.getParameter("numTwo");

        int calcResult = Integer.parseInt(getNumOne) + Integer.parseInt(getNUmTwo);
        //PrintWriter out = response.getWriter();
        request.setAttribute("numCalc", Integer.toString(calcResult));
        RequestDispatcher dispatcher = request.getRequestDispatcher("/calculate.jsp");
        dispatcher.forward(request,response);
        //out.println("Num One is " +  getNumOne + " Num two is " + getNUmTwo + " result is " + calcResult);
    }

}