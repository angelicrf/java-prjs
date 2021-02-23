package com.example.web_app;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Iterator;

@WebServlet(name = "calculator", value = "/calculate")

public class Calculator extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
       // response.setContentType("text/html");

        String getNumOne = request.getParameter("numOne");
        String getNUmTwo = request.getParameter("numTwo");

        int calcResult = Integer.parseInt(getNumOne) + Integer.parseInt(getNUmTwo);


        PrintWriter out = response.getWriter();
        MongoClient mongoClient = MongoClients.create("mongodb+srv://new-admin-calc:123456calc@clustercalc.xuacu.mongodb.net/calculate?retryWrites=true&w=majority");
        MongoDatabase database =  mongoClient.getDatabase("calculate");
        MongoCollection<Document> collection = database.getCollection("inventory");
        Document doc = new Document("name", "FromServer")
                .append("type", "SimpleData")
                .append("count", 32)
                .append("versions", Arrays.asList("One", "Two", "Three"))
                .append("info", new Document("DataOne", 769).append("CalcResult", calcResult));
        Iterator<Document> iter = collection.find(doc).iterator();
        org.bson.Document nextDocument = iter.next();
        Object myData = nextDocument.get("name");
        System.out.println(myData.toString());
        //collection.insertOne(doc);

        request.setAttribute("numCalc", Integer.toString(calcResult));
        request.setAttribute("clientName", myData.toString());
        RequestDispatcher dispatcher = request.getRequestDispatcher("/calculate.jsp");
        dispatcher.forward(request,response);
        //out.println("Num One is " +  getNumOne + " Num two is " + getNUmTwo + " result is " + calcResult);
    }

}