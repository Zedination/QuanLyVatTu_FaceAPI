<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
	<jsp:include page="/views/common/common-libs.jsp" />
	<title>Trang Chủ - Spring MVC</title>
	<style type="text/css">
		#ja-wrapper-inner{
			/*background:url('images/iqs_bg02.png') !important;*/
		}
	</style>
</head>
<div id="mainbody">
		<jsp:include page="/views/common/header.jsp" />
		<div id="ja-wrapper">
		<div id="ja-wrapper-top"></div>
		<div id="ja-wrapper-inner" class="clearfix" style="min-height:500px;">
			<div style="float:right;padding-right:50px;">
				  <blink>
				  	<a style="color:red;font-size: 12px" href=""></a>
				  </blink>
			</div>
				<h1 style="font-size:20pt;"></h1>

      <object
        classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
        codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0"
        id="IMAP-Movie"
        width="1010" height="470"
      >
        <param name="movie" value="<%= request.getContextPath()%>/IQSSpeed.swf">
        <param name="bgcolor" value="#FFFFFF">
        <param name="quality" value="high">
        <param name="allowscriptaccess" value="samedomain">
        <param name="wmode" value="transparent">
        <embed
          type="application/x-shockwave-flash"
          pluginspage="http://www.adobe.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash"
          name="IMAP-Movie"
          width="1010" height="470"
          src="<%= request.getContextPath()%>/IQSSpeed.swf"
          wmode="transparent"
          bgcolor="#FFFFFF"
          quality="high"
          allowscriptaccess="samedomain"
        >
          <noembed>
          </noembed>
        </embed>
      </object>
    				<div style="position:relative;">
<div style="position:absolute; top:0px; left:20px; z-index:1; padding:0px;"> 
				</div>
</div>

					<br />
					
					<br />
					<br />
					<br />			
					
					<div style="text-align:left; width:568px;margin:0;font-size:12pt;">
						<span style="display:block;">
							<br />Xin chào bạn đến với <span style="font-weight:bold;color:green;">Chương trình demo của DEVMASTER</span> 
						</span>						
						<span style="display:block;">
							<br />Để xem hướng dẫn sử dụng chương trình, bạn có thể xem <span style="font-weight:bold;color:blue;"><a href="devmaster.com.vn">Tại đây</a></span> 
						</span>
						<br />
					</div>
					<br />
					<br />
					<br />
					<br />
		</div>
		<jsp:include page="/views/common/footer.jsp" />
	</div>
</div>
