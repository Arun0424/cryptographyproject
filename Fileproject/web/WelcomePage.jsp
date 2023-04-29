<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <style>
            .welcome{
                background: #3A4655;;
        width: 1700px;
height: 360px; 
position: absolute;
top: 25%;
left: 20%;
margin-top: -100px; 
margin-left: -320px;  
border: 1px solid #022;
box-shadow: 16px 16px 20px #444;
border-radius: 2rem;
            }
            .welbtn1{
                left: 20%;
                width: 120px;
                height: 40px;
                font-size: 16px;
                font-style: italic;
                border-radius: 100rem;
                background: #3A4655;

            }
             .welbtn2{
                 background: #3A4655;
                width: 120px;
                height: 40px;
                font-size: 16px;
                font-style: italic;
                border-radius: 100rem;
            } 
            .welbtn3{
                background: #3A4655;;
                width: 120px;
                height: 40px;
                font-size: 16px;
                font-style: italic;
                border-radius: 100rem;
            }
        </style>
    <body>
    <center> 
        <h1> Welcome<p id="Name"><%=request.getAttribute("name")%></p></h1>
        <div class="welcome">
            <a  href="LogOut.html" style= "color:#FFA500; margin-left: 1350px; font-size: 35px;">Logout</a><br> <a href="SingIn.html" style= "color:#FFA500; margin-left: 1350px;font-size: 35px;">SignIn</a>
            <p style="transform: translate(-40%, -100%);color:#FFA500;    font-family: Lucida Sans,Century Gothic, Courier; font-size: 50px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;HomePage</p>            
            <br><br><br><br>
        <form action="UploadFile.jsp">
            <center>
                <button class="welbtn1"style="transform: translate(-250%, -130%);"><input type="hidden" name="Username" id="Username1" value="">UploadFile&nbsp;<i class="fa fa-upload" style="color:#FFA500;"></i></button></form><br><br><br><br>
                <form action="DownloadFile.jsp"> 
                    <input type="hidden" name="Username" id="Username2" value="..">
                    <button class="welbtn2"style="transform: translate(-100%,-365%);">DowloadFile<i class="fa fa-download" style="color:#FFA500;"></i></button>
                </form>
                <br><br><br>
                <form action="View.jsp">
                    <input type="hidden" name="Username" id="Username3" value="">
                    <button class="welbtn3" style="transform: translate(50%, -600%);">View List&nbsp;&nbsp;&nbsp;<i class='fas fa-user-alt' style="color:#FFA500;"></i></button></center>
        </div>
        </form>
               
<script>
            var UN= document.getElementById("Name").innerHTML;
           // alert(UN);
             document.getElementById("Username1").value = UN;
             document.getElementById("Username2").value = UN;
             document.getElementById("Username3").value = UN;
             
            </script>
       
    </center>
       </head>
       <center><h1 style=" font-family: Lucida Sans,Century Gothic, Courier;transform: translate(0%, 1100%); text-align: center; font-size:40px">Secure File Storage & Shareing Using Cryptography</h1></center>
    </body>
</html>
