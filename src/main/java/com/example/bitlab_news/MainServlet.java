package com.example.bitlab_news;

import classes.Blog;
import classes.DBManager;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.awt.print.Book;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "MainServlet", value = "/main")
public class MainServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String key = request.getParameter("key");
        if(key != null) {
            ArrayList<Blog> blog = DBManager.searchNews("%"+key+"%");
            request.setAttribute("blogs", blog);
        }else{
            ArrayList<Blog> blog = DBManager.getAllBlogs();
            request.setAttribute("blogs", blog);
        }
        request.getRequestDispatcher("index.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
