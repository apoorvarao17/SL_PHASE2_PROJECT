package com.simplilearn.flyaway;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.simplilearn.utils.DatabaseConnection;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username = request.getParameter("username");
		
		String password = request.getParameter("password");
		
		HttpSession session = request.getSession();
		
		try {
				Connection connection = DatabaseConnection.getConnection();
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				
				String query = "select * from login";
				
				
				Statement statement = connection.createStatement();
				ResultSet resultSet = statement.executeQuery(query);
				
				boolean login_success = false;
				
				while (resultSet.next()) {
					if(resultSet.getString("username").equals(username) &&  
					   resultSet.getString("password").equals(password)	)
					{
						login_success = true;
						session.setAttribute("user", username);
						if(username.equals("Admin")) 
						{
							response.sendRedirect("adminservlet?name="+username);
						}
						else
						{							
							response.sendRedirect("customerservlet?name="+username);
						}
						break;
					}
				}
				
				if(!login_success)
				{
					out.println("<h2 style ='color:blue'>> Wrong UserName or Password </h2>");
					out.println("<h2style ='color:blue'> Go back to login page and re-enter </h2>");
					
				}
				
				resultSet.close();
				statement.close();
				connection.close();
				out.println("<a href='"+ request.getContextPath() + "/FlyAwayHomepage.html'>Return to Homepage</a>");
			}catch(Exception e)
			{
				e.printStackTrace();		
			}
		
		}
}
