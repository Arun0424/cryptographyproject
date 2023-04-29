<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>File Upload to Database Demo</title>
<B><h1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Secure File Shareing& Storage Using Cryptography</h1></B>
<style>
    body{
         background: #d7f3ea;
        color:#FFA500;
    }
    .UploadClass
    {
        background: #3A4655;
        width: 450px;
height: 480px; 
position: absolute;
top: 40%;
left: 50%;
margin-top: -130px; 
margin-left: -150px;  
border: 1px solid #022;
box-shadow: 16px 16px 10px #444;
border-radius: 2rem;

    }
    
    .btn2
    {
          width: 120px;
                height: 40px;
                font-size: 16px;
                font-style: italic;
                border-radius: 100rem;
    }
    input[type=file] {
   border: none;
  height: 30px;
  width: 250px;
background:#FFA500;
border-radius: 50rem;
 }

    </style>
</head>
<body>
    <svg style='margin-top:350px; margin-left: 250px; 'xmlns="http://www.w3.org/2000/svg" width="230" height="190" fill="currentColor" class="bi bi-arrow-bar-up" viewBox="0 0 16 16" >
  <path fill-rule="evenodd" d="M8 10a.5.5 0 0 0 .5-.5V3.707l2.146 2.147a.5.5 0 0 0 .708-.708l-3-3a.5.5 0 0 0-.708 0l-3 3a.5.5 0 1 0 .708.708L7.5 3.707V9.5a.5.5 0 0 0 .5.5zm-7 2.5a.5.5 0 0 1 .5-.5h13a.5.5 0 0 1 0 1h-13a.5.5 0 0 1-.5-.5z"/>
    </svg>
<label style='font-family: arial, sans-serif; margin-left: -200px;font-size: 30px;font-style: italic;'>&nbsp;&nbsp;UploadFile</label>
    <center>
        <%
            String Name=request.getParameter("Username");
        %>
        <br><br>
        
        <form method="post" action="uploadServlet" enctype="multipart/form-data">
            <table border="0">
                <div class="UploadClass">
                <br><br>
                    <label style="color:#FFA500;font-size: 25px">  UserName</label>
                <br><br>
                    <input type="text" name="usename"/>
                    <br><br>
                     <label style="color:#FFA500;font-size: 25px"> Email </label>
                     <br><br>
                    <input type="text" name="useEmail"/>
                    <br><br><br>
                   <label style="color:#FFA500;font-size: 25px">  Set a Password: </label>
                    <input type="text" name="key"/>
                    <br><br><br>
                    <label style="color:#FFA500;font-size: 25px"> Choose a File </label>
                    <br><br>
                    <br>
                    <input type="file" name="photo" size="50"/>
                    <br><br><br>
                         <input type="submit" value="Upload" class="btn2">
                </div>
                
                   </form>
    </center>
</body>
</html> 	