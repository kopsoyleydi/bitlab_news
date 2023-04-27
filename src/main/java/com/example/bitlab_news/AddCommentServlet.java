package com.example.bitlab_news;

import classes.Blog;
import classes.Comment;
import classes.DBManager;
import classes.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "AddCommentServlet", value = "/addcomment")
public class AddCommentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String redirect = "/login";
        request.setCharacterEncoding("utf8");
        User currentUser = (User) request.getSession().getAttribute("cur_user");
        if (currentUser != null) {
            String commentText = request.getParameter("comment");
            Long blogId = Long.parseLong(request.getParameter("blog_id"));
            Blog blog = DBManager.getBlog(blogId);
            if (blog != null) {
                Comment comment = new Comment();
                comment.setComment(commentText);
                comment.setUser(currentUser);
                comment.setBlog(blog);
                if (DBManager.addComment(comment)) {
                    redirect = "/getBlog?id="+blogId;
                }
            }
        }
        response.sendRedirect(redirect);
    }
}
