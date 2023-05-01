package com.example.bitlab_news;

import classes.Blog;
import classes.DBManager;
import classes.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "UpdateBlogServlet", value = "/editBlog")
public class UpdateBlogServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("cur_user");
        if(user!=null) {
            Long id = Long.parseLong(request.getParameter("id"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String url = request.getParameter("url");
            Blog blog = DBManager.getBlog(id);
            if(blog != null){
                blog.setUrl(url);
                blog.setTitle(title);
                blog.setContent(content);

                DBManager.UpdateBlog(blog);
                response.sendRedirect("/getBlog?id=" + id);
            }
            else {
                response.sendRedirect("/main");
            }
        }
        else{
            response.sendRedirect("/login");
        }
    }
}
