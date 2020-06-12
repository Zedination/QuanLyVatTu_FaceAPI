<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="java.net.InetAddress"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.devmaster.mvc.entity.User"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- xử lý session: nếu user null thì trở về trang login --> <!-- chú ý: phần code java này cần phải để trước các tag link,script, c:url, nếu không sẽ
  bị lỗi  "Cannot call sendRedirect() after the response has been committed" -->
    <%
    java.util.Enumeration<String> sessEnum = request.getSession().getAttributeNames();
	User user =  (User)request.getSession().getAttribute("user");
	if(user == null) {
%>
	<c:redirect url="/login.htm"></c:redirect>
<%
	}
%>
<jsp:include page="/views/common/jspUtil.jsp" />
    <!-- The jQuery library is a prerequisite for all jqSuite products -->
    <script type="text/ecmascript" src="<c:url value="resources/jqgrid/js/jquery.min.js"/>"></script>
    <script
  src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"
  integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="
  crossorigin="anonymous"></script> 
   <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <%-- <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="resources/jqgrid/css/trirand/jquery-ui.css"/>" /> --%>
    <!-- We support more than 40 localizations -->
    <script type="text/ecmascript" src="<c:url value="resources/jqgrid/js/trirand/i18n/grid.locale-en.js"/>"></script>
    <!-- This is the Javascript file of jqGrid -->   
    <script type="text/ecmascript" src="<c:url value="resources/jqgrid/js/trirand/jquery.jqGrid.min.js"/>"></script>
    <!-- This is the localization file of the grid controlling messages, labels, etc.
    <!-- A link to a jQuery UI ThemeRoller theme, more than 22 built-in and many more custom -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css"> 
	
    <!-- The link to the CSS that the grid needs -->
    <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="resources/jqgrid/css/trirand/ui.jqgrid-bootstrap4.css"/>" />
	<script>
		//$.jgrid.defaults.width = 780;
		$.jgrid.defaults.styleUI = 'Bootstrap';
	</script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
	<link href="<c:url value="/resources/bs3css/stylebs3.css"/>" rel="stylesheet">
    <meta charset="utf-8" />
    
    <title>Điểm danh VAV Idols</title>
    <style type="text/css">
    .modal-load {
    display:    none;
    position:   fixed;
    z-index:    1000;
    top:        0;
    left:       0;
    height:     100%;
    width:      100%;
    background: rgba( 255, 255, 255, .8 ) 
                url('https://i.stack.imgur.com/FhHRx.gif') 
                50% 50% 
                no-repeat;
}

/* When the body has the loading class, we turn
   the scrollbar off with overflow:hidden */
body.loading {
    overflow: hidden;   
}

/* Anytime the body has the loading class, our
   modal element will be visible */
body.loading .modal-load {
    display: block;
}
@media only screen and (max-width: 768px){
  button{
      margin-top: 10px;
  }
  #dialog-nhandien{
      margin-top: 50px;
  }
}
@media only screen and (max-width: 576px){
  #dialog-nhandien{
      margin-top: 100px;
  }
}
@media only screen and (max-width: 840px){
  button{
      margin-top: 10px;
  }
}
    </style>
</head>
<body>

  <jsp:include page="/views/common/nav.jsp" />
  <jsp:include page="/views/common/Caculator.jsp" />
<div class="container-fluid text-center" >    
  <div class="row content">
    <div class="col-sm-1 sidenav">

    </div>
    <div class="col-sm-10 text-left" style = "box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);"> 
        <div id="ja-wrapper-inner" class="clearfix">
        <br>
        <br>
			<h1 style="text-align: center;">ĐIỂM DANH SINH VIÊN</h1>
            <br />
            <br>
            <br>
			<div id="dialog-search" title="Tìm kiếm" style="margin-bottom: 50px;">
				<table width="100%">
					<tr>
                        <td align=right><label for="PERSONID_search">PersionID &nbsp;</label></td>
                        
						<td align=left><input type="text" id="PERSONID_search"
							name="PERSONID_search" value=""
							class="text ui-widget-content ui-corner-all form-control"
							style="width: 300px;" /></td>
                    </tr>
					<tr>
                        <td align=right><label for="NAME_search">Tên Idols &nbsp;</label></td>
                        
						<td align=left><input type="text" id="NAME_search"
							name="NAME_search" value=""
							class="text ui-widget-content ui-corner-all form-control"
							style="width: 300px;" /></td>
					</tr>
					<tr>
						<td></td>
						<td align=left></td>
					</tr>
				</table>
            </div>
				<div style = "margin-bottom: 50px;" class = "button-div">
			<button id="btnSearch" style="float: left;" class="btn btn-primary"><i class="fas fa-search"></i> Tìm kiếm</button>
			<!-- <button id="btnCreate" name="button" style="float: left;" class="btn btn-primary"><i class="far fa-plus-square"></i> Thêm mới</button> -->
			<button id="btnEdit" name="button" style="float: left;" class="btn btn-primary"><i class="far fa-edit"></i> Điểm danh thủ công</button>
			<button id="btnReset" name="button" style="float: left;" class="btn btn-primary"><i class="fas fa-undo"></i> Reset Điểm danh</button>
			<!-- <button id="btnDelete" name="button" style="float: left;" class="btn btn-primary"><i class="far fa-trash-alt"></i> Xóa</button> -->
			<button id="btnReport" name="button" style="float: left;" class="btn btn-primary"><i class="fas fa-file-export"></i>  Xuất báo báo</button>
			<button onclick="document.getElementById('id01').style.display='block'" id="btnCaculator" name="button" style="float: left;" class="btn btn-primary"><i class="fas fa-calculator"></i></i>  Máy tính</button>
				</div>
				<br>
				<br>
			<br /> <br />
			<div id="dialog-nhandien" title="Nhận diện bằng link ảnh hoặc bằng file" style="margin-bottom: 50px;">
			<p style = "text-align:center; font-size:18px; font-weight:bold;" >Điểm danh bằng nhận diện khuôn mặt</p>
				<div class = "row">
					<label class="col-md-1" style = "text-align:center;" for="URL_input">Link ảnh</label>
					<div class = "col-md-9" ><input type="text" id="URL_input"
							name="URL_input" value=""
							class="text ui-widget-content ui-corner-all form-control"
							 /></div>
					<div class = "col-md-2" ><button id="URL_button" class="btn btn-primary"><i class="fas fa-paper-plane"></i> Submit url</button></div>
					
				</div>
				<br>
				<form id="formUploadFile" method="POST" action = "uploadFileIdols" enctype="multipart/form-data">
				<div class = "row">
					<label class="col-md-1" style = "text-align:center;" for="FILE_input">File ảnh</label>
					<div class = "col-md-9">
					<input type="file" id="FILE_input"
							name="FILE_input" value=""
							class="text ui-widget-content ui-corner-all form-control" required
							/>
					</div>
					<div class = "col-md-2"><button id="FILE_button" type="submit" style="float: left;" class="btn btn-primary"><i class="fas fa-file-upload"></i> Upload file</button></div>
				</div>
				</form>
				<br>
				<div class = "row">
				<div class = "col-md-2">Trạng thái upload file: </div>
				<div class="progress col-md-9" id="progressbox" style="height: 25px; margin-bottom:0!important;" >
		<!-- <div class="progress-bar progress-bar-striped active" id="progressbar"
			role="progressbar" aria-valuenow="80" aria-valuemin="0"
			aria-valuemax="100" style="width: 0%">
			<div id="status" style="text-align: center; width: 100%;"></div>
		</div> -->
		
      <div id="progressBar" class="progress-bar progress-bar-success" role="progressbar"
        aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">0%</div>
    
	</div>
				<div class = "col-md-1"></div>
				</div>
				<!-- <table width="100%">
					<tr>
                        <td align=right><label for="URL_input">Link ảnh &nbsp;</label></td>
                        
						<td align=left><input type="text" id="URL_input"
							name="URL_input" value=""
							class="text ui-widget-content ui-corner-all form-control"
							style="width: 1050px;" /></td>
							<td><button id="URL_button" style="float: left;" class="btn btn-primary"><i class="fas fa-paper-plane"></i> Submit url</button></td>
						
						
                    </tr>
					<tr>
                        <td align=right><label for="FILE_input">File ảnh &nbsp;</label></td>
                        
						<td align=left><input type="file" id="FILE_input"
							name="FILE_input" value=""
							class="text ui-widget-content ui-corner-all form-control"
							style="width: 1050px;"/></td>
						<td><button id="FILE_button" style="float: left;" class="btn btn-primary"><i class="fas fa-file-upload"></i> Upload file</button></td>
					</tr>
					<tr>
						<td></td>
						<td align=left></td>
					</tr>
				</table> -->
				
            </div>
			
					<table id="IDOLSGrid"></table>
					<div id="Pager1"></div>
			
			<br />
			
		</div>
    </div>
    <div class="col-sm-1 sidenav">
      
    </div>
  </div>
</div>

<footer class="container-fluid text-center">
  <p>@Lê Anh Đức - leanhduc9999@gmail.com</p>
</footer>

<script type="text/javascript">
function fncThemMoi(){
	$.ajax({
	   type: "POST",
	   url: "createVatTu",
	   data: buildDataSubmit(),
	   beforeSend: function(req) {
           showLoadingIcon();
       },
	   error: function(){
		   showError();
           blockflag = false;
           hideLoadingIcon();
	   },
	   success: function(obj){
		   	if (obj.code == '000') {
		   		showMessage("Thêm mới Vật tư thành công!");
		   		
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadIdolsList();
    hideLoadingIcon();
    $("#dialog_form_crud").dialog( "close" );
}

function fncCapNhat(){
	$.ajax({
	   type: "POST",
	   url: "updateIdols",
	   data: buildDataSubmit(),
	   beforeSend: function(req) {
           showLoadingIcon();
       },
	   error: function(){
		   showError();
           blockflag = false;
           hideLoadingIcon();
	   },
	   success: function(obj){
		   	if (obj.code == '000') {
		   		showMessage("Điểm danh thủ công thành công!");
		   		clear_crud();
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadIdolsList();
    hideLoadingIcon();
    $("#dialog_form_crud").dialog( "close" );
}
function PostUrlApi(){
	$.ajax({
	   type: "POST",
	   url: "nhandien-url",
	   data: buildDataApiSubmit(),
	   beforeSend: function(req) {
           showLoadingIcon();
           $body.addClass("loading");
       },
	   error: function(){
		   showError();
           blockflag = false;
           hideLoadingIcon();
           $body.removeClass("loading");
	   },
	   success: function(res){
		   $body.removeClass("loading");
		   	if (res.code == '000') {
		   		showMessage("Nhận diện khuôn mặt bằng url ảnh thành công!");
		   		reloadIdolsList();
		   		clear_crud();
		    } else {
		    	showMessage(res.msg);
			};
	   }
    });
	//reloadIdolsList();
    hideLoadingIcon();
    /* $("#dialog_form_crud").dialog( "close" ); */
}

function PostFileApi(){
	var form = document.forms[0];
    var formData = new FormData(form);
	$.ajax({
	   type: "POST",
	   url: "uploadFileIdols",
	   data: formData,
	   beforeSend: function(xhr) {
		   $('#alertMsg').text('');
   		$('#progressBar').text('');
   		$('#progressBar').css('width','0%');
   		$body.addClass("loading");
       },
	   error: function(){
		   showError();
           blockflag = false;
           hideLoadingIcon();
           $body.removeClass("loading");
	   },
	   success: function(res){
		   $body.removeClass("loading");
		   	if (res.code == '000') {
		   		showMessage("Nhận diện khuôn mặt bằng file ảnh thành công!");
		   		reloadIdolsList();
		   		clear_crud();
		    } else {
		    	showMessage(res.msg);
			};
	   }
    });
	//reloadIdolsList();
    hideLoadingIcon();
    /* $("#dialog_form_crud").dialog( "close" ); */
    ajaxReq.done(function(msg) {
	      $('#alertMsg').text(msg);
	      $('input[type=file]').val('');
	      $('button[type=submit]').prop('disabled',false);
	    });
	    
	    // Called on failure of file upload
	    ajaxReq.fail(function(jqXHR) {
	      $('#alertMsg').text(jqXHR.responseText+'('+jqXHR.status+
	      		' - '+jqXHR.statusText+')');
	      $('button[type=submit]').prop('disabled',false);
	    });
}

function fncXoaBo(){
	$.ajax({
	   type: "POST",
	   url: "deleteVatTu",
	   data: buildDataSubmit(),
	   beforeSend: function(req) {
           showLoadingIcon();
       },
	   error: function(){
		   showError();
           blockflag = false;
           hideLoadingIcon();
	   },
	   success: function(obj){
		   	if (obj.code == '000') {
		   		showMessage("Cập nhật Vật tư thành công!");
		   		clear_crud();
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadIdolsList();
    hideLoadingIcon();
    /* $("#dialog_form_crud").dialog( "close" ); */
}

function fncReset(){
	$.ajax({
	   type: "POST",
	   url: "resetDiemDanh",
	   data: buildDataApiSubmit(),
	   beforeSend: function(req) {
           showLoadingIcon();
       },
	   error: function(){
		   showError();
           blockflag = false;
           hideLoadingIcon();
	   },
	   success: function(obj){
		   	if (obj.code == '000') {
		   		showMessage("Reset điểm danh thành công!");
		   		clear_crud();
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadIdolsList();
    hideLoadingIcon();
    /* $("#dialog_form_crud").dialog( "close" ); */
}

function buildDataSubmit() {
	var data = new Object();
	var id = jQuery("#IDOLSGrid").jqGrid('getGridParam','selrow'); 
	if (id) {
	var ret = jQuery("#IDOLSGrid").jqGrid('getRowData',id);
	}
 	data.personId=ret.personId;
/* 	data.name=$('#TENVTU_crud').val();
	data.userData=$('#DVTINH_crud').val(); */
	data.diemDanh=$('#DIEMDANH_crud').val();
	return data;
}
function buildDataApiSubmit(){
	var data = new Object();
	data.url = $('#URL_input').val();
	return data;
}
function getCondition(){
	var condition = new Object();
	condition.personId=$('#PERSONID_search').val();
	condition.name=$('#NAME_search').val();
	return condition;
}

function reloadIdolsList() {
	$('#IDOLSGrid').jqGrid("clearGridData", true);
    $('#IDOLSGrid').jqGrid('setGridParam',{
        postData:{}
    }).trigger("reloadGrid");
}

function checkSpecialChar(control)
{
	var noiDung;
	var replaceND;
	
	if(control == "MAVTU_crud") {
	    replaceND = $("#MAVTU_crud").val();
	    noiDung = replaceND.trim();
	    var splChars = "~`!@#$%^&*?<>{}|[]";
		for (var i = 0; i < noiDung.length; i++) {
		    if (splChars.indexOf(noiDung.charAt(i)) != -1){
		    	replaceND = replaceND.replace(noiDung.charAt(i), "");
			}
		}
		$("#MAVTU_crud").val(replaceND);
	}
	if(control == "TENVTU_crud") {
	    replaceND = $("#TENVTU_crud").val();
	    noiDung = replaceND.trim();
	    var splChars = "~`!@#$%^&*?<>{}|[]";
		for (var i = 0; i < noiDung.length; i++) {
		    if (splChars.indexOf(noiDung.charAt(i)) != -1){
		    	replaceND = replaceND.replace(noiDung.charAt(i), "");
			}
		}
		$("#TENVTU_crud").val(replaceND);
	}
}

function clear_crud()
{
/* 	$("#MAVTU_crud").val("");
	$("#TENVTU_crud").val("");
	$("#DVTINH_crud").val(""); */
	$("#DIEMDANH_crud").val("");
}

function bind_crud()
{
	var id = jQuery("#IDOLSGrid").jqGrid('getGridParam','selrow'); 
	if (id) {
		var ret = jQuery("#IDOLSGrid").jqGrid('getRowData',id);
		$("#MAVTU_crud").val(ret.personId);
		$("#TENVTU_crud").val(ret.name);
		$("#DVTINH_crud").val(ret.userData);
		$("#DIEMDANH_crud").val(ret.diemDanh);
	}
}

$(function() {
	jQuery("#IDOLSGrid").jqGrid({ 
		url:'listIdols', 
		datatype: "json", 
		colNames : [ 'PersonID','Tên Idols','UserData', 'Trạng thái điểm danh'],
        colModel : [ {
                name : 'personId',
                index : 'personId',
                width : 350
        }, {
                name : 'name',
                index : 'name',
                width : 200,
                editable : false
        }, {
                name : 'userData',
                index : 'userData',
                width : 150,
                editable : false
        }, {
            name : 'diemDanh',
            index : 'diemDanh',
            width : 250,
            editable : false
    	}],
		rowNum:15,  rowList:[15,30,60,80,100], pager: '#Pager1', 
		scrollrows: true,
		autowidth: true,
		height: 300,
		width:650,
		shrinkToFit:false,
		caption: " Danh sách Idols",
		sortname: 'personId', viewrecords: true, sortorder: "ASC",
		serializeGridData: function (postData) {
        	var condition = getCondition(); 
       		condition.rowPerPage = postData.rows;
            condition.currentPage = postData.page;
            condition.fromRow = (parseInt(postData.page) - 1) * postData.rows;
            condition.endRow = postData.rows * postData.page;
            condition.event= postData.event;
            condition.sidx= postData.sidx;
            condition.sord= postData.sord;
            return condition;
        },


	}).navGrid('#Pager1',{edit:false,add:false,del:false,search:false,refresh:true,view:false,position:"left",cloneToTop:true});
	})
</script>


<div id="dialog_form_crud" style="display: none;" title="CRUD">
	<form>
		<table width="100%">
			<!-- <tr>
				<td align=left><label for="MAVTU_crud">Mã Vật tư <font color="red">(*)</font>
				</label></td>
				<td><input type="text" id="MAVTU_crud"
					name="MAVTU_crud" value=""
					class="text ui-widget-content ui-corner-all" size="20"
					maxlength="8" onkeyup="checkSpecialChar('MAVTU_crud')"
					onkeypress="checkSpecialChar('MAVTU_crud')" /></td>
			</tr>
			<tr>
				<td align=left><label for="TENVTU_crud">Tên Vật tư</label></td>
				<td align=left><input type="text" id="TENVTU_crud"
					name="TENVTU_crud" value=""
					class="text ui-widget-content ui-corner-all" maxlength="60"
					size="40" onkeyup="checkSpecialChar('TENVTU_crud')"
					onkeypress="checkSpecialChar('TENVTU_crud')" /></td>
			</tr>
			<tr>
				<td align=left><label for="DVTINH_crud">Đơn vị tính</label></td>
				<td align=left><input type="text" id="DVTINH_crud"
					name="DVTINH_crud" value=""
					class="text ui-widget-content ui-corner-all" maxlength="100"
					size="40" /></td>
			</tr> -->
			<tr>
				<td align=left><label for="DIEMDANH_crud">Nội dung điểm danh</label></td>
				<!-- <td align=left><input type="text" id="DIEMDANH_crud"
					name="DIEMDANH_crud" value=""
					class="text ui-widget-content ui-corner-all" maxlength="100"
					size="40" /></td> -->
				 <td> <select id = "DIEMDANH_crud" name = "DIEMDANH_crud" autofocus>
				 	  <option value="Đi học">Đi học</option>
  					  <option value="Đi muộn">Đi muộn</option>
    				  <option value="Nghỉ học">Nghỉ học</option>
    			  </select> </td>
			</tr>
		</table>
	</form>
</div>
<div id="dialog_info" style="display: none" title="Thông báo">
Hãy chọn một bản ghi
</div>
<div id="dialog_confirm_delete" style="display: none" title="Thông báo">
Bạn có chắc muốn xóa không?
</div>
<div id="dialog_confirm_reset" style="display: none" title="Thông báo">
Bạn có chắc muốn reset điểm danh không?
</div>
<div id="dialog_confirm_send_url" style="display: none" title="Thông báo">
Bạn có chắc muốn điểm danh bằng nhận diện khuôn mặt qua url ảnh không?
</div>
<div id="dialog_confirm_send_file" style="display: none" title="Thông báo">
Bạn có chắc muốn điểm danh bằng nhận diện khuôn mặt qua file ảnh không?
</div>
<br />

<script type="text/javascript">
	$(document).ready(function() {
		$("#PERSONID_search").keypress(function(event) {
			if (event.which == 13) {
				reloadIdolsList();
			}
		});
		$("#NAME_search").keypress(function(event) {
			if (event.which == 13) {
				reloadIdolsList();
			}
		});
		$("#btnSearch").button().click(function() {
			reloadIdolsList();
		}); 

		$( "#btnCreate" ).button().click(function() {
			clear_crud();
			$( "#dialog_form_crud" ).dialog({
	              autoOpen: true,
	              height: 300,
	              width: 500,
	              modal: true,
	              tittle: "Thêm mới",
	              buttons: { 
	                  Cancel: {
	                      class:'button',
	                      text:'Thoát', 
	                      click: function() {
	                          $( this ).dialog( "close" );
	                      }
	                  },
	                  Submit: {
	                      class:'button',
	                      text:'Thêm mới', 
	                      click: function() {
	                    	  fncThemMoi();
	                      }
	                  }
	              }
	          });
		});
		
		$( "#btnEdit" ).button().click(function() {
			var id = jQuery("#IDOLSGrid").jqGrid('getGridParam','selrow');
			if(id){
			bind_crud();
			/* $("#MAVTU_crud").prop("disabled", true);
			$("#MAVTU_crud").css("backgroundColor","yellow"); */
			$( "#dialog_form_crud" ).dialog({
				autoOpen: true,
	              height: 200,
	              width: 350,
	              modal: true,
	              /* close: function(){
	            	  $("#MAVTU_crud").prop("disabled", false);
	            	  $("#MAVTU_crud").css("backgroundColor","white");
	              }, */
	              buttons: { 
	                  Cancel: {
	                      class:'button',
	                  	  text:'Thoát', 
	                      click: function() {
	                          $( this ).dialog( "close" );
	                          /* $("#MAVTU_crud").prop("disabled", false);
	                          $("#MAVTU_crud").css("backgroundColor","white"); */
	                      }
	                  },
	                  Submit: {
	                	  class:'button',
	                  	  text:'Điểm Danh', 
	                      click: function() {
	                    	  
	                    	  fncCapNhat();
	                    	  /* $("#MAVTU_crud").prop("disabled", false);
	                    	  $("#MAVTU_crud").css("backgroundColor","white"); */
	                      }
	                  }
	              }
	          });
			}else {
				$( "#dialog_info" ).dialog({
	                  modal: true,
	                  height: 230,
	                  width: 350,
	                  buttons: {
	                  OK: function() {
	                      $( this ).dialog( "close" );
	                      
	                  }
	                  }
	              }); 
			}
			
		});
		
		$( "#URL_button" ).button().click(function() {
			//var url = $("#URL_input").val();
			let url = document.getElementById('URL_input').value;
			if(isURL(url)){
				$( "#dialog_confirm_send_url" ).dialog({
					autoOpen: true,
		              height: 200,
		              width: 350,
		              modal: true,
		              /* close: function(){
		            	  $("#MAVTU_crud").prop("disabled", false);
		            	  $("#MAVTU_crud").css("backgroundColor","white");
		              }, */
		              buttons: { 
		                  Cancel: {
		                      class:'button',
		                  	  text:'Thoát', 
		                      click: function() {
		                          $( this ).dialog( "close" );
		                          
		                      }
		                  },
		                  Submit: {
		                	  class:'button',
		                  	  text:'Post Url', 
		                      click: function() {
		                    	  if(isURL(url)){
		                    	  PostUrlApi();
		                    	  $("#dialog_confirm_send_url").dialog( "close" );
		                    	  }else{
		                    		  alert("Sai định dạng url. Vui lòng nhập url là ảnh có định dạng .jpg, .png hoặc .gif");
		                    		  $("#dialog_confirm_send_url").dialog( "close" );
		                    	  }
		                    	  
		                      }
		                  }
		              }
		          });
			}else{
				alert("Sai định dạng url. Vui lòng nhập url là ảnh có định dạng .jpg, .png hoặc .gif");
				console.log(url);
				$("#URL_input").val("");
			}
			
			
			
		});
		
		/* $( "#FILE_button" ).button().click(function() {
			
			let filePath = document.getElementById('FILE_input').value;
			if(fileValidation(filePath)){
				$( "#dialog_confirm_send_file" ).dialog({
					autoOpen: true,
		              height: 300,
		              width: 450,
		              modal: true,
		             
		              buttons: { 
		                  Cancel: {
		                      class:'button',
		                  	  text:'Thoát', 
		                      click: function() {
		                          $( this ).dialog( "close" );
		                          
		                      }
		                  },
		                  Submit: {
		                	  class:'button',
		                  	  text:'Upload File', 
		                      click: function() {
		                    	  
		                    	  PostFileApi();
		                    	  $("#dialog_confirm_send_file").dialog( "close" );
		                    	  
		                    	  
		                      }
		                  }
		              }
		          });
			}else{
				alert("Sai định dạng. Vui lòng nhập ảnh có định dạng .jpg, .png hoặc .gif");
				console.log(filePath);
				$("#FILE_input").val("");
			}
			
			
			
		}); */
		
		$( "#btnReset" ).button().click(function() {
			$( "#dialog_confirm_reset" ).dialog({
				autoOpen: true,
	              modal: true,
	              height: 200,
	              width: 350,
	              /* close: function(){
	            	  $("#MAVTU_crud").prop("disabled", false);
	            	  $("#MAVTU_crud").css("backgroundColor","white");
	              }, */
	              buttons: { 
	                  Cancel: {
	                      class:'button',
	                  	  text:'Thoát', 
	                      click: function() {
	                          $( this ).dialog( "close" );
	                          
	                      }
	                  },
	                  Submit: {
	                	  class:'button',
	                  	  text:'reset Điểm Danh', 
	                      click: function() {
	                    	  fncReset();
	                    	  $("#dialog_confirm_reset").dialog( "close" );
	                    	  
	                    	  
	                      }
	                  }
	              }
	          });
			
			
		});
		
		$("#btnReport").button().click(function() {
			
					
					
				   var PrintUrl='${pageContext.request.contextPath}/rptIdols?personId='+$("#PERSONID_search").val()+'&name='+$("#NAME_search").val();
				   var randomnumber = Math.floor((Math.random()*100)+1);
				   //window.open(PrintUrl,"_blank",'PopUp',randomnumber,'scrollbars=1,menubar=0,resizable=1;dialogWidth:0px;dialogHeight:0px');
				   window.open(PrintUrl,"_blank");
  
		});
		
		
		$( "#btnDelete" ).button().click(function() {
			var id1 = jQuery("#IDOLSGrid").jqGrid('getGridParam','selrow');
			if(id1){
			bind_crud();
			$( "#dialog_confirm_delete" ).dialog({
				autoOpen: true,
	              height: 300,
	              width: 500,
	              modal: true,
	              buttons: { 
	                  Cancel: {
	                	  class:'button',
	                  	  text:'Thoát', 
	                      click: function() {
	                          $( this ).dialog( "close" );
	                      }
	                  },
	                  Submit: {
	                	  class:'button',
	                  	  text:'Xóa bỏ', 
	                      click: function() {
	                    	  fncXoaBo();
	                    	  $("#dialog_confirm_delete").dialog( "close" );
	                      }
	                  }
	              }
	          });
			}else{
				$( "#dialog_info" ).dialog({
	                  modal: true,
	                  height: 230,
	                  width: 350,
	                  buttons: {
	                  OK: function() {
	                      $( this ).dialog( "close" );
	                  }
	                  }
	              }); 
			}
		});
		
	});
	
</script>

<script type="text/javascript">
	/* $('#FILE_button').button().click(function(){
		alert("Chức năng chưa được phát triển, vui lòng thử lại sau");
	}); */
	$body = $("body");
//hiện màn hình loading cho toàn bộ quá trình ajax trong trang
/*	$(document).on({
	    ajaxStart: function() { $body.addClass("loading");    },
	     ajaxStop: function() { $body.removeClass("loading"); }    
	}); */
	//kiểm tra tính hợp lệ của url ảnh
	function isURL(url){
        if (url == ""|| url == null)
                return false;
 
        url = trim(url);
 
        if (url.indexOf(" ")!=-1)
                return false;
 
        //var RegExp = /^http(s)?:\/\/[\w|\-]+(\.[^\.]+)+$/i;
        var RegExp = /(http(s?):)([/|.|\w|\s|-])*\.(?:jpg|gif|png|jpeg)/g;
 		//var RegExp = /(https?:\/\/.*\.(?:png|jpg))/i
        if(RegExp.test(url)){
                return true;
        }else{
                return false;
        }
}
	function fileValidation(){
		let filePath = document.getElementById('FILE_input').value;
		var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;
		if(!allowedExtensions.exec(filePath)){
			return false;
		}else{
			return true;
		}
	}
	function checkSize(){
		let size = document.getElementById('FILE_input').files[0].size;
		if(size/1024/1024>6||size<1024){
			return false;
		}else{
			return true;
		}
	}
	
	
	
</script>
<script src="http://malsup.github.com/jquery.form.js"></script>
<!-- đoạn script bên dưới là đoạn code Ajax upload file dự phòng -->
<script type="text/javascript">
$(function() {
	  $('button[type=submit]').click(function(e) {
	    e.preventDefault();
	    //Disable submit button
	    //$(this).prop('disabled',true);
	    
	    var form = document.forms[0];
	    var formData = new FormData(form);
	    if(fileValidation()&&checkSize()){
	    // Ajax call for file uploaling
	    var ajaxReq = $.ajax({
	      url : 'uploadFileIdols',
	      type : 'POST',
	      data : formData,
	      cache : false,
	      contentType : false,
	      processData : false,
	      xhr: function(){
	        //Get XmlHttpRequest object
	         var xhr = $.ajaxSettings.xhr() ;
	        
	        //Set onprogress event handler 
	         xhr.upload.onprogress = function(event){
	          	var perc = Math.round((event.loaded / event.total) * 100);
	          	$('#progressBar').text(perc + '%');
	          	$('#progressBar').css('width',perc + '%');
	         };
	         return xhr ;
	    	},
	    	beforeSend: function( xhr ) {
	    		//Reset alert message and progress bar
	    		$('#progressBar').text('');
	    		$('#progressBar').css('width','0%');
	    		$body.addClass("loading");
	              },
	              error: function(){
	       		   showError();
	                  blockflag = false;
	                  $body.removeClass("loading");
	       	   },
	       	   success: function(res){
	       		   $body.removeClass("loading");
	       		   	if (res.code == '000') {
	       		   		showMessage("Nhận diện khuôn mặt bằng file ảnh thành công!");
	       		   		reloadIdolsList();
	       		   		clear_crud();
	       		    } else {
	       		    	showMessage(res.msg);
	       			};
	       	   }     
	    });
	    }else if(!checkSize()){
	    	alert("File upload phải có dung lượng từ 1KB tới 6MB");
	    	$('#FILE_input').val('');
	    }else
	    {
	    	alert("Sai định dạng! Vui lòng chọn file có định dạng .jpg, .jpeg, .png, .gif");
	    	$('#FILE_input').val('');
	    }
	    //hideLoadingIcon();
	    // Called on success of file upload
	    ajaxReq.done(function(msg) {
	      $('input[type=file]').val('');
	      $('#FILE_input').val('');
	      $('button[type=submit]').prop('disabled',false);
	    });
	    
	    // Called on failure of file upload
	    ajaxReq.fail(function(jqXHR) {
	      $('button[type=submit]').prop('disabled',false);
	    });
	  });
	});
</script>
<div class = "modal-load"></div>
</body>
</html>