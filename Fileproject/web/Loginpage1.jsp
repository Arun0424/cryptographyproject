<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

<head>
<center>
<h1 style="color:#FFA500; font-family: Lucida Sans,Century Gothic, Courier;font-size: 60px">Secure File Sharing Using Cryptography</h1>
</center>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script>
    function btn()
    {
     
    
    var user=document.getElementById("User1").value;
    var pass=document.getElementById("pass1").value;
    if(user.equals("")&&pass.equals(""))
    {
        alert("All Fields are Empty");
    }
}
    </script>
<title>Home</title>

<style>
    body{
         background:#FFFFFF ; 
        
    }
    .login-wrapper{
       background: #3A4655;
        width: 350px;
height: 400px; 
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
<%

Connection con= null;

PreparedStatement ps = null;

ResultSet rs = null;



String driverName = "com.mysql.jdbc.Driver";

String url = "jdbc:mysql://localhost:3306/project";

String user = "root";

String password = "";



String sql = "select * from tab1";



try {

Class.forName(driverName);

con = DriverManager.getConnection(url, user, password);

ps = con.prepareStatement(sql);

rs = ps.executeQuery(); 

%>


<body>
    <form action="Loginpage.jsp" method="post">
        
<div class="login-wrapper">
    
    <center><h2 style="color: #FFA500;font-family: Lucida Sans,Century Gothic, Courier; font-size:20px"> Login Page</h2></center>
    <br>
    <label style="color:#FFA500;font-family: Lucida Sans,Century Gothic, Courier; font-size:20px"> &nbsp;&nbsp;&nbsp;UserName :</label> 
    <br>
    <br><br>
    &nbsp;&nbsp;&nbsp;<input type="text"  name="name"  class="txtname" placeholder="Username" id="User1" />
<br>
<br>
<label style="color:#FFA500;font-family: Lucida Sans,Century Gothic, Courier; font-size:20px">&nbsp;&nbsp;&nbsp;Password :</label><br>
<br>
&nbsp;&nbsp;&nbsp;<input type="password" name="password" placeholder="Password" id="pass1"/>
<br>
<%

while(rs.next())

{

//String usertype = rs.getString("usertype");

}

}
catch(SQLException sqe)

{

out.println("home"+sqe);

}

%>


<br><br>
<br><br>
<center>
<input type="submit" value="submit" class="btn" onclick="btn()"/>
</center>
</div>
    </form>
</body>
</html>
