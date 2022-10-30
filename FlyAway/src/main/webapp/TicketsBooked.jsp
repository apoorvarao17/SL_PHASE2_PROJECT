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

PrintWriter out1 = response.getWriter();

int noOfTickets = Integer.parseInt(session.getAttribute("noOfTickets").toString());

String flightId=  session.getAttribute("flightId").toString();

out1.println ("<h2 style ='color:blue'>Ticket details </h2>");
out1.println ("<h2 style ='color:blue'>--------------------------------------------</h2>");

out1.println("<sql:setDataSource var='database' driver='com.mysql.cj.jdbc.Driver' url='jdbc:mysql://localhost:3306/studentdb?useSSL=false'user= 'root' password = 'Bhruguni17'/>");


try{
	Connection connection = DatabaseConnection.getConnection();
	
	
	//Get flight details
	String query = "select * from flights WHERE (flightID = '"+ flightId +"')";
	Statement statement = connection.createStatement();
	ResultSet resultSet = statement.executeQuery(query);
	
	Date date=null;
	Time time=null;
	long no_of_seats =0;
	while (resultSet.next())
	{
		date = resultSet.getDate("date");
		time = resultSet.getTime("time");
		no_of_seats=resultSet.getLong("available_seats");  
    }
	
	//Insert passenger into bookings table in database and show the generated ticket number
	for(int i = 0; i < noOfTickets; i++)
	{
		String param = "name"+i; 
		String name = request.getParameter(param);
		param = "passportNo"+i;
		String ppno= request.getParameter(param);
		param = "Sex"+i;
		String gender= request.getParameter(param);
		param = "Age"+i;
		
		int age= 0;
		if(request.getParameter(param) != ""){
			age = Integer.parseInt(request.getParameter(param));
		}
		
		if(name!=null && ppno!=null && gender!=null && age != 0)
		{
			
			String sql = "INSERT INTO bookings (ticketNo,flightID,pname,passportno,sex,age,date,time) VALUES (?,?,?,?,?,?,?,?)";
			PreparedStatement pstatement = connection.prepareStatement(sql);
			String ticketno = "TKT"+flightId+ppno;
			pstatement.setString(1,ticketno.toUpperCase());
			pstatement.setString(2, flightId.toUpperCase());
			pstatement.setString(3, name.toUpperCase());
			pstatement.setString(4, ppno.toUpperCase());
			pstatement.setString(5, gender.toUpperCase());
			pstatement.setLong(6, age);
			pstatement.setDate(7,date);
			pstatement.setTime(8,time);
			out1.println("<h3 style ='color:blue'>Traveller No:  "+(i+1)+"</h3>");
			out1.println("<h4 style ='color:blue'>Ticket No:  " +ticketno.toUpperCase() +"<br/> Name:   "+name.toUpperCase()+ "<br/>Date:   "+date.toString()+ "<br/>Time:   "+ time.toString()+"</h4>");
			out1.println("<br/>");
			out1.println ("<h2 style ='color:blue'>--------------------------------------------</h2>");
			pstatement.executeUpdate();
		}
		else
		{
			out1.println ("<h2 style ='color:blue'>All details are not entered. Go back and reenter</h2>");
			break;
		}
		
	}

	no_of_seats= no_of_seats - noOfTickets;
	
	//Update number of seats available in selected flight
	String sql1 = "UPDATE flights SET available_seats = ? WHERE (flightID = ? )";
	PreparedStatement pstatement1 = connection.prepareStatement(sql1);
	pstatement1.setLong(1, no_of_seats);
	pstatement1.setString(2, flightId);
	pstatement1.executeUpdate();
	
	out1.println("<h1> Thank you!!</h1>");
	
	connection.close();;
}
catch(Exception e)
{
	e.printStackTrace();	
}


%>
</head>
</html>