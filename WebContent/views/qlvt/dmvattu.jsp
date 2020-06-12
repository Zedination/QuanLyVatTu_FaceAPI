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
		$.jgrid.defaults.width = 780;
		$.jgrid.defaults.styleUI = 'Bootstrap';
	</script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
	<link href="<c:url value="/resources/bs3css/stylebs3.css"/>" rel="stylesheet">
    <meta charset="utf-8" />

    <title>Danh mục vật tư</title>
        
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
			<h1 style="text-align: center;">DANH MỤC VẬT TƯ</h1>
            <br />
            <br>
            <br>
			<div id="dialog-search" title="Tìm kiếm" style="margin-bottom: 50px;">
				<table width="100%">
					<tr>
                        <td align=right><label for="MAVTU_search">Mã Vật tư &nbsp;</label></td>
                        
						<td align=left><input type="text" id="MAVTU_search"
							name="MAVTU_search" value=""
							class="text ui-widget-content ui-corner-all form-control"
							style="width: 300px;" /></td>
                    </tr>
					<tr>
                        <td align=right><label for="TENVTU_search">Tên Vật tư &nbsp;</label></td>
                        
						<td align=left><input type="text" id="TENVTU_search"
							name="TENVTU_search" value=""
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
			<button id="btnCreate" name="button" style="float: left;" class="btn btn-primary"><i class="far fa-plus-square"></i> Thêm mới</button>
			<button id="btnEdit" name="button" style="float: left;" class="btn btn-primary"><i class="far fa-edit"></i> Sửa</button>
			<button id="btnDelete" name="button" style="float: left;" class="btn btn-primary"><i class="far fa-trash-alt"></i> Xóa</button>
			<button id="btnReport" name="button" style="float: left;" class="btn btn-primary"><i class="fas fa-file-export"></i>  Xuất báo báo</button>
			<button onclick="document.getElementById('id01').style.display='block'" id="btnCaculator" name="button" style="float: left;" class="btn btn-primary"><i class="fas fa-calculator"></i></i>  Máy tính</button>
				</div>
				<br>
				<br>
			<br /> <br />
			<table id="DMVATTUGrid" ></table>
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
	reloadVATTUList();
    hideLoadingIcon();
    $("#dialog_form_crud").dialog( "close" );
}

function fncCapNhat(){
	$.ajax({
	   type: "POST",
	   url: "updateVatTu",
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
	reloadVATTUList();
    hideLoadingIcon();
    $("#dialog_form_crud").dialog( "close" );
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
	reloadVATTUList();
    hideLoadingIcon();
    /* $("#dialog_form_crud").dialog( "close" ); */
}

function buildDataSubmit() {
	var data = new Object();
	data.mavtu=$('#MAVTU_crud').val();
	data.tenvtu=$('#TENVTU_crud').val();
	data.dvtinh=$('#DVTINH_crud').val();
	data.phantram=$('#PHANTRAM_crud').val();
	return data;
}

function getCondition(){
	var condition = new Object();
	condition.mavtu=$('#MAVTU_search').val();
	condition.tenvtu=$('#TENVTU_search').val();
	return condition;
}

function reloadVATTUList() {
	$('#DMVATTUGrid').jqGrid("clearGridData", true);
    $('#DMVATTUGrid').jqGrid('setGridParam',{
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
	$("#MAVTU_crud").val("");
	$("#TENVTU_crud").val("");
	$("#DVTINH_crud").val("");
	$("#PHANTRAM_crud").val("");
}

function bind_crud()
{
	var id = jQuery("#DMVATTUGrid").jqGrid('getGridParam','selrow'); 
	if (id) {
		var ret = jQuery("#DMVATTUGrid").jqGrid('getRowData',id);
		$("#MAVTU_crud").val(ret.maVtu);
		$("#TENVTU_crud").val(ret.tenVtu);
		$("#DVTINH_crud").val(ret.dvTinh);
		$("#PHANTRAM_crud").val(ret.phanTram);
	}
}

$(function() {
	jQuery("#DMVATTUGrid").jqGrid({ 
		url:'listVatTu', 
		datatype: "json", 
		colNames : [ 'Mã Vật tư','Tên Vật tư','Đơn vị tính', 'Phần trăm'],
        colModel : [ {
                name : 'maVtu',
                index : 'maVtu',
                width : 150
        }, {
                name : 'tenVtu',
                index : 'tenVtu',
                width : 350,
                editable : false
        }, {
                name : 'dvTinh',
                index : 'dvTinh',
                width : 250,
                editable : false
        }, {
            name : 'phanTram',
            index : 'phanTram',
            width : 250,
            editable : false
    	}],
		rowNum:15,  rowList:[15,30,60,80,100], pager: '#Pager1', 
		scrollrows: true,
		autowidth: true,
		height: 300,
		width:650,
		shrinkToFit:false,
		caption: " Danh sách Vật tư",
		sortname: 'MAVTU', viewrecords: true, sortorder: "ASC",
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
			<tr>
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
			</tr>
			<tr>
				<td align=left><label for="PHANTRAM_crud">Phần trăm</label></td>
				<td align=left><input type="text" id="PHANTRAM_crud"
					name="PHANTRAM_crud" value=""
					class="text ui-widget-content ui-corner-all" maxlength="100"
					size="40" /></td>
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
<br />

<script type="text/javascript">
	$(document).ready(function() {
		$("#MAVTU_search").keypress(function(event) {
			if (event.which == 13) {
				reloadVATTUList();
			}
		});
		$("#TENVTU_search").keypress(function(event) {
			if (event.which == 13) {
				reloadVATTUList();
			}
		});
		$("#btnSearch").button().click(function() {
			reloadVATTUList();
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
			var id = jQuery("#DMVATTUGrid").jqGrid('getGridParam','selrow');
			if(id){
			bind_crud();
			$("#MAVTU_crud").prop("disabled", true);
			$("#MAVTU_crud").css("backgroundColor","yellow");
			$( "#dialog_form_crud" ).dialog({
				autoOpen: true,
	              height: 300,
	              width: 500,
	              modal: true,
	              close: function(){
	            	  $("#MAVTU_crud").prop("disabled", false);
	            	  $("#MAVTU_crud").css("backgroundColor","white");
	              },
	              buttons: { 
	                  Cancel: {
	                      class:'button',
	                  	  text:'Thoát', 
	                      click: function() {
	                          $( this ).dialog( "close" );
	                          $("#MAVTU_crud").prop("disabled", false);
	                          $("#MAVTU_crud").css("backgroundColor","white");
	                      }
	                  },
	                  Submit: {
	                	  class:'button',
	                  	  text:'Cập nhật', 
	                      click: function() {
	                    	  
	                    	  fncCapNhat();
	                    	  $("#MAVTU_crud").prop("disabled", false);
	                    	  $("#MAVTU_crud").css("backgroundColor","white");
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
		
		$("#btnReport").button().click(function() {
			
					
					
				   var PrintUrl='${pageContext.request.contextPath}/rptVattu?mavtu='+$("#MAVTU_search").val()+'&tenvtu='+$("#TENVTU_search").val();
				   var randomnumber = Math.floor((Math.random()*100)+1);
				   window.open(PrintUrl,"_blank",'PopUp',randomnumber,'scrollbars=1,menubar=0,resizable=1;dialogWidth:0px;dialogHeight:0px');
  
		});
		
		$( "#btnDelete" ).button().click(function() {
			var id1 = jQuery("#DMVATTUGrid").jqGrid('getGridParam','selrow');
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



</body>
</html>