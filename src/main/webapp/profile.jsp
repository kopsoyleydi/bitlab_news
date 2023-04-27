<%@ page import="java.util.ArrayList" %>
<%@ page import="classes.Blog" %>
<%@ page import="classes.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="components/head.jsp"%>
    <link rel="stylesheet" href="styles/profile.css">
    <title>Profile</title>
</head>
<body>
<%
    ArrayList<Blog> blogs = (ArrayList<Blog>) request.getAttribute("prof");
    User currentUser = (User) session.getAttribute("cur_user");
%>
<div class="container">
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
</div>
<div class="row py-5 px-4">
    <div class="col-md-5 mx-auto">
        <div class="bg-white shadow rounded overflow-hidden">
            <div class="px-4 pt-0 pb-4 cover">
                <div class="media align-items-end profile-head">
                    <div class="profile mr-3">
                        <img
                            src="https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80"
                            alt="..." width="130" class="rounded mb-2 img-thumbnail">
                        <h3><%=currentUser.getFullName()%></h3>
                    </div>
                </div>
            </div>
            <div class="bg-light p-4 d-flex justify-content-end text-center">
                <ul class="list-inline mb-0">
                    <li class="list-inline-item">
                        <h5 class="font-weight-bold mb-0 d-block">215</h5><small class="text-muted"> <i
                            class="fas fa-image mr-1"></i>Photos</small>
                    </li>
                    <li class="list-inline-item">
                        <h5 class="font-weight-bold mb-0 d-block">745</h5><small class="text-muted"> <i
                            class="fas fa-user mr-1"></i>Followers</small>
                    </li>
                    <li class="list-inline-item">
                        <h5 class="font-weight-bold mb-0 d-block">340</h5><small class="text-muted"> <i
                            class="fas fa-user mr-1"></i>Following</small>
                    </li>
                </ul>
            </div>
            <div class="px-4 py-3">
                <h5 class="mb-0">Role</h5>
                <div class="p-4 rounded shadow-sm bg-light">
                    <p class="font-italic mb-0"><%=currentUser.getRole()%></p>
                </div>
            </div>
            <div class="py-4 px-4">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <h5 class="mb-0">Recent posts</h5><a href="#" class="btn btn-link text-muted">Show all</a>
                </div>

                <div class="col">
                    <%
                        if(blogs != null){
                            for(Blog b : blogs){
                                if(currentUser.getFullName().equals(b.getUser().getFullName())){
                    %>
                    <div class="col" style="display: flex;flex-direction: column;">
                        <div>
                            <h4 class="col mt-2"><%=b.getTitle()%></h4>
                            <p class="mt-2">
                                <%=b.getContent()%>
                            </p>
                        </div>
                        <div class="col ms-5" style="display: flex;
                        flex-direction: column;">
                            <img src="<%=b.getUrl()%>" style="height: 170px; width: 350px;">
                        </div>

                    </div>
                    <%
                                }
                            }
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row mt-3">
        <div class="col-12">
        </div>
    </div>
</div>
<div class="container p-4">
    <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top mb-1">
        <p class="col-md-4 mb-0 text-body-secondary">BitLab News</p>
        <a href="/" class="col-md-4 d-flex align-items-center justify-content-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
            <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"></use></svg>
        </a>
        <ul class="nav col-md-4 justify-content-end">
            <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Home</a></li>
            <%
                if(currentUser != null){
            %>
            <li class="nav-item"><a href="/profile" class="nav-link px-2 text-body-secondary">Profile</a></li>
            <li class="nav-item"><a href="/settings" class="nav-link px-2 text-body-secondary">Settings</a></li>
            <%
                }
            %>
            <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">FAQs</a></li>
            <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">About</a></li>
        </ul>
    </footer>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
</body>
</html>
