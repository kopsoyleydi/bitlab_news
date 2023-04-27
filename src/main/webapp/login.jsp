<%--
  Created by IntelliJ IDEA.
  User: omyrz
  Date: 22.04.2023
  Time: 19:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <%@include file="components/head.jsp"%>
</head>
<body>
<%@include file="components/header.jsp"%>
<div class="container" style="min-height: 500px;">

    <div class="row mt-3">
        <div class="col-6 mx-auto">
            <%

                String emailError = request.getParameter("email_error");

                if(emailError!=null){

            %>

            <div class="alert alert-danger alert-dismissible fade show" role="alert">

                Incorrect email, try again!

                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>

            </div>

            <%

                }

            %>

            <%

                String passwordError = request.getParameter("password_error");

                if(passwordError!=null){

            %>

            <div class="alert alert-danger alert-dismissible fade show" role="alert">

                Incorrect password, try again!

                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>

            </div>

            <%

                }

            %>

            <form action="/login" method="post">

                <div class="row">

                    <div class="col-12">

                        <label>EMAIL</label>

                    </div>

                </div>

                <div class="row mt-2">

                    <div class="col-12">

                        <input type="email" class="form-control" required placeholder="Email" name="email">

                    </div>

                </div>

                <div class="row mt-3">

                    <div class="col-12">

                        <label>PASSWORD</label>

                    </div>

                </div>

                <div class="row mt-2">

                    <div class="col-12">

                        <input type="password" class="form-control" required placeholder="Password" name="password">

                    </div>

                </div>

                <div class="row mt-3">

                    <div class="col-12">

                        <button class="btn btn-success">SIGN IN</button>

                    </div>

                </div>

            </form>

        </div>

    </div>
</div>
<%@include file="components/footer.jsp"%>
</body>
</html>
