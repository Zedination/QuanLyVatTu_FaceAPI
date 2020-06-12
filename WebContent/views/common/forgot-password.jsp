<!DOCTYPE html>
<%@page import="java.net.InetAddress"%>
<%@page import="java.util.Enumeration"%>

<%@page contentType="text/html"%><%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">

<head>



  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  

  <title>Quên mật khẩu</title>

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

    <!-- Outer Row -->
    <div class="row justify-content-center">

      <div class="col-xl-10 col-lg-12 col-md-9">

        <div class="card o-hidden border-0 shadow-lg my-5">
          <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
              <div class="col-lg-6 d-none d-lg-block bg-password-image"></div>
              <div class="col-lg-6">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-2">Bạn Quên Mật Khẩu?</h1>
                    <p class="mb-4">Nếu bạn quên mật khẩu, hãy nhập email đăng ký tài khoản của bạn vào đây. Chúng tôi sẽ reset mật khẩu cho tài khoản của bạn và gửi cho bạn email chứa mật khẩu mới!</p>
                  </div>
                  								<div style = "margin-bottom: 20px;">
													<c:if test="${not empty response.msg}">
														<font color='red'>${response.msg}</font>
													</c:if>
												</div>
                  <form class="user" action = "forgot-password" onsubmit="return validateForm()" method="POST">
                    <div class="form-group">
                      <input type="email" name = "email" class="form-control form-control-user" id="exampleInputEmail" aria-describedby="emailHelp" placeholder="Enter Email Address..." required autofocus>
                    </div>
                    <button class="btn btn-primary btn-user btn-block" type="submit">Reset Mật Khẩu</button>
                  </form>
                  <hr>
                  <div class="text-center">
                    <a class="small" href="Signup">Tạo 1 tài khoản mới!</a>
                  </div>
                  <div class="text-center">
                    <a class="small" href="login">Bạn đã có tài khoản? Đăng Nhập!</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </div>

  </div>
		<script type="text/javascript">
    function validateForm(){
        let x = document.getElementById("exampleInputEmail").value;
        
        if(x == ""){
          alert("Bạn chưa nhập email, vul lòng nhập lại");
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
