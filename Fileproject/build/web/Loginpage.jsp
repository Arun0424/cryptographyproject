<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

<head>
<center><h1 style="color:#FFA500; font-family: Lucida Sans,Century Gothic, Courier;font-size: 60px">Secure File Shareing Using Cryptography</h1></center>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
<style>
  body{
         background:#FFFFFF ; 
        
    }
    .login-wrapper{
       background: #3A4655;;
        width: 320px;
height: 350px; 
position: absolute;
top: 40%;
left: 50%;
margin-top: -100px; 
margin-left: -150px;  
border: 1px solid #022;
box-shadow: 16px 16px 10px #444;
border-radius: 2rem;
    }
    .login-wrapper label{
        font-family: 'Roboto Medium', sans-serif;
  font-size: 16px;
  color: #000;
  font-weight: 500;

    }
    .btn{  width: 120px;
                height: 40px;
                font-size: 16px;
                font-style: italic;
                border-radius: 100rem;
}
 input[type=text] {
   border: none;
  height: 20px;
  width: 250px;
background: #3A4655;
 }    
  input[type=password]
  {
      border: none;
height: 20px;
  width: 250px;
background: #3A4655;    
  }
</style>

</head>

<body>
<div class="login-wrapper">
    
    <center><h2 style="color: #FFA500"> Login Page</h2></center>
<br>
    <label style="color: #FFA500"> UserName :</label> 
    <br>
    <br>
    <input type="text"  name="name"  class="txtname" placeholder="Username" />
<br>
<br>
<label style="color: #FFA500"> Password :</label><br>
<br>
<input type="password" name="password" placeholder="Password"/>
<br>
<br><br>
<center>
<input type="submit" value="submit" class="btn"/>
<br>
<a href="SingIn.html" style="color:#FFA500;">SignIn</a>

</center>
</div>

<%! String userdbName;

String userdbPsw;

%>

<%

Connection con= null;

PreparedStatement ps = null;

ResultSet rs = null;



String driverName = "com.mysql.cj.jdbc.Driver";

String url = "jdbc:mysql://localhost:3306/project";

String user = "root";

String dbpsw = "";



String sql = "select * from tab1 where Username=? and password=?";



String name = request.getParameter("name");

String password = request.getParameter("password");

if((name.equals(null) || name.equals("")) && (password.equals(null) || password.equals("")))
{
response.sendRedirect("Loginpage1.jsp"); 
out.println("<script>alert('Field is Empty');</script>");
}



if((!(name.equals(null) || name.equals("")) && !(password.equals(null) || 
password.equals(""))))
try{

Class.forName(driverName);

con = DriverManager.getConnection(url, user, dbpsw);

ps = con.prepareStatement(sql);

ps.setString(1, name);

ps.setString(2, password);

rs = ps.executeQuery();

if(rs.next())

{ 

userdbName = rs.getString("Username");

userdbPsw = rs.getString("password");



if(name.equalsIgnoreCase(userdbName) && password.equals(userdbPsw) )

{

//session.setAttribute("name",userdbName);

//response.sendRedirect("WelcomePage.html"); 
request.setAttribute("name", userdbName);
             
            // forwards to the message page
            
            getServletContext().getRequestDispatcher("/WelcomePage.jsp").forward(request, response);

} 
    }

else
{
//response.sendRedirect("Usernotfound.html");
//response.sendRedirect("UserNotFound()");
out.println("<script>alert('User Not Found');</script>");
///response.sendRedirect("RegiserForm.jsp");
rs.close();

ps.close(); 

}
    }
catch(SQLException sqe)

{

out.println(sqe);

} 

%>


</body>
</html>