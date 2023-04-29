<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.Part"%>
<%@page import="java.io.*" %>
<html>
    <head>
        <center>  <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-download" viewBox="0 0 16 16">
  <path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5z"/>
  <path d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3z"/>
            </svg><br><label style="font-family: Lucida Sans,Century Gothic, Courier;font-size:50px">Download</label></center>
    </head>
    <h1>
<%
    String nm=" ";
    String em=" ";
    Blob bb=null;
   Connection conn = null;
   Statement stmt = null;
   ResultSet rs = null;
   try {
   String Name=request.getParameter("Username");%>
   
        
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project","root","");
      stmt = conn.createStatement();
     // out.println("Welcome"+Name+"<br>");
      rs = stmt.executeQuery("select * from tab1  ");
     out.println("<br><center><table style='font-family: arial, sans-serif;border-collapse: collapse;width: 50%;'>");
      out.println("<tr>");
      out.println("<th style=' border: 5px solid #dddddd;'>USERNAME</th>");
    out.println("<th style=' border: 5px solid #dddddd;'>File</th>");
    out.println("<th style=' border: 5px solid #dddddd;'>Download</th>");
    
          out.println("</tr>");

      
      while (rs.next()) {
      nm=rs.getString(1);
      em=rs.getString(4);
      if(nm.equals(Name))
      {
             out.println("<tr>");
       out.println("<td style='padding: 8px;text-align: center; border: 5px solid #dddddd;'>"+nm+"</td> ");
     out.println("<td style='padding: 5px;text-align: left; border: 5px solid #dddddd;'>"+em+"</td>");
           //out.println("</tr>");

    }
    else
    {
    out.println("  ");
    }
    }   
      rs.close();
      stmt.close();
      conn.close();
   } catch (SQLException e) {
      out.println("Unable to retrieve data from the database."+e);
   }
   %>
    </h1>
    <%
    String UN=request.getParameter("Username");
    %>
    <form action="Down.jsp" method="post">
        
   <input type="hidden" name="Downloader" id="NID" value="">
   
  <td style='padding: 5px;text-align: left; border: 5px solid #dddddd;'><button>Download</button></td>
    </tr>
   
   </form>
   <script>
        var UN1='<%=UN%>';
       // alert(UN1);
        document.getElementById("NID").value=UN1;
        </script>
   
   </html>
