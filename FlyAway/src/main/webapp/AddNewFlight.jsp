<%@page import = "java.io.PrintWriter" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import= "java.sql.Connection"%>
<%@page import= "com.simplilearn.utils.DatabaseConnection"%>
<%@page import= "java.sql.ResultSet"%>
<%@page import= "java.sql.Statement"%>
<%@page import= "java.sql.Time"%>
<%
String FlightID = request.getParameter("flightID");
String AirlineID = request.getParameter("idAirlines");
String fromAirport = request.getParameter("fromAirport");
String toAirport = request.getParameter("toAirport");
Time  time=Time.valueOf("07:00:00");
//Time  time= Time.valueOf(request.getParameter("time"));
int available_seats = Integer.parseInt(request.getParameter("available_seats"));
double Cost = Double.parseDouble(request.getParameter("Cost"));
boolean free= true;
boolean Airline_found=false;

PrintWriter out1 = response.getWriter();

out1.println("<sql:setDataSource var='database' driver='com.mysql.cj.jdbc.Driver' url='jdbc:mysql://localhost:3306/studentdb?useSSL=false'user= 'root' password = 'Bhruguni17'/>");



try{
	Connection connection = DatabaseConnection.getConnection();
	String query = "select * from flights";
	Statement statement = connection.createStatement();
	ResultSet resultSet = statement.executeQuery(query);
	while (resultSet.next())
	{
		String s= resultSet.getString("flightID");
		if(s.equals(FlightID.toUpperCase())){
			free =false;
			out1.println("<h2 style ='color:blue'>Flight already exists. Go back and reenter</h2>");
			break;
		}
	}
	

	String query1 = "select * from airlines";
	Statement statement1 = connection.createStatement();
	ResultSet resultSet1 = statement.executeQuery(query1);
	while (resultSet1.next())
	{
		String s= resultSet1.getString("idAirlines");
		if(s.equals(AirlineID.toUpperCase())){
			Airline_found = true;		
			break;
		}
	}
	
	if(Airline_found == false)
	{
		out1.println("<h2 style ='color:blue'>Airline ID does not exists. Go back and reenter</h2>");
	}
	
	connection.close();
}
catch(Exception e)
{
	e.printStackTrace();	
}

if(free && FlightID!=null && Airline_found == true && fromAirport !=null && toAirport != null && time!=null && available_seats!= 0 && Cost != 0)
{
	try{
	Connection connection = DatabaseConnection.getConnection();
	String sql = "INSERT INTO flights (flightID, idAirlines,fromAirport,toAirport,time,available_seats,Cost) VALUES (?,?,?,?,?,?,?)";
	PreparedStatement statement = connection.prepareStatement(sql);
	statement.setString(1, FlightID.toUpperCase());
	statement.setString(2, AirlineID.toUpperCase());
	statement.setString(3, fromAirport.toUpperCase());
	statement.setString(4, toAirport.toUpperCase());
	statement.setTime(5, time);
	statement.setLong(6, available_seats);
	statement.setDouble(7, Cost);
	statement.executeUpdate();
	
	out1.println("<h2 style ='color:blue'>NEW FLIGHT :  "+FlightID+"  added! </h2>");
	connection.close();
	}
	catch(Exception e)
	{
		e.printStackTrace();	
	}


}
out1.println("<a href='"+ request.getContextPath() + "/adminservlet?name=Admin'>Return to Admin options</a>");
%>