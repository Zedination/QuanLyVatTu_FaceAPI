<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand">DANH MỤC QUẢN LÝ</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class=""><a href="main">Trang chủ</a></li>
        <li class="dropdown">
        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Quản lý
        <span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="dmvattu">Danh Mục Vật Tư</a></li>
          <li><a href="dmnhacc">Danh Mục Nhà Cung Cấp</a></li>
          <li><a href="qldonhang">Quản Lý Đơn Hàng</a></li>
          <li><a href="tonkho">Tồn Kho</a></li>
          <li><a href="qlphieunhap">Phiếu Nhập</a></li>
          <li><a href="qlphieuxuat">Phiếu Xuất</a></li>
          <li><a href="diemdanh">Demo Điểm Danh VAV-Idols</a></li>
        </ul>
      </li>
        <li><a href="#">About</a></li>
        <li><a href="#">Projects</a></li>
        <!-- <li><a href="#">Liên Hệ</a></li> -->
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="logout"><span class="glyphicon glyphicon-log-out"></span> Đăng xuất </a></li>
      </ul>
    </div>
  </div>
</nav>