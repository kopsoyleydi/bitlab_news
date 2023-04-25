package com.example.bitlab_news;

import classes.Blog;
import classes.DBManager;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "BlogServlet", value = "/getBlog")
public class BlogServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("blog.jsp").forward(request,response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Blog blog = DBManager.getBlog(id);
        request.setAttribute("blog",blog);
        request.getRequestDispatcher("blog.jsp").forward(request,response);
    }
}
