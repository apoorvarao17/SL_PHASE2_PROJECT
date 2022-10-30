package com.simplilearn.flyaway;

import java.io.IOException;
import java.io.PrintWriter;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/adminservlet")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request,response);
	}
	private void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		
		String username = request.getParameter("name");
		PrintWriter out = response.getWriter();
		
		out.println("<html>");
		out.println("<h2 style ='color:blue';>"+username.toUpperCase()+ "  LOGIN <h2>");
		out.println("<h2 style ='color:blue';>Select operation you want to perform<h2>");
		out.println("<body>");
		out.println("<form action='AdminOperation.jsp'>");
		out.println("<select name = 'operation'>");
		out.println("<option>Change Admin Password</option>");
		out.println("<option>Add new user</option>");
		out.println("<option>Add new place</option>");
		out.println("<option>Add new Airlines</option>");
		out.println("<option>Add new flight details</option>");
		out.println("</select>");
		out.println("<br/> <br/>");
		out.println("<input type='submit' value= 'submit'>");		  
		out.println("</form>");
		out.println("</body>");
		
		out.println("<a href='"+ request.getContextPath() + "/FlyAwayHomepage.html'>Return to Homepage</a>");
		
		//list functions
		//1. Change Admin password
		//2. Add new user
		//3. Update flight data
				//a. Insert new flight
				//d. delete flight
				//c. update time
		
		out.println("</html>");		
	}
}
