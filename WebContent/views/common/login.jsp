<!DOCTYPE HTML>
<%@page import="java.net.InetAddress"%>
<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html"%><%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="<c:url value="/resources/bs4css/style4.css" />" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <title>Quản Lý Vật Tư</title>
</head>
<body>
    <div class="container">
      <div class="row">
        <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
          <div class="card card-signin my-5">
            <div class="card-body">
              <h5 class="card-title text-center">ĐĂNG NHẬP</h5>
              <form:form class="form-signin" action="login" modelAttribute="userForm">
              									<div style = "margin-bottom: 20px;">
													<c:if test="${not empty response.msg}">
														<font color='red'>${response.msg}</font>
														<!-- <script type="text/javascript">
														alert("${response.msg}");
														</script> -->
													</c:if>
												</div>
                <div class="form-label-group">
                  <form:input path="username" id="inputEmail" class="form-control" placeholder="User name" />
                  <label for="inputEmail">Tên tài khoản</label>
                </div>
  
                <div class="form-label-group">
                  <form:password path="password" id="inputPassword" class="form-control" placeholder="Password"/>
                  <label for="inputPassword">Mật khẩu</label>
                </div>
  
                <div class="custom-control custom-checkbox mb-3">
                  <input type="checkbox" class="custom-control-input" id="customCheck1">
                  <label class="custom-control-label" for="customCheck1">Nhớ mật khẩu</label>
                </div>
                <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">Đăng nhập</button>
                <hr class="my-4">
                <a class="btn btn-lg btn-google btn-block text-uppercase" role="button" href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=https://springdemobyanhduc.herokuapp.com/login-google&response_type=code
                &client_id=186488505492-lpe2iqg5duuvccs7dlbe6lpm9hgp05q2.apps.googleusercontent.com&approval_prompt=force" ><i class="fab fa-google mr-2"></i> Sign in with Google</a>
                <a class="btn btn-lg btn-facebook btn-block text-uppercase" role="button" href="https://www.facebook.com/dialog/oauth?client_id=3242529832428391&redirect_uri=https://springdemobyanhduc.herokuapp.com/login-facebook" ><i class="fab fa-facebook-f mr-2"></i> Sign in with Facebook</a>
                <p style="margin-top: 20px;">Chưa có tài khoản? Hãy <a href="Signup" style="color: red; ">đăng ký</a> ngay!</p>
                <p>Bạn quên mật khẩu, hãy <a href="forgot-password" style="color: red; ">click vào đây!</a> </p>
              </form:form>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  </body>
</html>