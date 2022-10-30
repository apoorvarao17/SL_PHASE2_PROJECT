<%@page import = "java.io.PrintWriter" %>
<%
String x= request.getParameter("operation");
PrintWriter out1 = response.getWriter();

if( x.equals("Change Admin Password") )
{
	out1.println("<h1 style ='color:blue';>Change Admin Password </h1>");
	out1.println("<form action='AdminPasswordChange.jsp'>");
	out1.println("<h2 style ='color:blue';> New password: <input type = 'password' name = 'new password'/>");
	out1.println("<br/>");
	out1.println("<h2 style ='color:blue';> Reenter Password:<input type = 'password' name = 'reentry password'/>");
	out1.println("<br/> <br/>");
	out1.println("<input type='submit' value= 'submit'>");
	out1.println("</form>");
	
	
}
else if(x.equals("Add new user"))
{
	out1.println("<h1 style ='color:blue';>ADD NEW USER</h1>");
	out1.println("<form action='AddNewUser.jsp'>");
	out1.println("<h3 style ='color:blue';> USERNAME:  <input  name = 'username'/> </h3>");
	out1.println("<h3 style ='color:blue';>New password: <input type = 'password' name = 'new password'/> </h3>");
	out1.println("<h3 style ='color:blue';>Reenter Password:<input type = 'password' name = 'reentry password'/> </h3>");
	out1.println("<input type='submit' value= 'submit'>");
	out1.println("</form>");
}
else if (x.equals("Add new place"))
{
	out1.println("<h1 style ='color:blue';> ADD NEW PLACE </h1>");
	out1.println("<form action='AddNewPlace.jsp'>");
	out1.println("<h3 style ='color:blue';> New Place: <input  name = 'place'/>  </h3>");
	out1.println("<br/> <br/>");
	out1.println("<h3 style ='color:blue';>airportID: <input  name = 'airportID'/>  </h3>");
	out1.println("<br/> <br/>");
	out1.println("<input type='submit' value= 'Add'>");
	out1.println("</form>");
	
}
else if(x.equals("Add new Airlines"))
{
	out1.println("<h1 style ='color:blue';>> ADD NEW AIRLINES </h1>");
	out1.println("<form action='AddNewAirline.jsp'>");
	out1.println("<h3 style ='color:blue';>New Airline: <input  name = 'airlinename'/> </h3>");
	out1.println("<br/> <br/>");
	out1.println("<h3 style ='color:blue';>idAirline: <input  name = 'idAirlines'/> </h3>");
	out1.println("<input type='submit' value= 'Add'>");
	out1.println("</form>");
}
else if(x.equals("Add new flight details"))
{
	out1.println("<h1 style ='color:blue';>> ADD NEW FLIGHT </h1>");
	out1.println("<form action='AddNewFlight.jsp'>");
	out1.println("<h3 style ='color:blue';>Enter FlightID: <input  name = 'flightID'/> </h3>");
	out1.println("<h3 style ='color:blue';>Enter AirlineID: <input  name = 'idAirlines'/> </h3>");
	out1.println("<h3 style ='color:blue';>Enter From : <input  name = 'fromAirport'/> </h3>");
	out1.println("<h3 style ='color:blue';>Enter To: <input  name = 'toAirport'/> </h3>");
	out1.println("<h3 style ='color:blue';>Enter time: <input type= 'Time' name = 'time'/> </h3>");
	out1.println("<h3 style ='color:blue';>Enter Available Seats: <input  name = 'available_seats'/> </h3>");
	out1.println("<h3 style ='color:blue';>Enter Cost: <input  name = 'Cost'/>");
	out1.println("<input type='submit' value= 'Add'>");
	out1.println("</form>");
}
/*else if(x.equals("Update flight details"))
{
	out1.println("<h1>Update flight details</h1>");
	out1.println("<form action='UpdateFlight.jsp'>");
	out1.println("New Airline: <input  name = 'airline'/>");
	out1.println("<input type='submit' value= 'Add'>");
	out1.println("</form>");
}*/

%>