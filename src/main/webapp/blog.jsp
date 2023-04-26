<%@ page import="classes.Blog" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="classes.User" %><%--
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
    <title><%=blog.getTitle()%></title>
    <link rel="stylesheet" href="styles/card.css">
</head>
<body>
<div class="container" style="min-height: 500px;">
    <div class="row mt-3">
        <div class="col-12">
            <div class="row mt-3" id="cards">
                    <div class="col-10 mx-auto p-3" style="background-color: lightgrey; display: flex">
                        <%
                            if(blog != null){
                        %>
                        <div class="text">
                            <h2><%=blog.getTitle()%></h2>
                            <p class="mt-3"><%=blog.getContent()%></p>
                            <p class="mt-2">
                                Posted by <strong><%=blog.getUser().getFullName()%></strong>
                                at <strong><%=blog.getPostDate()%></strong>
                            </p>
                            <%
                                if(currentUser != null){
                            %>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                EDIT
                            </button>

                            <!-- Modal -->
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
                        </div>
                        <%
                            }
                        %>
                        <div class="image" >
                            <img src="<%=blog.getUrl()%>" style="width: 100%; height: 200px">
                        </div>
                        <%
                            }
                            else{
                        %>
                        <h3>404</h3>
                        <%
                            }
                        %>
                    </div>
            </div>
        </div>
    </div>
</div>
<%@include file="/components/footer.jsp"%>
</body>
</html>