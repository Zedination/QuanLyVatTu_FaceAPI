<%@page
	language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="headerbar row">
	<div class="col-sm-1 col-xs-12 no-padding">
	<a class="menutoggle"><i class="fa fa-bars"></i></a>
	</div>
	<div class="header-mid col-sm-9 col-xs-12 no-padding">
        <div id="breaking-news"></div>
    </div>
	<div class="header-right col-sm-2 col-xs-12 no-padding">
		<ul class="headermenu">
			<li>
	            <div class="btn-group">
	              	<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
		                <img src="/resources//image/user.png" alt="" />
		                <a id='app-username'></a>
		                <span class="caret"></span>
	              	</button>
	              	<ul class="dropdown-menu dropdown-menu-usermenu pull-right">
		                <li><a href="#"><i class="glyphicon glyphicon-user"></i>Nguyễn Văn Giáp - TTCNTT</a></li>
		                <li><a href="#"><i class="fa fa-key"></i>Đổi mật khẩu </a></li>
		                <li><a href="#"><i class="glyphicon glyphicon-log-out"></i> Đăng xuất</a></li>
	              	</ul>
	            </div>
       		</li>
		</ul>
	</div>
</div>
<style>
	.no-padding {
		padding: 0px !important;
	}
	.header-mid {
		height: 50px;
	}
	.telex {
		background: #fff;
		color: blue;
		font-weight: bold;
		font-size: 16px;
		height: 50px;
	}
</style>
<script type="text/javascript">
	$('#breaking-news').telex({
	        	      messages: [
	        	          {
	        	              id: 'msg1',
	        	              content: ''                
	        	          }
	        	          /* more messages... */
	        	      ],
	        	      delay: 0,
	        	      duration: 20000
	        	  });
</script>