
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>upImage</title>
</head>
<body>
<h2>IpImg Page</h2>
<% Object imageName = request.getSession().getAttribute("imgName");
   Object imageUpdated = request.getSession().getAttribute("imgUploaded");
   System.out.println("ImgName clientSide " + imageName);
%>
<%  String newUploaded = imageUpdated.toString();
    if(newUploaded.equals("true")) {%>
<img alt="uploaded image" src="./images/<%=imageName%>" style="width: 250px; height: 300px;"/>
<%}%>
</body>
</html>
