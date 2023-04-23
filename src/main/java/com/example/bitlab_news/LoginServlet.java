package com.example.bitlab_news;

import classes.DBManager;
import classes.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String redirect = "/login?email_error";

        String email = request.getParameter("email");

        String password = request.getParameter("password");

        User user = DBManager.getUser(email);

        if(user!=null){

            redirect = "/login?password_error";

            if(user.getPassword().equals(password)){

                redirect = "/profile";

                request.getSession().setAttribute("cur_user", user);

            }

        }

        response.sendRedirect(redirect);
    }
}

