<%@page import="java.time.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<%LocalTime time = LocalTime.now();%>
	<head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Chat DEMO</title>
        <style>
            	body,html{
			height: 100%;
			margin: 0;
			background: #7F7FD5;
	       background: -webkit-linear-gradient(to right, #91EAE4, #86A8E7, #7F7FD5);
	        background: linear-gradient(to right, #91EAE4, #86A8E7, #7F7FD5);
		}

		.chat{
			margin-top: auto;
			margin-bottom: auto;
		}
		.card{
			height: 500px;
			border-radius: 15px !important;
			background-color: rgba(0,0,0,0.4) !important;
		}
		.contacts_body{
			padding:  0.75rem 0 !important;
			overflow-y: auto;
			white-space: nowrap;
		}
		.msg_card_body{
			overflow-y: auto;
		}
		.card-header{
			border-radius: 15px 15px 0 0 !important;
			border-bottom: 0 !important;
		}
	 .card-footer{
		border-radius: 0 0 15px 15px !important;
			border-top: 0 !important;
	}
		.container{
			align-content: center;
		}
		.search{
			border-radius: 15px 0 0 15px !important;
			background-color: rgba(0,0,0,0.3) !important;
			border:0 !important;
			color:white !important;
		}
		.search:focus{
		     box-shadow:none !important;
           outline:0px !important;
		}
		.type_msg{
			background-color: rgba(0,0,0,0.3) !important;
			border:0 !important;
			color:white !important;
			height: 60px !important;
			overflow-y: auto;
		}
			.type_msg:focus{
		     box-shadow:none !important;
           outline:0px !important;
		}
		.attach_btn{
	border-radius: 15px 0 0 15px !important;
	background-color: rgba(0,0,0,0.3) !important;
			border:0 !important;
			color: white !important;
			cursor: pointer;
		}
		.send_btn{
	border-radius: 0 15px 15px 0 !important;
	background-color: rgba(0,0,0,0.3) !important;
			border:0 !important;
			color: white !important;
			cursor: pointer;
		}
		.search_btn{
			border-radius: 0 15px 15px 0 !important;
			background-color: rgba(0,0,0,0.3) !important;
			border:0 !important;
			color: white !important;
			cursor: pointer;
		}
		.contacts{
			list-style: none;
			padding: 0;
		}
		.contacts li{
			width: 100% !important;
			padding: 5px 10px;
			margin-bottom: 15px !important;
		}
	.active{
			background-color: rgba(0,0,0,0.3);
	}
		.user_img{
			height: 70px;
			width: 70px;
			border:1.5px solid #f5f6fa;
		
		}
		.user_img_msg{
			height: 40px;
			width: 40px;
			border:1.5px solid #f5f6fa;
		
		}
	.img_cont{
			position: relative;
			height: 70px;
			width: 70px;
	}
	.img_cont_msg{
			height: 40px;
			width: 40px;
	}
	.online_icon{
		position: absolute;
		height: 15px;
		width:15px;
		background-color: #4cd137;
		border-radius: 50%;
		bottom: 0.2em;
		right: 0.4em;
		border:1.5px solid white;
	}
	.offline{
		background-color: #c23616 !important;
	}
	.user_info{
		margin-top: auto;
		margin-bottom: auto;
		margin-left: 15px;
	}
	.user_info span{
		font-size: 20px;
		color: white;
	}
	.user_info p{
	font-size: 10px;
	color: rgba(255,255,255,0.6);
	}
	.video_cam{
		margin-left: 50px;
		margin-top: 5px;
	}
	.video_cam span{
		color: white;
		font-size: 20px;
		cursor: pointer;
		margin-right: 20px;
	}
	.msg_cotainer{
		margin-top: auto;
		margin-bottom: auto;
		margin-left: 10px;
		border-radius: 25px;
		background-color: #82ccdd;
		padding: 10px;
		position: relative;
	}
	.msg_cotainer_send{
		margin-top: auto;
		margin-bottom: auto;
		margin-right: 10px;
		border-radius: 25px;
		background-color: #78e08f;
		padding: 10px;
		position: relative;
	}
	.msg_time{
		position: absolute;
		left: 0;
		bottom: -15px;
		color: rgba(255,255,255,0.5);
		font-size: 10px;
	}
	.msg_time_send{
		position: absolute;
		right:0;
		bottom: -15px;
		color: rgba(255,255,255,0.5);
		font-size: 10px;
	}
	.msg_head{
		position: relative;
	}
	#action_menu_btn{
		position: absolute;
		right: 10px;
		top: 10px;
		color: white;
		cursor: pointer;
		font-size: 20px;
	}
	.action_menu{
		z-index: 1;
		position: absolute;
		padding: 15px 0;
		background-color: rgba(0,0,0,0.5);
		color: white;
		border-radius: 15px;
		top: 30px;
		right: 15px;
		display: none;
	}
	.action_menu ul{
		list-style: none;
		padding: 0;
	margin: 0;
	}
	.action_menu ul li{
		width: 100%;
		padding: 10px 15px;
		margin-bottom: 5px;
	}
	.action_menu ul li i{
		padding-right: 10px;
	
	}
	.action_menu ul li:hover{
		cursor: pointer;
		background-color: rgba(0,0,0,0.2);
	}
	@media(max-width: 576px){
	.contacts_card{
		margin-bottom: 15px !important;
	}
	}
        </style>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.js"></script>
	</head>
	<body>
        <header>
            <h1 style="text-align: center;">DEMO CHAT SỬ DỤNG WEBSOCKET</h1>
            <p style="text-align: center;">Hướng dẫn sử dụng: khi mới kết nối đến phòng chat, Hệ thống sẽ lấy tin nhắn đầu tiên bạn gửi đi làm định danh của bạn trong phòng chat</p>
        </header>
		<div class="container-fluid h-100">
			<div class="row justify-content-center h-100">
				<div class="col-md-12 chat">
					<div class="card">
						<div class="card-header msg_head">
							<div class="d-flex bd-highlight">
								<div class="img_cont">
									<img src="https://static.turbosquid.com/Preview/001292/481/WV/_D.jpg" class="rounded-circle user_img">
									<span class="online_icon"></span>
								</div>
								<div class="user_info">
									<span>Chat By WebSocket</span>
									<p>Unknown Messages</p>
								</div>
								<!-- <div class="video_cam">
									<span><i class="fas fa-video"></i></span>
									<span><i class="fas fa-phone"></i></span>
								</div> -->
							</div>
							<span id="action_menu_btn"><i class="fas fa-ellipsis-v"></i></span>
							<div class="action_menu">
								<ul>
									<li><a style="color: white; text-decoration : none;" href = "main"><i class="fas fa-home"></i> Trang chủ</a></li>
									<li><a style="color: white; text-decoration : none;" href = "login"><i class="fas fa-users"></i> Đăng nhập</a></li>
									<li><a style="color: white; text-decoration : none;" href = "chat"><i class="fas fa-retweet"></i> Reconnect</a></li>
									
								</ul>
							</div>
						</div>
						<div class="card-body msg_card_body" id="parent">
							<div class="d-flex justify-content-start mb-4" id = "message">
								<div class="img_cont_msg">
									<img src="https://source.unsplash.com/user/erondu/60x60" id ="imageUserDemo" class="rounded-circle user_img_msg">
								</div>
								<div class="msg_cotainer">
									Server Connected!
									<span class="msg_time"><%out.print(time); %></span>
								</div>
							</div>
							
							
							
							
						</div>
						<div class="card-footer">
							<div class="input-group">
								<div class="input-group-append">
									<span class="input-group-text attach_btn"><i class="fas fa-paperclip"></i></span>
								</div>
								<textarea name="" id="textMessage" class="form-control type_msg" id = "areaText" placeholder="Nhập tin nhắn... Lưu ý: Hệ thống sẽ lấy tin nhắn đầu tiên bạn gửi làm định danh cho bạn trong phòng chat"></textarea>
								<div class="input-group-append">
									<button class="input-group-text send_btn" onclick="sendMessage()"><i class="fas fa-location-arrow"></i> </button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
        </div>
        <script>
        	$(document).ready(function(){
$('#action_menu_btn').click(function(){
	$('.action_menu').toggle();
});
	});
        </script>
                <script>
            function myFunc(){
                var chatMess = document.getElementById("message");
                var copy = chatMess.cloneNode(true);
                var parent = document.getElementById("parent");
                parent.appendChild(copy);
            }
            function createElement(text){
                /* var input = document.getElementById('areaText').value; */
                var parent1 = document.createElement('div');
                parent1.classList.add('d-flex');
                parent1.classList.add('justify-content-start');
                parent1.classList.add('mb-4');
                // var logo  = document.createElement('image');
                // logo.classList.add('rounded-circle');
                // logo.classList.add('user_img_msg');
                // logo.src='test.jpg';
                var logoParent  = document.getElementById('imageUserDemo');
                var logo = logoParent.cloneNode(true);
                var divLogo = document.createElement('div');
                divLogo.classList.add('img_cont_msg');
                var divContent = document.createElement('div');
                divContent.classList.add('msg_cotainer');
                var node = document.createTextNode(text);
                var dateObject = new Date();
                var localTime = dateObject.toLocaleTimeString();
                var timeSpan = document.createElement('span');
                var timeNode = localTime.toString();
                timeSpan.classList.add('msg_time');
                timeSpan.innerHTML = timeNode;
                divContent.appendChild(node);
                divLogo.appendChild(logo);
                parent1.appendChild(divLogo);
                parent1.appendChild(divContent);
                divContent.appendChild(timeSpan);
                var parent = document.getElementById("parent");
                parent.appendChild(parent1);
            }
        </script>
        <script type="text/javascript">
			/* var websocket = new WebSocket("ws://localhost:8080/devmaster_springmvc/chatRoomServer"); */
			var websocket = new WebSocket("wss://springdemobyanhduc.herokuapp.com//chatRoomServer");
				websocket.onopen = function(message) {processOpen(message);};
				websocket.onmessage = function(message) {processMessage(message);};
				websocket.onclose = function(message) {processClose(message);};
				websocket.onerror = function(message) {processError(message);};

			function processOpen(message) {
				/* textAreaMessage.value += "Server connect... \n"; */
			}
			function processMessage(message) {
				console.log(message);
				createElement(message.data.toString());
			}
			function processClose(message) {
				/* textAreaMessage.value += "Server Disconnect... \n"; */
				createElement("Server Disconnect...");
			}
			function processError(message) {
				/* textAreaMessage.value += "Error... " + message +" \n"; */
				var error = "Error... " + message;
				createElement(error);
			}

			function sendMessage() {
				if (typeof websocket != 'undefined' && websocket.readyState == WebSocket.OPEN) {
					websocket.send(textMessage.value);
					textMessage.value = "";
				}
			}

		</script>

        
	</body>
</html>