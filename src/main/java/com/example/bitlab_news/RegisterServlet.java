package com.example.bitlab_news;

import classes.DBManager;
import classes.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String redirect = "/register?email_error";
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String re_password = request.getParameter("re_password");
        String fullName = request.getParameter("full_name");
        String role = request.getParameter("role");
        Long role_id = 2L;
        User checkUser = DBManager.getUser(email);
        if(checkUser == null){
            redirect = "/register?password_error";
            if (password.equals(re_password)){
                User user = new User();
                user.setEmail(email);
                user.setPassword(password);
                user.setFullName(fullName);
                user.setRole(role);
                user.setRole_id(role_id);
                if(DBManager.addUser(user)){
                    redirect = "/register?success";
                }
            }
        }
        response.sendRedirect(redirect);
    }
}
