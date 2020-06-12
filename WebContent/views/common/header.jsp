<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page
	language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.devmaster.mvc.entity.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<meta http-equiv="EXPIRES" content="-1" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Cache-Control"
	content="max-age=0,no-cache,no-store,must-revalidate" />

<meta name="SHORTCUT ICON" content="./resources/images/favicon.ico"/>
<link href="./resources/images/favicon.ico" rel="shortcut icon" />
<jsp:include page="/views/common/common-libs.jsp" />
<jsp:include page="/views/common/jspUtil.jsp" />
<script type="text/javascript">
 $(document).ready(function() 
{
 	//var roles = '${roles_session}';
	//var subFunc = '<s:property value="subFunc"/>';
	//checkFuction(roles);
	//checkSubFunc(subFunc);
		
});
</script>
</head>

<%
    java.util.Enumeration<String> sessEnum = request.getSession().getAttributeNames();
	User user =  (User)request.getSession().getAttribute("user");
	if(user == null) {
%>
	<c:redirect url="/login.htm"></c:redirect>
<%
	}
%>
<div id="FLYParent">
	<div class="themeHeader">
		<div class="banner">
			<div class="logo"></div>
			<div style="float: right; height: 70px; margin-right: 20px;">
				<div class="first"></div>
				<div class="nav">
					<ul class="topmenu">
						<li><a href="#" style="color: red;">Xin chào <%=user.getFullName()%></a></li>
						<li>|</li>
						<li><a id="portalLogoutLink" tabindex="7" class="toolbarLink"
							href="logout"> Đăng xuất</a>
						</li>
					</ul>
				</div>
				<div class="last">&nbsp;</div>
			</div>
			<div class="clearing">&nbsp;</div>
		</div>
	</div>
</div>
	<div id="ja-mainnav">
		<ul id="ja-cssmenu" class="clearfix"">
		<li style="float:right;padding-right:;">
			 <a style="color:red;font-size:x-small">Name: <%=user.getFullName()%></a>
		</li>			
			<li class="havechild">
				<a id="index" href="main"><img alt="Trang chủ" src="./resources/images/home.png" border="0" /></a>			
			</li>
			<li class="havechild">
				<a id="HeThong" name="menulink" href="#">Hệ thống</a>
				<ul>
					<li><a id="SysParameter" name="menulink" href="branch">Quản lý CN</a></li>
					<li><a id="DMTHONGBAO" name="menulink" href="">Thông báo hệ thống</a></li>
 				</ul>
	        </li>
	        <li class="havechild">
				<a id="VATTU" name="menulink" href="#">QL Vật tư</a>
				<ul>
					<li><a id="dmvattu" name="menulink" href="dmvattu">DM Vật tư</a></li>
					<li><a id="dmnhacc" name="menulink" href="dmnhacc">DM Nhà cung cấp</a></li>
					<li><a id="dmnhacc" name="menulink" href="qldonhang">QL Đơn hàng</a></li>
 				</ul>
	        </li>
	        
	        </ul>
	</div>
