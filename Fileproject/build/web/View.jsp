<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.Part"%>
<%@ page import="java.io.*" %>
<html>
    <head>
    <body>
        <center> <svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
  <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0Zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4Zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10Z"/>
        </center>
            </svg>
    </body>
    <h1>
<%
    String nm=" ";
    String em=" ";
    Blob bb=null;
   Connection conn = null;
   Statement stmt = null;
   ResultSet rs = null;
   try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project","root","");
      stmt = conn.createStatement();
      rs = stmt.executeQuery("select * from tab1 ");
      out.println("<center><label style='font-family: arial, sans-serif;'>PEOPLE'S</label></center>");
      out.println("<br><center><table style='font-family: arial, sans-serif;border-collapse: collapse;width: 50%;'>");
      out.println("<tr>");
      out.println("<th style=' border: 5px solid #dddddd;'>USERNAME</th>");
    out.println("<th style=' border: 5px solid #dddddd;'>EMAIL</th>");
          out.println("</tr>");

       while (rs.next()) {
      nm=rs.getString(1);
      em=rs.getString(3);
            out.println("<tr>");
       out.println("<td style='padding: 8px;text-align: center; border: 5px solid #dddddd;'>"+nm+"</td> ");
     out.println("<td style='padding: 5px;text-align: left; border: 5px solid #dddddd;'>"+em+"<td>");
           out.println("</tr>");

    } 
    out.println("</table>");
      
      rs.close();
      stmt.close();
      conn.close();
   } catch (SQLException e) {
      out.println("Unable to retrieve data from the database."+e);
   }
   %>
    </h1>
    </head>
   </html>
