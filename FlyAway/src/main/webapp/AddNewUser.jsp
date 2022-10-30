<%@page import = "java.io.PrintWriter" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import= "java.sql.Connection"%>
<%@page import= "com.simplilearn.utils.DatabaseConnection"%>
<%@page import= "java.sql.ResultSet"%>
<%@page import= "java.sql.Statement"%>
<%
String un = request.getParameter("username");
String x= request.getParameter("new password");
String y= request.getParameter("reentry password");

PrintWriter out1 = response.getWriter();

out1.println("<sql:setDataSource var='database' driver='com.mysql.cj.jdbc.Driver' url='jdbc:mysql://localhost:3306/studentdb?useSSL=false'user= 'root' password = 'Bhruguni17'/>");

boolean free= true;

try{
	Connection connection = DatabaseConnection.getConnection();
	String query = "select * from login";
	Statement statement = connection.createStatement();
	ResultSet resultSet = statement.executeQuery(query);
	while (resultSet.next())
	{
		if(resultSet.getString("username").equals(un)){
			free =false;
			out1.println("<h2style ='color:blue'>Username already exists. Go back and reenter</h2>");
			break;
		}
	}
	connection.close();
}
catch(Exception e)
{
	e.printStackTrace();	
}

if(x.equals(y) && free)
{
	try{
	Connection connection = DatabaseConnection.getConnection();
	String sql = "INSERT INTO login  (username, password) VALUES (?,?)";
	PreparedStatement statement = connection.prepareStatement(sql);
	statement.setString(1, un);
	statement.setString(2, x);
	statement.executeUpdate();
	
	out1.println("<h2 style ='color:blue'>NEW USER :   "+un.toUpperCase()+"  created </h2>");
	connection.close();
	
	}
	catch(Exception e)
	{
		e.printStackTrace();	
	}
	

}
out1.println("<a href='"+ request.getContextPath() + "/adminservlet?name=Admin'>Return to Admin options</a>");

%>