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
String flightID = request.getParameter("option");

int noOfTickets = Integer.parseInt(session.getAttribute("noOfTickets").toString());

session.setAttribute("flightId",flightID);

double totalcost=0.0;

PrintWriter out1 = response.getWriter();

out1.println( "<h1 style ='color:blue'>Payment Page</h1>");

out1.println("<sql:setDataSource var='database' driver='com.mysql.cj.jdbc.Driver' url='jdbc:mysql://localhost:3306/studentdb?useSSL=false'user= 'root' password = 'Bhruguni17'/>");

out1.println("<form action='TravellerDetails.jsp'>");
try{
	Connection connection = DatabaseConnection.getConnection();
	String query = "select * from flights WHERE (flightID = '"+ flightID +"')";
	Statement statement = connection.createStatement();
	ResultSet resultSet = statement.executeQuery(query);
	
	while (resultSet.next())
	{
		double costperticket= resultSet.getDouble("Cost");
		totalcost = costperticket*noOfTickets;
		
		out1.println("<h3 style ='color:blue'>Cost per ticket:  "+costperticket+"<br/><br/> No of Tickets:  "+noOfTickets +"<br/><br/>Total amount to be paid:   "+ totalcost + "</h3>");
	}

	
	out1.println(" <input style ='color:blue' type='submit' value= 'Pay'>");

	out1.println("</form>");	
	
	connection.close();
}
catch(Exception e)
{
	e.printStackTrace();	
}

%>
</body>
</html>