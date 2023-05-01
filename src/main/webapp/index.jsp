<%@ page import="classes.Blog" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="classes.Comment" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>BitLab News</title>
    <%@include file="components/head.jsp"%>
    <link rel="stylesheet" href="styles/card.css">
</head>
<body>

<div class="container" style="min-height: 500px;">
    <%@include file="components/header.jsp"%>
    <div class="row mt-3">
        <form action="/main" method="get">
            <div class="row mt-3">
                <div class="col-10">
                    <%
                        String key = request.getParameter("key");
                        if(key==null) key = "";
                    %>
                    <input type="text" class="form-control" name="key" placeholder="Search" value="<%=key%>">
                </div>
                <div class="col-2">
                    <button class="btn btn-success w-100">SEARCH</button>
                </div>
            </div>
        </form>
        <div class="col-12">
            <%
                ArrayList<Blog> blogs = (ArrayList<Blog>) request.getAttribute("blogs");
                if(blogs!=null){
                    for(Blog blog : blogs){
            %>
            <div class="row mt-3" id="cards">
                <form action="/getBlog" method="get">
                <div class="col-10 mx-auto p-3" style="background-color: #e7e7e7; display: flex">
                    <div class="text">
                        <h2><%=blog.getTitle()%></h2>
                        <p class="mt-3"><%=blog.getContent()%></p>
                        <p class="mt-2">
                            Posted by <strong><%=blog.getUser().getFullName()%></strong>
                            at <strong><%=blog.getPostDate()%></strong>
                        </p>
                        <input type="hidden" value="<%=blog.getId()%>" name="id">
                        <button class="btn btn-primary btn-sm mt-4">Learn more</button>
                    </div>
                    <div class="image" >
                        <img src="<%=blog.getUrl()%>" style="width: 100%; height: 200px">
                    </div>
                </div>
                </form>
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