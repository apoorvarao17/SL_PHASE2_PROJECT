<%@page import = "java.io.PrintWriter" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import= "java.sql.Connection"%>
<%@page import= "com.simplilearn.utils.DatabaseConnection"%>
<%
String x = request.getParameter("new password");
String y = request.getParameter("reentry password");

PrintWriter out1 = response.getWriter();

out1.println("<sql:setDataSource var='database' driver='com.mysql.cj.jdbc.Driver' url='jdbc:mysql://localhost:3306/studentdb?useSSL=false'user= 'root' password = 'Bhruguni17'/>");

if(x.equals(y))
{
	try{
		Connection connection = DatabaseConnection.getConnection();
		String sql = "UPDATE login SET password = ? WHERE (username = ?)";
		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setString(1,  x);
		statement.setString(2, "Admin");
		statement.executeUpdate();
		
		out1.println("<h2 style ='color:blue';>Admin password updated!</h2>");
	}
	catch(Exception e)
	{
		e.printStackTrace();	
	}
}
else
{
	out1.println("<h2 style ='color:blue';>Rentered password mismatches.Please Go back and retry</h2>");
}
out1.println("<a href='"+ request.getContextPath() + "/adminservlet?name=Admin'>Return to Admin options</a>");

%>