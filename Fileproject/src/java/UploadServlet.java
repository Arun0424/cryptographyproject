import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import jakarta.servlet.http.*;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.security.AlgorithmParameters;
import java.security.SecureRandom;
import java.security.spec.KeySpec;
import java.util.*;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.*;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.InvalidParameterSpecException;
import java.sql.Blob;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

 
@WebServlet("/uploadServlet")
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB
public class UploadServlet extends HttpServlet {
     String FN=null;
     String Reciever_Name=null;
    // database connection settings
    private final String dbURL = "jdbc:mysql://localhost:3306/project";
    private final String dbUser = "root";
    private final String dbPass = "";
     PreparedStatement statement=null;
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        // gets values of text fields  
        String name = request.getParameter("usename");
        PrintWriter out = response.getWriter();
        if((name.equals(null) || name.equals("")) )
{
out.println("<script>alert('Field is Empty');</script>");
}
else
        {
        InputStream inputStream= null;
        FileInputStream in= null;
 // input stream of the upload file
        // obtains the upload file part in this multipart request
        Part filePart = request.getPart("photo");      
        FN=filePart.getSubmittedFileName();
        Reciever_Name=request.getParameter("recevername");
        if (filePart != null) {
            // prints out some information for debugging
            System.out.println(filePart.getContentType());
             
            // obtains input stream of the upload file
            inputStream = filePart.getInputStream();
           
           // FileInputStream inFile = new FileInputStream("T1.txt");

		// encrypted file
		OutputStream outFile = new FileOutputStream("D:\\DecryptFile\\encryptedfile.aes");

		// password to encrypt the file
	System.out.println("Enter the Password For Encrypt a File");
		String password = request.getParameter("key");

		// password, iv and salt should be transferred to the other end
		// in a secure manner

		// salt is used for encoding
		// writing it to a file
		// salt should be transferred to the recipient securely
		// for decryption
		byte[] salt = new byte[8];
		SecureRandom secureRandom = new SecureRandom();
		secureRandom.nextBytes(salt);
		FileOutputStream saltOutFile = new FileOutputStream("D:\\DecryptFile\\salt.enc");
		saltOutFile.write(salt);
		saltOutFile.close();

		SecretKeyFactory factory = null;
            try {
                factory = SecretKeyFactory
                        .getInstance("PBKDF2WithHmacSHA1");
            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
		KeySpec keySpec = new PBEKeySpec(password.toCharArray(), salt, 65536,
				256);
		SecretKey secretKey = null;
            try {
                secretKey = factory.generateSecret(keySpec);
            } catch (InvalidKeySpecException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
		SecretKey secret = new SecretKeySpec(secretKey.getEncoded(), "AES");

		//
		Cipher cipher = null;
            try {
                cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (NoSuchPaddingException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                cipher.init(Cipher.ENCRYPT_MODE, secret);
            } catch (InvalidKeyException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
		AlgorithmParameters params = cipher.getParameters();

		// iv adds randomness to the text and just makes the mechanism more
		// secure
		// used while initializing the cipher
		// file to store the iv
		FileOutputStream ivOutFile = new FileOutputStream("D:\\DecryptFile\\iv.enc");
		byte[] iv = null;
            try {
                iv = params.getParameterSpec(IvParameterSpec.class).getIV();
            } catch (InvalidParameterSpecException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
		ivOutFile.write(iv);
		ivOutFile.close();

		//file encryption
		byte[] input = new byte[64];
		int bytesRead;

		while ((bytesRead = inputStream.read(input)) != -1) {
			byte[] output = cipher.update(input, 0, bytesRead);
			if (output != null)
				outFile.write(output);
		}

		byte[] output = null;
            try {
                output = cipher.doFinal();
            } catch (IllegalBlockSizeException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (BadPaddingException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
		if (output != null)
			outFile.write(output);

                
		outFile.flush();
		outFile.close();


           inputStream=new FileInputStream("D:\\DecryptFile\\encryptedfile.aes");
            
            
            
            
               
            
        }
         
        Connection conn = null; // connection to the database
        String message = null;  // message will be sent back to client
         ResultSet rs = null;
        try {
            // connects to the database
            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
 
            // constructs SQL statement
            String sql = "UPDATE tab1 SET  File = ? , Filename = ? WHERE Username = ?";
             statement = conn.prepareStatement(sql);
             statement.setString(3, name);
             
            if (inputStream != null) {
                // fetches input stream of the upload file for the blob column
                statement.setBlob(1, inputStream);
                statement.setString(2,FN);
            }
            
 
            // sends the statement to the database server
            int row = statement.executeUpdate();
            if (row > 0) {
                message = "File uploaded and saved into database";
            }
        } catch (SQLException ex) {
            message = "ERROR: " + ex.getMessage();
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
            // sets the message in request scope
            request.setAttribute("Message", message);
             
            // forwards to the message page
            getServletContext().getRequestDispatcher("/Message.jsp").forward(request, response);
            
            RequestDispatcher rd=request.getRequestDispatcher("download.jsp");  
        rd.forward(request, response);  
        }
    }
}
}