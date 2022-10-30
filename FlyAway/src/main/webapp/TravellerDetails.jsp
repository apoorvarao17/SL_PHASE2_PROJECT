<%@page import = "java.io.PrintWriter" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import= "java.sql.Connection"%>
<%@page import= "com.simplilearn.utils.DatabaseConnection"%>
<%@page import= "java.sql.ResultSet"%>
<%@page import= "java.sql.Statement"%>
<%@page import= "java.sql.Date"%>
<%@page import= "java.sql.Time"%>
<%@page import= "javax.servlet.http.HttpSession"%>

<html>
<head>
<title>FLight Search</title>
</head>
<body>

<%

PrintWriter out1 = response.getWriter();

int noOfTickets = Integer.parseInt(session.getAttribute("noOfTickets").toString());

out1.println ("<h2 style ='color:blue'>--------------------------------------------</h2>");
out1.println ("<h1 style ='color:green'>Payment successful!! </h1>");
out1.println ("<h2 style ='color:blue'>--------------------------------------------</h2>");


out1.println ("<h2 style ='color:blue'>Enter Traveller details </h2>");
out1.println ("<h2 style ='color:blue'>--------------------------------------------</h2>");
out1.println("<form action='TicketsBooked.jsp'>");
for(int i = 0; i < noOfTickets; i++)
{
	out1.println("<br/>");
	out1.println("<h3 style ='color:blue'>Traveller"+(i+1)+" info </h3>");
	out1.println("<br/>");
	
	out1.println("Name : <input  name = 'name"+i+"'/>");
	out1.println("</br></br>");
	
	out1.println("Passport number: <input  name = 'passportNo"+i+"'/>");
	out1.println("</br></br>");
	
	out1.println("<input type='radio' name='Sex"+i+"' value='Male'> Male");
	out1.println("<input type='radio' name='Sex"+i+"' value='Female'> Female");
	out1.println("</br></br>");
	
	out1.println("Age: <input type = 'number' name = 'Age"+i+"'/>");
	out1.println("</br></br>");	

	out1.println ("<h2 style ='color:blue'>--------------------------------------------</h2>");

}
out1.println(" <input style ='color:blue' type='submit' value= 'Submit'>");
out1.println("</form>");
%>
</head>
</html>