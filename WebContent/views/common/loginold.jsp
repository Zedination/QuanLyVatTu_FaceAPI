<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.net.InetAddress"%>
<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html"%><%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>QUẢN LÝ VẬT TƯ</title>
	
	
	<meta http-equiv="EXPIRES" content="-1" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Cache-Control" content="max-age=0,no-cache,no-store,must-revalidate" />
	<meta name="SHORTCUT ICON" content="./resources/images/favicon.ico"/>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	
	<link rel="stylesheet" type="text/css" media="screen" href="./resources/css/ui.jqgrid.css" />
	<link href="./resources/theme/login_styles.css" rel="Stylesheet" />
	<link href="./resources/images/favicon.ico" rel="shortcut icon" />
	<link type="text/css" rel="stylesheet" href="./resources/css/loginStyles.css" />
	
	<script src="./resources/js/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="./resources/js/util.js" type="text/javascript"></script>
	<script type="text/javascript" src="./resources/js/Ajax.js"></script>

	
	<style type="text/css">
		.input {
			border: 1px solid #3E9BD0; /* #3E9BD0; 83A8CC*/
			-webkit-border-radius: 4px;
			-moz-border-radius: 4px;
			border-radius: 4px;
			padding-left: 3px;
			width: 200px;
		}
		.input:focus {
			border: 1px solid red;
			background-color: #FDF1C7;
		} /*#3E9BD0; FFFFCC} */
		.input:hover {
			border: 1px solid #D5ADF1;
		}
		#loginBody {
			background-position: center center;
			background-repeat: no-repeat;
		}
	</style>
</head>

<body id="loginBody"
	background="${pageContext.request.contextPath}/images/swoosh.png">
<%-- 	<%
		Enumeration names = request.getSession().getAttributeNames();
		while (names.hasMoreElements()) {
			String attrName = (String) names.nextElement();
			System.out.println(" removeAllSession :" + attrName);
			request.getSession().removeAttribute(attrName);
		}
	%> --%>
	<div id="net-swe-ajax-WorkbenchRoot"></div>
	<div style="height: 800x; top: 0pt; left: 0pt; opacity: 0.1;"
		class="swe-ui-Dialog-blockerDiv"></div>
	<div id="sweContent"
		style="width: 580px; max-width: 1211px; left: 335.5px; top: 162.5px;"
		id="swe_ui_Dialog_0"
		class="swe-ui-StyledBox swe-ui-StyledBox-no-shadow swe-ui-StyledBox-login swe-ui-StyledBox-no-shadow swe-ui-StyledBox-login-hover swe-ui-StyledBox-hover swe-ui-Dialog-absolute">
		<div class="box-wrapper">
			<div class="pull-back-out">
				<div class="top-border"></div>
				<div class="top-section">
					<div class="header-wrapper">
						<div style="cursor: move;" class="header"
							id="_header">
							<div class="header-icon" id="_headerIcon"></div>
							<div class="header-buttons" id="_headerButtons">
								<a href="#" class="menu" title="Menu"
									id="_toggleMenu" style="display: none;"> <img
									src="${pageContext.request.contextPath}/images/login/down-arrow.gif"
									id="_menuImg" alt="V" /> </a> <a href="#"
									class="collapse" id="_collapse"
									style="display: none;"> <img
									src="${pageContext.request.contextPath}/images/login/minimize.gif"
									id="_collapseImg" /> </a> <a href="#" class="close"
									title="Close" id="_close" style="display: none;">
									<img src="${pageContext.request.contextPath}/images/login/close.gif"
									id="_closeImg" alt="X" /> </a>
							</div>
							<div class="header-text"
								id="_headerText">
								<span id="_headerPrimary"></span>&nbsp;<span
									class="header-secondary" id="_headerSecondary"></span>
							</div>
						</div>
					</div>
					<div class="corner top-left"></div>
					<div class="corner top-right"></div>
				</div>
				<div class="middle-section" id="_middleSection">
					<a href="#" class="show-header" id="_headerLink"
						title="Show Header">Show Header</a>
					<div class="content-wrapper" id="_contentWrapper">
						<div style="max-height: 789px;" class="content"
							id="_bodyContainer">
							<div 
								id="swe_app_internal_LoginWidget_0" class="swe-app-LoginWidget">
								<div class="loginDialogContentWrapper">
									<div class="loginDialogContent">
										<div class="swe-team-server">
											<div class="swe-team-server-nameApp" style="color:#3CB371">QUẢN LÝ VẬT TƯ</div>
										</div>
										<div>
											&nbsp;
										</div>
										<div>
											<strong style="color: blue">Version: 1.0</strong>
										</div>
										<div class="main-wrapper">
											<div class="illustration"></div>
											<form:form class="form" action="login" commandName="userForm" id="form">
												<div>
													<c:if test="${not empty response.msg}">
														<font color='red'>${response.msg}</font>
													</c:if>
												</div>
												<div class="label">
													<b>Tên đăng nhập:</b>
												</div>
												<div class="field">
													<form:input path="username" class="input" placeholder="Tài khoản"/>
												</div>
												<div class="label">
													<b>Mật khẩu:</b>
												</div>
												<div class="field">
													<form:password path="password" class="input" placeholder="Mật khẩu"/>
													<div id="divMayus" style="display: none">
														<font color='red'>CapsLock</font>
													</div>
												</div>
												<button type="submit" class="btnLogin" type="submit" />
											</form:form>
										</div>
										<div class="services" id="_servicesArea"
											style="display: block;"></div>
										<div class="loginErrorMessage" style="visibility: hidden;"
											id="loginErrorDiv"></div>
									</div>
									 <div style="color: #31C330;" id="browser">
									</div> 
								</div>
								<div class="logos"></div>
							</div>
						</div>
					</div>
				</div>

				<div class="bottom-section">
					<div class="corner bottom-left"></div>
					<div class="bottom-right"></div>
				</div>
				<div class="border-bottom">
					<div class="border-bottom-wrapper">
						<div class="border-bottom-inner"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
