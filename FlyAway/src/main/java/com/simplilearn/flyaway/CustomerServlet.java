package com.simplilearn.flyaway;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.simplilearn.utils.DatabaseConnection;

@WebServlet("/customerservlet")
public class CustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public CustomerServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String username = request.getParameter("name");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();	
	
		try {
			Connection connection = DatabaseConnection.getConnection();
		
			String query = "select * from places";
			
			
			Statement statement = connection.createStatement();
			ResultSet resultSet = statement.executeQuery(query);
			String[] place = new String[50];
			int count = 0;
			while(resultSet.next()) {

				place[count++] = resultSet.getString("PlaceName");			
			}
			

		
			out.println("<html>");
			out.println("<h1 style ='color:blue'>Logged in as:"+ username +"!! Weclome!! </h1>");
			out.println("<h2 style ='color:blue'>--------------------------------------------</h2>");
			out.println("<h2 style ='color:blue'>Enter Travel details </h2>");
			out.println("<form action='CustSearchFlights.jsp'>");
			out.println("<h3 style ='color:blue'>Enter Source : </h3>");
			out.println("<select name = 'fromAirport'>");		
			for(int i=0; i<count;i++) {

				out.println("<option>"+place[i]+"</option>");				
			}
			out.println("</select>");
			out.println("<h3 style ='color:blue'>Enter Destination:</h3>"); 
			out.println("<select name = 'toAirport'>");
			for(int i=0; i<count;i++) {

				out.println("<option>"+place[i]+"</option>");				
			}	
			out.println("</select>");
			out.println("<h3 style ='color:blue'>Enter Date of travel: <input type= 'Date' name = 'Date'/> </h3>");
			out.println("<h3 style ='color:blue'>Enter number of travellers: <input  type ='number' name = 'no_of_travellers'/> </h3>");
			out.println("<input type='submit' value= 'Search Flights'>");
			
			out.println("</html>");
			
			resultSet.close();
			statement.close();
			connection.close();
			
		}catch(Exception e)
		{
			e.printStackTrace();

		}
		
		out.println("<a href='"+ request.getContextPath() + "/FlyAwayHomepage.html'>Return to Homepage</a>");
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
