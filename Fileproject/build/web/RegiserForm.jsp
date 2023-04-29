<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%
String name = request.getParameter("userid");
String password = request.getParameter("password");
String Email = request.getParameter("email");
if((name.equals(null) || name.equals("")) && (password.equals(null) || password.equals("")))
{
out.println("<script>alert('Field Are Empty')</script>");
}

else{
try {
	 Class.forName("com.mysql.cj.jdbc.Driver");
 Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "");
 Statement st=conn.createStatement();
 int i=st.executeUpdate("insert into tab1(Username,password,Email)values('"+name+"','"+password+"','"+Email+"')");
 out.println("<br><br><br><br><br><br><br><br>");
 out.println("<center><br><br><br><br><h1 font-size:45px>Data is successfully inserted!</h1>");
 out.println("<h1>Thank you for register ! Please <a href='Loginpage1.jsp'>Login</a> to continue.</h1></center>");
} catch (SQLException e) {
 System.out.print(e);
 e.printStackTrace();
 out.println(e);
}

}
%> 