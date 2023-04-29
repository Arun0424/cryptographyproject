<%-- 
    Document   : Down
    Created on : 2023 Mar 21, 06:31:32
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String FN=null;
            try{
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost/project","root","");
//FileOutputStream fos=new FileOutputStream(file);
byte b[];
Blob blob;
String name;

//PreparedStatement ps=con.prepareStatement("select * from tab1");
//ResultSet rs=ps.executeQuery();
PreparedStatement su=con.prepareStatement("Select * from tab1 where Username=?"); 
String UN=request.getParameter("Downloader");   
su.setString(1,UN);
ResultSet rs = su.executeQuery();

//String query="Select * from tab1 where Username=?";
while(rs.next()) { // for each row
   // take the blob
   blob = rs.getBlob(5);
    FN=rs.getString(4);
   File file=new File("D:\\DecryptFile\\"+FN);
   BufferedInputStream is = new BufferedInputStream(blob.getBinaryStream());
   FileOutputStream fos = new FileOutputStream(file);
   // you can set the size of the buffer
   byte[] buffer = new byte[2048];
   int r = 0;
   while((r = is.read(buffer))!=-1) {
      fos.write(buffer, 0, r);
   }
   fos.flush();
   fos.close();
   is.close();
   blob.free();
}
con.close();
su.close();
            }
catch(Exception e){
e.printStackTrace();
}
String un=request.getParameter("Downloader");   
String fn=FN;
        %>
        <form action="Decrypt" method="post">
            <br><br><br><br><br><br><br>
            <center>
            <h1> Enter the for Key Decrypt &nbsp;&nbsp;&nbsp;<input type="text" name="Key"></h1>
            <br><br><br>
            <button style="width: 120px;
                height: 40px;
                font-size: 16px;
                font-style: italic;
                border-radius: 100rem;">Decrypt</button> </center>
   <input type="hidden" name="Downloader1" id="NID" value="">
   </form><script>
        var UN1='<%=fn%>';
        //alert(UN1);
        document.getElementById("NID").value=UN1;
        </script>
   
  
   
            
        
          
</html>
