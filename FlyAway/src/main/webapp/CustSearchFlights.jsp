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
String source = request.getParameter("fromAirport");
String dest = request.getParameter("toAirport");
Date  date = Date.valueOf(request.getParameter("Date"));

int no_of_travellers= Integer.parseInt(request.getParameter("no_of_travellers"));

session = request.getSession();
session.setAttribute("noOfTickets", no_of_travellers);

PrintWriter out1 = response.getWriter();

out1.println("<sql:setDataSource var='database' driver='com.mysql.cj.jdbc.Driver' url='jdbc:mysql://localhost:3306/studentdb?useSSL=false'user= 'root' password = 'Bhruguni17'/>");

if((source.toUpperCase()).equals(dest.toUpperCase()))
{
	out1.println("<h2 style ='color:blue'> Source and Destination cannot be same please go back and reenter </h2>");
}
else
{
	try{
		Connection connection = DatabaseConnection.getConnection();
		String query = "select * from flights WHERE (fromAirport = '"+ source+"'AND toAirport = '"+dest+"' AND available_seats >'"+ no_of_travellers + "')";
		Statement statement = connection.createStatement();
		ResultSet resultSet = statement.executeQuery(query);
		
		int count =0;
	
		out1.printf("<h2 style ='color:blue'> Flights <br/><br/> From: %s <br/><br/>  To: %s <br/><br/>  Date: %s <br/><br/> No of travellers: %d </h2>",source,dest, date.toString(),no_of_travellers);
		out1.println("<br/><br/>");
		
		out1.println("<form action='Payment.jsp' method = 'post'>");
		while (resultSet.next())
		{
				count++;
				String flightId = resultSet.getString("flightID");
				String airlineId = resultSet.getString("idAirlines");
				String from = resultSet.getString("fromAirport");
				String toAiport = resultSet.getString("toAirport");
				Time  time = resultSet.getTime("time");
				long seatsAvailable = resultSet.getLong("available_seats");
				double cost_per_seat =  resultSet.getDouble("Cost");
		
				String option_string = "<h4 style ='color:FireBrick'>("+count+"):  (Flight ID:  "+flightId +") (Time: " +time.toString()+")    (Seats available:"+seatsAvailable + ")  ( Cost:"+cost_per_seat+")</h4>";
				out1.println("<input style ='color:FireBrick' type='radio' name='option' value='"+flightId+"'>"+ option_string);
		}
		
		if(count==0)
			out1.println("<h2 style ='color:blue'> NO Flights available</h2>");
		else
			out1.println("<h2 style ='color:blue'> Select your flight</h2>");
		
		out1.println(" <input type='submit' value= 'Book Flight'>");
		
		out1.println("</form>");
		
		out.println("<a href='"+ request.getContextPath() + "/FlyAwayHomepage.html'>Return to Homepage</a>");
		
		connection.close();
	}
	catch(Exception e)
	{
		e.printStackTrace();	
	}

}

%>
</body>
</html>