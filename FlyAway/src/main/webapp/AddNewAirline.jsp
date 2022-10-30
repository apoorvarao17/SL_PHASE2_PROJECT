<%@page import = "java.io.PrintWriter" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import= "java.sql.Connection"%>
<%@page import= "com.simplilearn.utils.DatabaseConnection"%>
<%@page import= "java.sql.ResultSet"%>
<%@page import= "java.sql.Statement"%>
<%
String airlinename = request.getParameter("airlinename");
String idAirlines = request.getParameter("idAirlines");


PrintWriter out1 = response.getWriter();

out1.println("<sql:setDataSource var='database' driver='com.mysql.cj.jdbc.Driver' url='jdbc:mysql://localhost:3306/studentdb?useSSL=false'user= 'root' password = 'Bhruguni17'/>");

boolean free= true;

try{
	Connection connection = DatabaseConnection.getConnection();
	String query = "select * from airlines";
	Statement statement = connection.createStatement();
	ResultSet resultSet = statement.executeQuery(query);
	while (resultSet.next())
	{
		String s= resultSet.getString("name");
		if((s.toUpperCase()).equals(airlinename.toUpperCase())){
			free =false;
			out1.println("<h2 style ='color:blue'>Airline already exists. Go back and reenter</h2>");
			break;
		}
	}
	connection.close();
}
catch(Exception e)
{
	e.printStackTrace();	
}

if(free && airlinename!=null && idAirlines !=null)
{
	try{
	Connection connection = DatabaseConnection.getConnection();
	String sql = "INSERT INTO airlines  (idAirlines, name) VALUES (?,?)";
	PreparedStatement statement = connection.prepareStatement(sql);
	statement.setString(1, idAirlines.toUpperCase());
	statement.setString(2, airlinename.toUpperCase());
	statement.executeUpdate();
	
	out1.println("<h2 style ='color:blue'>NEW AIRLINE :"+airlinename+"  added! </h2>");
	connection.close();
	}
	catch(Exception e)
	{
		e.printStackTrace();	
	}	
}
else if( free)
{
	out1.println("<h2 style ='color:blue'>Airline name or Id entered is Null. Go back and retry</h2>");
}

out1.println("<a href='"+ request.getContextPath() + "/adminservlet?name=Admin'>Return to Admin options</a>");
%>