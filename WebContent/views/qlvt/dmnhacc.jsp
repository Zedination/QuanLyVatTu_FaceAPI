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
	
    <title>Danh mục nhà cung cấp</title>
    
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
			<h1 style="text-align: center;">DANH MỤC NHÀ CUNG CẤP</h1>
            <br />
            <br>
            <br>
			<div id="dialog-search" title="Tìm kiếm" style="margin-bottom: 50px;">
				<table width="100%">
					<tr>
                        <td align=right><label for="MANCC_search">Mã Nhà Cung Cấp &nbsp;</label></td>
                        
						<td align=left><input type="text" id="MANCC_search"
							name="MANCC_search" value=""
							class="text ui-widget-content ui-corner-all form-control"
							style="width: 300px;" /></td>
                    </tr>
					<tr>
                        <td align=right><label for="TENNCC_search">Tên Nhà Cung Cấp &nbsp;</label></td>
                        
						<td align=left><input type="text" id="TENNCC_search"
							name="TENNCC_search" value=""
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
			<table id="DMNCCGrid" ></table>
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
	   url: "createNHACC",
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
		   		showMessage("Thêm mới danh mục Nhà Cung Cấp thành công!");
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadVATTUList()
    hideLoadingIcon();
    $("#dialog_form_crud").dialog( "close" );
}

function fncCapNhat(){
	$.ajax({
	   type: "POST",
	   url: "updateNHACC",
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
		   		showMessage("Cập nhật danh mục Nhà Cung Cấp thành công!");
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadVATTUList()
    hideLoadingIcon();
    $("#dialog_form_crud").dialog( "close" );
}

function fncXoaBo(){
	$.ajax({
	   type: "POST",
	   url: "deleteNHACC",
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
		   		showMessage("Xóa Nhà Cung Cấp thành công!");
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadVATTUList()
    hideLoadingIcon();
    /* $("#dialog_form_crud").dialog( "close" ); */
}

function buildDataSubmit() {
	var data = new Object();
	data.maNCC=$('#MANCC_crud').val();
	data.tenNCC=$('#TENNCC_crud').val();
	data.diaChi=$('#DIACHI_crud').val();
	data.dienThoai=$('#DIENTHOAI_crud').val();
	return data;
}

function getCondition(){
	var condition = new Object();
	condition.maNCC=$('#MANCC_search').val();
	condition.tenNCC=$('#TENNCC_search').val();
	return condition;
}

function reloadVATTUList() {
	$('#DMNCCGrid').jqGrid("clearGridData", true);
    $('#DMNCCGrid').jqGrid('setGridParam',{
        postData:{}
    }).trigger("reloadGrid");
}

function checkSpecialChar(control)
{
	var noiDung;
	var replaceND;
	
	if(control == "MANCC_crud") {
	    replaceND = $("#MANCC_crud").val();
	    noiDung = replaceND.trim();
	    var splChars = "~`!@#$%^&*?<>{}|[]";
		for (var i = 0; i < noiDung.length; i++) {
		    if (splChars.indexOf(noiDung.charAt(i)) != -1){
		    	replaceND = replaceND.replace(noiDung.charAt(i), "");
			}
		}
		$("#MANCC_crud").val(replaceND);
	}
	if(control == "TENNCC_crud") {
	    replaceND = $("#TENNCC_crud").val();
	    noiDung = replaceND.trim();
	    var splChars = "~`!@#$%^&*?<>{}|[]";
		for (var i = 0; i < noiDung.length; i++) {
		    if (splChars.indexOf(noiDung.charAt(i)) != -1){
		    	replaceND = replaceND.replace(noiDung.charAt(i), "");
			}
		}
		$("#TENNCC_crud").val(replaceND);
	}
}

function clear_crud()
{
	$("#MANCC_crud").val("");
	$("#TENNCC_crud").val("");
	$("#DIACHI_crud").val("");
	$("#DIENTHOAI_crud").val("");
}

function bind_crud()
{
	var id = jQuery("#DMNCCGrid").jqGrid('getGridParam','selrow'); 
	if (id) {
		var ret = jQuery("#DMNCCGrid").jqGrid('getRowData',id);
		$("#MANCC_crud").val(ret.maNCC);
		$("#TENNCC_crud").val(ret.tenNCC);
		$("#DIACHI_crud").val(ret.diaChi);
		$("#DIENTHOAI_crud").val(ret.dienThoai);
	}
}

$(function() {
	jQuery("#DMNCCGrid").jqGrid({ 
		url:'listNhacc', 
		datatype: "json", 
		colNames : [ 'Mã nhà cung cấp','Tên nhà cung cấp','Địa chỉ', 'Điện thoại'],
        colModel : [ {
                name : 'maNCC',
                index : 'maNCC',
                width : 150
        }, {
                name : 'tenNCC',
                index : 'tenNCC',
                width : 250,
                editable : false
        }, {
                name : 'diaChi',
                index : 'diaChi',
                width : 350,
                editable : false
        }, {
            name : 'dienThoai',
            index : 'dienThoai',
            width : 250,
            editable : false
    	}],
		rowNum:15,  rowList:[15,30,60,80,100], pager: '#Pager1', 
		scrollrows: true,
		autowidth: true,
		height: 300,
		width:650,
		shrinkToFit:false,
		caption: " Danh sách NCC",
		sortname: 'maNCC', viewrecords: true, sortorder: "ASC",
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
				<td align=left><label for="MANCC_crud">Mã nhà cung cấp <font color="red">(*)</font>
				</label></td>
				<td><input type="text" id="MANCC_crud"
					name="MANCC_crud" value=""
					class="text ui-widget-content ui-corner-all" size="20"
					maxlength="8" onkeyup="checkSpecialChar('MANCC_crud')"
					onkeypress="checkSpecialChar('MANCC_crud')" /></td>
			</tr>
			<tr>
				<td align=left><label for="TENNCC_crud">Tên nhà cung cấp</label></td>
				<td align=left><input type="text" id="TENNCC_crud"
					name="TENNCC_crud" value=""
					class="text ui-widget-content ui-corner-all" maxlength="60"
					size="40" onkeyup="checkSpecialChar('TENNCC_crud')"
					onkeypress="checkSpecialChar('TENNCC_crud')" /></td>
			</tr>
			<tr>
				<td align=left><label for="DIACHI_crud">Địa chỉ</label></td>
				<td align=left><input type="text" id="DIACHI_crud"
					name="DIACHI_crud" value=""
					class="text ui-widget-content ui-corner-all" maxlength="100"
					size="40" /></td>
			</tr>
			<tr>
				<td align=left><label for="DIENTHOAI_crud">Điện thoại</label></td>
				<td align=left><input type="text" id="DIENTHOAI_crud"
					name="DIENTHOAI_crud" value=""
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
		$("#MANCC_search").keypress(function(event) {
			if (event.which == 13) {
				reloadVATTUList();
			}
		});
		$("#TENNCC_search").keypress(function(event) {
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
			var id = jQuery("#DMNCCGrid").jqGrid('getGridParam','selrow');
			if(id){
			bind_crud();
			$("#MANCC_crud").prop("disabled", true);
			$("#MANCC_crud").css("backgroundColor","yellow");
			$( "#dialog_form_crud" ).dialog({
				autoOpen: true,
	              height: 300,
	              width: 500,
	              modal: true,
	              close: function(){
	            	$("#MANCC_crud").prop("disabled", false);
	      			$("#MANCC_crud").css("backgroundColor","white");
	              },
	              buttons: { 
	                  Cancel: {
	                      class:'button',
	                  	  text:'Thoát', 
	                      click: function() {
	                          $( this ).dialog( "close" );
	                          $("#MANCC_crud").prop("disabled", false);
	      	      			  $("#MANCC_crud").css("backgroundColor","white");
	                      }
	                  },
	                  Submit: {
	                	  class:'button',
	                  	  text:'Cập nhật', 
	                      click: function() {
	                    	  $("#MANCC_crud").prop("disabled", false);
	      	      			  $("#MANCC_crud").css("backgroundColor","white");
	                    	  fncCapNhat();
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
			
					
					
				   var PrintUrl='${pageContext.request.contextPath}/rptVattu?mavtu='+$("#MANCC_search").val()+'&tenvtu='+$("#TENNCC_search").val();
				   var randomnumber = Math.floor((Math.random()*100)+1);
				   window.open(PrintUrl,"_blank",'PopUp',randomnumber,'scrollbars=1,menubar=0,resizable=1;dialogWidth:0px;dialogHeight:0px');
  
		});
		
		$( "#btnDelete" ).button().click(function() {
			var id1 = jQuery("#DMNCCGrid").jqGrid('getGridParam','selrow');
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