<%@page import = "java.io.PrintWriter" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import= "java.sql.Connection"%>
<%@page import= "com.simplilearn.utils.DatabaseConnection"%>
<%@page import= "java.sql.ResultSet"%>
<%@page import= "java.sql.Statement"%>
<%
String place = request.getParameter("place");
String airportID = request.getParameter("airportID");


PrintWriter out1 = response.getWriter();

out1.println("<sql:setDataSource var='database' driver='com.mysql.cj.jdbc.Driver' url='jdbc:mysql://localhost:3306/studentdb?useSSL=false'user= 'root' password = 'Bhruguni17'/>");

boolean free= true;

try{
	Connection connection = DatabaseConnection.getConnection();
	String query = "select * from places";
	Statement statement = connection.createStatement();
	ResultSet resultSet = statement.executeQuery(query);
	while (resultSet.next())
	{
		String s= resultSet.getString("PlaceName");
		if(s.equals(place.toUpperCase())){
			free =false;
			out1.println("<h2 style ='color:blue'>Place already exists. Go back and reenter</h2>");
			break;
		}
	}
	connection.close();
}
catch(Exception e)
{
	e.printStackTrace();	
}

if(free && place!=null && airportID !=null)
{
	try{
	Connection connection = DatabaseConnection.getConnection();
	String sql = "INSERT INTO places  (PlaceName, AirportID) VALUES (?,?)";
	PreparedStatement statement = connection.prepareStatement(sql);
	statement.setString(1, place.toUpperCase());
	statement.setString(2, airportID.toUpperCase());
	statement.executeUpdate();
	
	out1.println("<h2 style ='color:blue'>NEW PLACE :"+ place.toUpperCase()+"  added! </h2>");
	}
	catch(Exception e)
	{
		e.printStackTrace();	
	}
	

}
out1.println("<a href='"+ request.getContextPath() + "/adminservlet?name=Admin'>Return to Admin options</a>");

%>