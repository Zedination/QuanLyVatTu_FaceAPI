<%@page
	language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="java.util.ArrayList"%>
	<%@page import="java.util.List"%>
 
<div class="leftpanel">
	<div class="logopanel">
        <%-- <h1><span>[</span> BIC <span>]</span></h1> --%>
        <!--img src="${pageContext.request.contextPath}/images/logo-sm.png"/-->
        <h1><span class='bidv-text'>BIDV</span> - <span class='wu-text'>WU</span></h1>
    </div><!-- logopanel -->
    
    <div class="leftpanelinner">
    	<!-- This is only visible to small devices -->
        <div class="visible-xs hidden-sm hidden-md hidden-lg">   
            <div class="media userlogged">
                <img alt="" src="/resources/image/user.png" class="media-object">
                <div class="media-body">
                    <h4></h4>
                    <span></span>
                </div>
            </div>
          
            <h5 class="sidebartitle actitle">Tài khoản</h5>
            <ul class="nav nav-pills nav-stacked nav-bracket mb30">
              <li><a href="<s:url action="profile"/>"><i class="fa fa-user"></i> <span>Thông tin cá nhân</span></a></li>              
              <li><a href="<s:url action="logout"/>"><i class="fa fa-sign-out"></i> <span>Đăng xuất</span></a></li>
            </ul>
        </div>
		<ul class="nav nav-pills nav-stacked nav-bracket" id="nav-parent">
			<li class="nav-parent" index='0'><a href='javascript:;'><i class="fa fa-tags"></i> <span>Tham số online</span></a>
				<ul id="child_params" class="children">
					<li id='subnav_wuparaloaitiensd'><a href="/springmvc/demo/show"><i class="fa fa-caret-right"></i> Demo show</a></li>
					<li id='subnav_wuparaloaigd'><a href="/springmvc/branch"><i class="fa fa-caret-right"></i> QL Chi nhánh</a></li>
					<li id='subnav_wuparahtchuyentien'><a href="/RPGW/wuparahtchuyentien.htm"><i class="fa fa-caret-right"></i> Hệ thống chuyển tiền</a></li>
					<li id='subnav_wuparahanmucngay'><a href="/RPGW/wuparahanmucngay.htm"><i class="fa fa-caret-right"></i> Hạn mức giao dịch ngày</a></li>
					<li id='subnav_wuparahanmucmon'><a href="/RPGW/wuparahanmucmon.htm"><i class="fa fa-caret-right"></i> Hạn mức giao dịch món</a></li>
					<li id='subnav_wuparaemailcbdm'><a href="/RPGW/wuparaemailcbdm.htm"><i class="fa fa-caret-right"></i> Cán bộ đầu mối</a></li>
					<li id='subnav_wuparadtuonghso'><a href="/RPGW/wuparadtuonghso.htm"><i class="fa fa-caret-right"></i> Đối tượng gửi tiền- hồ sơ</a></li>
					<li id='subnav_wuparatkhachtoan'><a href="/RPGW/wuparatkhachtoan.htm"><i class="fa fa-caret-right"></i> Tài khoản hạch toán</a></li>
				</ul>
			</li>
			<li class="nav-parent" index='0'><a href='javascript:;'><i class="fa fa-tags"></i> <span>Báo cáo</span></a>
				<ul id="child_params" class="children">
					<li id='subnav_wubcdoichieuth'><a href="/RPGW/wubcdoichieuth.htm"><i class="fa fa-caret-right"></i> Báo cáo đối chiếu với SIBS</a></li>
					<li id='subnav_wubchaukiem'><a href="/RPGW/wubchaukiem.htm"><i class="fa fa-caret-right"></i> Báo cáo liệt kê giao dịch</a></li>
				</ul>
			</li>
		</ul>
    </div>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		$("#subnav_getmtcninfo").hide();
	});
</script>
