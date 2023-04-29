<%@ page import="classes.Blog" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="classes.User" %>
<%@ page import="classes.Comment" %><%--
  Created by IntelliJ IDEA.
  User: omyrz
  Date: 26.04.2023
  Time: 22:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        User currentUser = (User) session.getAttribute("cur_user");

        Blog blog = (Blog) request.getAttribute("blog");
    %>
    <%@include file="components/head.jsp"%>
    <title>Blog</title>
    <link rel="stylesheet" href="styles/card.css">
</head>
<body>
<div class="container" style="min-height: 500px;">
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">BitLab Blog</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav">
                    <%
                        if(currentUser != null){
                    %>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li class="nav-item">
                                <a class="nav-link" href="/">Home</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    Profile
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="/profile">Profile</a></li>
                                    <li><a class="dropdown-item" href="/settings">Settings</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="/logout">Logout</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <%
                    }
                    else{
                    %>
                    <li class="nav-item">
                        <a class="nav-link" href="/main">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/register">Register</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/login">Login</a>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
        </div>
    </nav>
    <div class="row mt-3">
        <div class="col-12">
            <div class="row mt-3" id="cards">
                    <div class="col-10 mx-auto p-3" style="background-color: #e7e7e7; display: flex">
                        <%
                            if(blog != null){
                        %>
                        <div class="text">
                            <h2><%=blog.getTitle()%></h2>
                            <p class="mt-3"><%=blog.getContent()%></p>
                            <p class="mt-2">
                                Posted by <strong><%=blog.getUser().getFullName()%></strong>
                                at <strong><%=blog.getPostDate()%></strong><br>
                                categories: <strong><%=blog.getCategories().getName()%></strong>
                            </p>
                            <%
                                if(currentUser != null){
                                    if(currentUser.getRole_id() == 1){
                            %>
                            <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                EDIT
                            </button>
                            <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteBlog">
                                DELETE
                            </button>
                            <%
                                }
                            }
                        %>
                            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            ...
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            <button type="button" class="btn btn-primary">Save changes</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal fade" id="deleteBlog" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <form method="post" action="/deleteBlog">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="deleteBlog">Modal title</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            Are you sure?
                                            <input type="hidden" name="deleteBlog_id" value="<%=blog.getId()%>">
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            <button class="btn btn-danger">DELETE</button>
                                        </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="image" >
                            <img src="<%=blog.getUrl()%>" style="width: 100%; height: 200px">
                        </div>
                    </div>
                <%
                    }
                %>
                <div class="container mt-5">
                    <div class="row  d-flex justify-content-center">
                        <div class="col-md-8">
                            <div class="headings d-flex justify-content-between align-items-center mb-3">
                                <h5>Comments</h5>
                                <div class="buttons">
                            <span class="badge bg-white d-flex flex-row align-items-center">
                                <span class="text-primary">All comment</span>
                            </span>
                                </div>
                            </div>
                            <%
                                if(currentUser!=null){
                            %>
                            <div class="col-12 mx-auto p-3 mt-2" style="background-color: white; display: flex">
                                <div class="col-12">
                                    <form action="/addcomment" method="post">
                                        <input type="hidden" name="blog_id" value="<%=blog.getId()%>">
                                        <textarea class="form-control" name="comment" placeholder="Write a comment"></textarea>
                                        <button class="btn btn-primary mt-2 btn-sm ms-1">ADD COMMENT</button>
                                    </form>
                                </div>
                            </div>
                <%
                    ArrayList<Comment> comments = (ArrayList<Comment>) request.getAttribute("comments");
                    if(comments!=null){
                        for(Comment comment : comments){
                %>
                            <div class="card p-3 mt-3">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="user d-flex flex-row align-items-center">
                                        <img src="https://i.imgur.com/hczKIze.jpg" width="30" class="user-img rounded-circle mr-2">
                                        <span><small class="font-weight-bold text-primary"><%=comment.getUser().getFullName()%></small>
                                            <small class="font-weight-bold ms-2"><%=comment.getComment()%></small></span>
                                    </div>
                                    <small><%=comment.getPostDate()%></small>
                                </div>
                                <div class="action d-flex justify-content-between mt-2 align-items-center">
                                    <div class="icons align-items-center mt-2">
                                        <%
                                            if(currentUser != null){
                                                if(currentUser.getRole_id() == 1){
                                        %>
                                            <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#delete">
                                                delete
                                            </button>
                                        <form action="/deleteComment" method="post">
                                            <div class="modal fade" id="delete" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h1 class="modal-title fs-5" id="delete">Delete Modal</h1>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            Are you sure?
                                                        </div>
                                                        <input type="hidden" value="<%=comment.getId()%>" name="delete_id">
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            <button class="btn btn-danger">Delete</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                        <%
                                            }
                                            }
                                        %>
                                    </div>
                                </div>
                            </div>

                <%
                    }
                    }
                %>
                        </div>
                    </div>
                </div>
                <%
                    }
                            else {
                %>
                <h4>Вам нужно войти или создать аккаунт</h4>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</div>
    <%@include file="/components/footer.jsp"%>
</body>
</html>
