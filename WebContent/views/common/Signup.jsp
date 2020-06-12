<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.util.Enumeration"%>
<!-- import entity class User quản lý tên người dùng -->
<%@page import="com.devmaster.mvc.entity.User"%>
<%@page import="com.devmaster.mvc.controller.SignupController"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Đăng ký</title>
<%--   <% String a = "";
  if(request.getParameter("message")!=null){
	  if(request.getParameter("message").toString().equals("error")){
		  a = "Tên đăng nhập đã tồn tại!";
	  }
  }
%> --%>

<% String a = "";
if(request.getAttribute("valid")!=null){
		a = "Tên đăng nhập hoặc Email bạn định đăng ký đã tồn tại!";
	}
%>


  <!-- Custom fonts for this template-->
  <link href="<c:url value="/resources/bs4/vendor/fontawesome-free/css/all.min.css"/>" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="<c:url value="/resources/bs4/css/sb-admin-2.min.css"/>" rel="stylesheet">
  <!-- source code jquery cho tính năng dark mode -->
  <link rel="stylesheet" href="<c:url value="/resources/bs4css/dark-mode.css"/>">

</head>

<body class="bg-gradient-primary">

  <div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5">
      <div class="card-body p-0">
        <!-- Nested Row within Card Body -->
        <div class="row">
          <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
          <div class="col-lg-7">
            <div class="p-5">
              <div class="text-center">
                <h1 class="h4 text-gray-900 mb-4">Tạo tài khoản mới!</h1>
              </div>
              <div style = "margin-bottom: 20px;">
				<font color='red'><% out.print(a.toString());%></font>
			  </div> 
              <form class="user" action = "Signup" onsubmit="return validateForm()" method="POST">
                <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <input type="text" name = "username" class="form-control form-control-user" id="exampleFirstName" placeholder="Tên đăng nhập" required autofocus>
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name ="fullname" class="form-control form-control-user" id="exampleLastName" placeholder="Tên đầy đủ" required>
                  </div>
                </div>
                <div class="form-group">
                  <input type="email" name = "email" class="form-control form-control-user" id="exampleInputEmail" placeholder="Email Address" required>
                </div>
                <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <input type="password" class="form-control form-control-user" id="exampleInputPassword" placeholder="Mật khẩu" required>
                  </div>
                  <div class="col-sm-6">
                    <input type="password" name = "password" class="form-control form-control-user" id="exampleRepeatPassword" placeholder="Nhập lại mật khẩu" required>
                  </div>
                </div>
                <button class="btn btn-primary btn-user btn-block" type="submit">Đăng ký</button>
                <hr>
                <a href="#" class="btn btn-google btn-user btn-block">
                  <i class="fab fa-google fa-fw"></i> Đăng ký bằng Google
                </a>
                <a href="#" class="btn btn-facebook btn-user btn-block">
                  <i class="fab fa-facebook-f fa-fw"></i> Đăng ký bằng Facebook
                </a>
              </form>
              <hr>
              <div class="text-center">
                <a class="small" href="forgot-password.html">Quên mật khẩu?</a>
              </div>
              <div class="text-center">
                <a class="small" href="login.html">Bạn đã có 1 tài khoản? Đăng nhập ngay!</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>
	
	<script type="text/javascript">
    function validateForm(){
        let x = document.getElementById("exampleInputPassword").value;
        let y = document.getElementById("exampleRepeatPassword").value;
        if(x!==y){
          alert("mật khẩu ban đầu và mật khẩu xác thực bạn vừa nhập không giống nhau");
          return false;
        }
      }
	</script>
	
  <!-- Bootstrap core JavaScript-->
  <script src="<c:url value="/resources/bs4/vendor/jquery/jquery.min.js"/>"></script>
  <script src="<c:url value="/resources/bs4/vendor/bootstrap/js/bootstrap.bundle.min.js"/>"></script>

  <!-- Core plugin JavaScript-->
  <script src="<c:url value="/resources/bs4/vendor/jquery-easing/jquery.easing.min.js"/>"></script>

  <!-- Custom scripts for all pages-->
  <script src="<c:url value="/resources/bs4/js/sb-admin-2.min.js"/>"></script>
  <!-- nếu cần kích hoạt tính năng dark mode cho 1 thẻ bất kỳ, ta cần thêm class "bg-white" hoặc "bg-light" cho thẻ đó -->
  <!-- source code jquery cho tính năng dark mode -->
  <script src="<c:url value="/resources/bs4css/dark-mode-switch.min.js"/>"></script>

</body>

</html>
    