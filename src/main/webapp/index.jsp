<%@ page import="classes.Blog" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>BitLab News</title>
    <%@include file="components/head.jsp"%>
    <link rel="stylesheet" href="styles/card.css">
</head>
<body>
<%@include file="components/header.jsp"%>
<div class="container" style="min-height: 500px;">
    <div class="row mt-3">
        <div class="col-12">
            <%
                ArrayList<Blog> blogs = (ArrayList<Blog>) request.getAttribute("blogs");
                if(blogs!=null){
                    for(Blog blog : blogs){
            %>
            <div class="row mt-3" id="cards">
                <div class="col-10 mx-auto p-3" style="background-color: lightgrey; display: flex">
                    <div class="text">
                        <h2><%=blog.getTitle()%></h2>
                        <p class="mt-3"><%=blog.getContent()%></p>
                        <p class="mt-2">
                            Posted by <strong><%=blog.getUser().getFullName()%></strong>
                            at <strong><%=blog.getPostDate()%></strong>
                        </p>
                    </div>
                    <div class="image" >
                        <img src="<%=blog.getUrl()%>" style="width: 100%; height: 200px">
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
<%@include file="components/footer.jsp"%>
</body>
</html>