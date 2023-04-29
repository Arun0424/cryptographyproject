/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.security.spec.KeySpec;
import java.sql.*;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;
import java.security.AlgorithmParameters;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.SecureRandom;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

/**
 *
 * @author user
 */
@WebServlet(urlPatterns = {"/Decrypt"})
public class Decrypt extends HttpServlet {
    String FN=null;
String Filename=null;
    // database connection settings
    private final String dbURL = "jdbc:mysql://localhost:3306/project";
    private final String dbUser = "root";
    private final String dbPass = "";
     PreparedStatement statement=null;
     String FileName=null;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Decrypt</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<center><h1>File Successfully Downloaded</h1></center>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = null; // connection to the database
        String message = null;  // message will be sent back to client
         ResultSet rs = null;
        try {
            // connects to the database
            Class.forName("com.mysql.cj.jdbc.Driver");

            try {
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            } catch (SQLException ex) {
                Logger.getLogger(Decrypt.class.getName()).log(Level.SEVERE, null, ex);
            }
 
            // constructs SQL statement
             FN=request.getParameter("Downloader1");
            String sql = "Select * from tab1 where Username=?";
            try {
                statement = conn.prepareStatement(sql);
               // statement.setString(1, name);
                statement.executeQuery();
                while(rs.next())
                {
                    FileName=rs.getString(4);
                }
                
            } catch (SQLException ex) {
                Logger.getLogger(Decrypt.class.getName()).log(Level.SEVERE, null, ex);
            }
             
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (conn != null) {
                // closes the database connection
                try {
                    conn.close();
                } catch (SQLException ex) {
                }
            }
        
        try {
            processRequest(request, response);
            String password =request.getParameter("Key");
           // password="java@123";
            // reading the salt
            // user should have secure mechanism to transfer the
            // salt, iv and password to the recipient
            FileInputStream saltFis = new FileInputStream("D:\\DecryptFile\\salt.enc");
            byte[] salt = new byte[8];
            saltFis.read(salt);
            saltFis.close();
            
            // reading the iv
            FileInputStream ivFis = new FileInputStream("D:\\DecryptFile\\iv.enc");
            byte[] iv = new byte[16];
            ivFis.read(iv);
            ivFis.close();
            
            SecretKeyFactory factory = SecretKeyFactory
                    .getInstance("PBKDF2WithHmacSHA1");
            KeySpec keySpec = new PBEKeySpec(password.toCharArray(), salt, 65536,
                    256);
            SecretKey tmp = null;
            try {
                tmp = factory.generateSecret(keySpec);
            } catch (InvalidKeySpecException ex) {
                Logger.getLogger(Decrypt.class.getName()).log(Level.SEVERE, null, ex);
            }
            SecretKey secret = new SecretKeySpec(tmp.getEncoded(), "AES");
            
            // file decryption
            Cipher cipher = null;
            try {
                cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            } catch (NoSuchPaddingException ex) {
                Logger.getLogger(Decrypt.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                cipher.init(Cipher.DECRYPT_MODE, secret, new IvParameterSpec(iv));
            } catch (InvalidKeyException ex) {
                Logger.getLogger(Decrypt.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvalidAlgorithmParameterException ex) {
                Logger.getLogger(Decrypt.class.getName()).log(Level.SEVERE, null, ex);
            }
         
            FileInputStream fis = new FileInputStream("D:\\DecryptFile\\"+FN);
            FileOutputStream fos = new FileOutputStream("D:\\DecryptFile\\Downloaded\\"+FN);
            
            byte[] in = new byte[64];
            int read;
            while ((read = fis.read(in)) != -1) {
                byte[] output = cipher.update(in, 0, read);
                if (output != null)
                    fos.write(output);
            }
            
            byte[] output = null;
            try {
                output = cipher.doFinal();
            } catch (IllegalBlockSizeException ex) {
                Logger.getLogger(Decrypt.class.getName()).log(Level.SEVERE, null, ex);
            } catch (BadPaddingException ex) {
                Logger.getLogger(Decrypt.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (output != null)
                fos.write(output);
            fis.close();
            fos.flush();
            fos.close();
            System.out.println("File Decrypted.");
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Decrypt.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
 
}
}
