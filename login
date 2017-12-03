index.html
<html>  
<head>  
<meta charset="ISO-8859-1">  
<title>Servlet Login Example</title>  
</head>  
<body>  
  
<h1>Login App using HttpSession</h1>  
<a href="login.html">Login</a>|  
<a href="LogoutServlet">Logout</a>|  
<a href="ProfileServlet">Profile</a>  
  
</body>  
</html>  



link.html
<a href="login.html">Login</a> |  
<a href="LogoutServlet">Logout</a> |  
<a href="ProfileServlet">Profile</a>  
<hr>  



login.java
import java.io.IOException;  
import java.io.PrintWriter;  
  
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession;  
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {  
    protected void doPost(HttpServletRequest request, HttpServletResponse response)  
                    throws ServletException, IOException {  
        response.setContentType("text/html");  
        PrintWriter out=response.getWriter();  
        request.getRequestDispatcher("link.html").include(request, response);  
          
        String name=request.getParameter("name");  
        String password=request.getParameter("password");  
          
        if(password.equals("admin123")){  
        out.print("Welcome, "+name); 
        Cookie ck=new Cookie("name",name);
        response.addCookie(ck);
        /*HttpSession session=request.getSession();  
        session.setAttribute("name",name);  */
        }  
        else{  
            out.print("Sorry, username or password error!");  
            request.getRequestDispatcher("login.html").include(request, response);  
        }  
        out.close();  
    }  
}  




logoutservlet
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession;  
@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {  
        protected void doGet(HttpServletRequest request, HttpServletResponse response)  
                                throws ServletException, IOException {  
            response.setContentType("text/html");  
            PrintWriter out=response.getWriter();  
              
            request.getRequestDispatcher("link.html").include(request, response);  
              
            Cookie ck=new Cookie("name","");
            ck.setMaxAge(0);
            response.addCookie(ck);
            /*HttpSession session=request.getSession();  
            session.invalidate();  */
              
            out.print("You are successfully logged out!");  
              
            out.close();  
    }  
}  


profileservlet

import java.io.IOException;  
import java.io.PrintWriter;  
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession;  
@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {  
    protected void doGet(HttpServletRequest request, HttpServletResponse response)  
                      throws ServletException, IOException {  
        response.setContentType("text/html");  
        PrintWriter out=response.getWriter();  
        request.getRequestDispatcher("link.html").include(request, response);  
          
        
        Cookie[] ck=request.getCookies();
        if(ck!=null) {
        	String name=ck[0].getValue();
        	if(!name.equals("")||name!=null) {
        		out.println("<b>Welcome to Profile<b>");
        		out.println("<br>Welcome "+name);		
        	}
        	
        
        /*HttpSession session=request.getSession(false);  
        if(session!=null){  
        String name=(String)session.getAttribute("name");  
          
        out.print("Hello, "+name+" Welcome to Profile"); */ 
        }  
        else{  
            out.print("Please login first");  
            request.getRequestDispatcher("login.html").include(request, response);  
        }  
        out.close();  
    }  
}  
