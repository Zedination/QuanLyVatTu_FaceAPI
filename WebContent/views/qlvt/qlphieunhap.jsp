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

    <title>Danh mục Phiếu Nhập</title>
    
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
			<h1 style="text-align: center;">DANH MỤC PHIẾU NHẬP</h1>
            <br />
            <br>
            <br>
			<div id="dialog-search" title="Tìm kiếm" style="margin-bottom: 50px;">
				<table width="100%">
					<tr>
                        <td align=right><label for="SOPN_search">Mã Phiếu Nhập &nbsp;</label></td>
                        
						<td align=left><input type="text" id="SOPN_search"
							name="SOPN_search" value=""
							class="text ui-widget-content ui-corner-all form-control"
							style="width: 300px;" /></td>
					</tr>
					<tr>
					<tr>
                        <td align=right><label for="SODH_search">Số Đơn Hàng &nbsp;</label></td>
                        
						<td align=left><input type="text" id="SODH_search"
							name="SODH_search" value=""
							class="text ui-widget-content ui-corner-all form-control"
							style="width: 300px;" /></td>
                    </tr>
					
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
			<button id="btnCreateCT" name="button" style="float: left;" class="btn btn-primary"><i class="far fa-plus-square"></i> Thêm mới CTDH</button>
			<button id="btnEditCT" name="button" style="float: left;" class="btn btn-primary"><i class="far fa-edit"></i> Sửa CTDH</button>
			<button id="btnDeleteCT" name="button" style="float: left;" class="btn btn-primary"><i class="far fa-trash-alt"></i> Xóa CTDH</button>
				</div>
				<br>
				<br>
			<br /> <br />
			<div class = "row">
				<div class = "col-md-5">
					<table id="PHIEUNHAPGrid" ></table>
					<div id="Pager1"></div>
			<!-- <div class = "button-div">
			
			</div> -->
				</div>
				
				<div class = "col-md-7">
					<table id="CTPNGrid"></table>
						<div id="Pager2"></div>
				</div>
			</div>
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
function fncThemMoiPN(){
	$.ajax({
	   type: "POST",
	   url: "createPNhap",
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
		   		showMessage("Thêm mới Phiếu Nhập thành công!");
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadPHIEUNHAPList();
	reloadCTPNList();
    hideLoadingIcon();
    $("#dialog_form_crud").dialog( "close" );
}

function fncThemMoiPNCT(){
	$.ajax({
	   type: "POST",
	   url: "createCTPN",
	   data: buildDataCTPNSubmit(),
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
		   		showMessage("Thêm mới Chi Tiết Phiếu Nhập thành công!");
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadPHIEUNHAPList();
	reloadCTPNList();
    hideLoadingIcon();
    $("#dialog_form_ct_crud").dialog( "close" );
}


function fncCapNhatDH(){
	$.ajax({
	   type: "POST",
	   url: "updatePNhap",
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
		   		showMessage("Cập nhật Phiếu Nhập thành công!");
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadPHIEUNHAPList();
    hideLoadingIcon();
    $("#dialog_form_crud").dialog( "close" );
}

function fncCapNhatCTDH(){
	$.ajax({
	   type: "POST",
	   url: "updateCTPN",
	   data: buildDataCTPNSubmit(),
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
		   		showMessage("Cập nhật Chi Tiết Phiếu Nhập thành công!");
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadPHIEUNHAPList();
	reloadCTPNList();
    hideLoadingIcon();
    $("#dialog_form_ct_crud").dialog( "close" );
}

function fncXoaBoDH(){
	$.ajax({
	   type: "POST",
	   url: "deletePNhap",
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
		   		showMessage("Xóa Phiếu Nhập thành công!");
		   		reloadPHIEUNHAPList();
		    } else {
		    	showMessage(obj.msg);
		    	reloadPHIEUNHAPList();
			};
	   }
    });
	reloadPHIEUNHAPList();
	reloadCTPNList();
    hideLoadingIcon();
 	/* $("#dialog_form_crud").dialog( "close" ); */
}

function fncXoaBoCTDH(){
	$.ajax({
	   type: "POST",
	   url: "deleteCTPN",
	   data: buildDataCTPNSubmit(),
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
		   		showMessage("Xóa Chi Tiết Phiếu Nhập thành công!");
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadPHIEUNHAPList();
	reloadCTPNList();
    hideLoadingIcon();
    $("#dialog_form_ct_crud").dialog( "close" );
}

function buildDataSubmit() {
	var data = new Object();
	data.soPN=$('#SOPN_crud').val();
	data.ngayNhap=$('#NGAYNHAP_crud').val();
	data.soDH=$('#SODH_crud').val();
	return data;
}

function buildDataCTPNSubmit() {
	var data = new Object();
	data.soPN=$('#SOPNCT_crud').val();
	data.maVTu=$('#MAVTU_crud').val();
	data.sLNhap=$('#SLNHAP_crud').val();
	data.dGNhap=$('#DGNHAP_crud').val();
	return data;
}
function getCondition(){
	var condition = new Object();
	condition.soPN=$('#SOPN_search').val();
	condition.soDH=$('#SODH_search').val();
	return condition;
}

function getSoDH(){
	var condition = new Object();
	var id = jQuery("#PHIEUNHAPGrid").jqGrid('getGridParam','selrow'); 
	if (id) {
		var ret = jQuery("#PHIEUNHAPGrid").jqGrid('getRowData',id);
		condition.soPN = ret.soPN;
	}
	return condition;
}

function reloadPHIEUNHAPList() {
	$('#PHIEUNHAPGrid').jqGrid("clearGridData", true);
    $('#PHIEUNHAPGrid').jqGrid('setGridParam',{
        postData:{}
    }).trigger("reloadGrid");
    $('#btnCreateCT').hide();
	$('#btnEditCT').hide();
	$('#btnDeleteCT').hide();
}

function reloadCTPNList() {
	$('#CTPNGrid').jqGrid("clearGridData", true);
    $('#CTPNGrid').jqGrid('setGridParam',{
        postData:{}
    }).trigger("reloadGrid");
}

function checkSpecialChar(control)
{
	var noiDung;
	var replaceND;
	
	if(control == "SOPN_crud") {
	    replaceND = $("#SOPN_crud").val();
	    noiDung = replaceND.trim();
	    var splChars = "~`!@#$%^&*?<>{}|[]";
		for (var i = 0; i < noiDung.length; i++) {
		    if (splChars.indexOf(noiDung.charAt(i)) != -1){
		    	replaceND = replaceND.replace(noiDung.charAt(i), "");
			}
		}
		$("#SOPN_crud").val(replaceND);
	}
	if(control == "SOPNCT_crud") {
	    replaceND = $("#SOPNCT_crud").val();
	    noiDung = replaceND.trim();
	    var splChars = "~`!@#$%^&*?<>{}|[]";
		for (var i = 0; i < noiDung.length; i++) {
		    if (splChars.indexOf(noiDung.charAt(i)) != -1){
		    	replaceND = replaceND.replace(noiDung.charAt(i), "");
			}
		}
		$("#SOPNCT_crud").val(replaceND);
	}
}

function clear_crud()
{
	$("#SOPN_crud").val("");
	$("#NGAYNHAP_crud").val("");
	$("#SODH_crud").val("");
}

function clear_crud_ct()
{
	$("#SOPNCT_crud").val("");
	$("#MAVTU_crud").val("");
	$("#SLNHAP_crud").val("");
	$('#DGNHAP_crud').val("");
}

function bind_crud()
{
	var id = jQuery("#PHIEUNHAPGrid").jqGrid('getGridParam','selrow'); 
	if (id) {
		var ret = jQuery("#PHIEUNHAPGrid").jqGrid('getRowData',id);
		$("#SOPN_crud").val(ret.soPN);
		$("#NGAYNHAP_crud").val(ret.ngayNhap);
		$("#SODH_crud").val(ret.soDH);
	}
}
function bind_crud_ct()
{
	var id = jQuery("#CTPNGrid").jqGrid('getGridParam','selrow'); 
	if (id) {
		var ret = jQuery("#CTPNGrid").jqGrid('getRowData',id);
		$("#SOPNCT_crud").val(ret.soPN);
		$("#MAVTU_crud").val(ret.maVTu);
		$("#SLNHAP_crud").val(ret.sLNhap);
		$("#DGNHAP_crud").val(ret.dGNhap);
	}
}

function bind_crud_ct_insert()
{
	var id = jQuery("#PHIEUNHAPGrid").jqGrid('getGridParam','selrow'); 
	if (id) {
		var ret = jQuery("#PHIEUNHAPGrid").jqGrid('getRowData',id);
		$("#SOPNCT_crud").val(ret.soPN);
	}
}

function showFormSuaCT() {
	bind_crud_ct();
	$( "#dialog_form_ct_crud" ).dialog({
          autoOpen: true,
          height: 300,
          width: 400,
          modal: true,
          tittle: "Sửa",
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
                  text:'Cập Nhật', 
                  click: function() {
                	  fncCapNhatCTDH();
                  }
              }
          }
      });
}

$(function() {
	jQuery("#PHIEUNHAPGrid").jqGrid({ 
		url:'listPhieuNhap', 
		datatype: "json", 
		colNames : [ 'Số phiếu nhập','Ngày nhập','Số đơn hàng'],
        colModel : [ {
                name : 'soPN',
                index : 'soPN',
                width : 150,
                align: 'center'
        }, {
                name : 'ngayNhap',
                index : 'ngayNhap',
                width : 200,
                editable : false,
                align: 'center'
        }, {
                name : 'soDH',
                index : 'soDH',
                width : 150,
                editable : false,
                align: 'center'
        }],
		rowNum:15,  rowList:[15,30,60,80,100], pager: '#Pager1', 
		scrollrows: true,
		autowidth: true,
		height: 300,
		width:650,
		shrinkToFit:false,
		caption: " Danh sách Phiếu Nhập",
		sortname: 'soPN', viewrecords: true, sortorder: "ASC",
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
        ondblClickRow: function(rowId) {
        	reloadCTPNList();
        	$('#btnCreateCT').show();
			$('#btnEditCT').show();
			$('#btnDeleteCT').show();
        },

	}).navGrid('#Pager1',{edit:false,add:false,del:false,search:false,refresh:true,view:false,position:"left",cloneToTop:true});
	})

$(function() {
	jQuery("#CTPNGrid").jqGrid({ 
		url:'listCTPN', 
		datatype: "json", 
		colNames : [ 'Số phiếu nhập','Mã vật tư','Số lượng nhập','Đơn giá nhập'],
        colModel : [ {
                name : 'soPN',
                index : 'soPN',
                width : 170,
                align: 'center'
        }, {
                name : 'maVTu',
                index : 'maVTu',
                width : 200,
                editable : false,
                align: 'center'
        }, {
                name : 'sLNhap',
                index : 'sLNhap',
                width : 150,
                editable : false,
                align: 'center'
        },
        	{
            	name : 'dGNhap',
            	index : 'dGNhap',
            	width : 150,
            	editable : false,
            	align: 'center'
    		}],
		rowNum:15,  rowList:[15,30,60,80,100], pager: '#Pager2', 
		scrollrows: true,
		autowidth: true,
		height: 300,
		width:650,
		shrinkToFit:false,
		caption: " Chi tiết Phiếu Nhập",
		sortname: 'soPN', viewrecords: true, sortorder: "ASC",
		serializeGridData: function (postData) {
        	var condition = getSoDH();
       		condition.rowPerPage = postData.rows;
            condition.currentPage = postData.page;
            condition.fromRow = (parseInt(postData.page) - 1) * postData.rows;
            condition.endRow = postData.rows * postData.page;
            condition.event= postData.event;
            condition.sidx= postData.sidx;
            condition.sord= postData.sord;
            return condition;
        },
        ondblClickRow: function(rowId) {
        	showFormSuaCT();
        },

	}).navGrid('#Pager2',{edit:false,add:false,del:false,search:false,refresh:true,view:false,position:"left",cloneToTop:true});
	})
</script>



<div id="dialog_form_crud" style="display: none;" title="CRUD">
	<form>
		<table width="100%">
			<tr>
				<td align=left><label for="SOPN_crud">Số Phiếu Nhập <font color="red">(*)</font>
				</label></td>
				<td><input type="text" id="SOPN_crud"
					name="SOPN_crud" value=""
					class="text ui-widget-content ui-corner-all" size="30"
					maxlength="8" onkeyup="checkSpecialChar('SOPN_crud')"
					onkeypress="checkSpecialChar('SOPN_crud')" /></td>
			</tr>
			<tr>
				<td align=left><label for="NGAYNHAP_crud">Ngày Nhập</label></td>
				<td align=left><input type="text" id="NGAYNHAP_crud"
					name="NGAYNHAP_crud" value=""
					class="text ui-widget-content ui-corner-all" maxlength="60"
					size="30" onkeyup="checkSpecialChar('NGAYNHAP_crud')"
					onkeypress="checkSpecialChar('NGAYNHAP_crud')" /></td>
			</tr>
			<tr>
				<td align=left><label for="SODH_crud">Số Đơn Hàng</label></td>
				<td align=left><input type="text" id="SODH_crud"
					name="SODH_crud" value=""
					class="text ui-widget-content ui-corner-all" maxlength="60"
					size="30" onkeyup="checkSpecialChar('SODH_crud')"
					onkeypress="checkSpecialChar('SODH_crud')" /></td>
			</tr>
		</table>
	</form>
</div>

<div id="dialog_form_ct_crud" style="display: none;" title="CRUD">
	<form>
		<table width="100%">
			<tr>
				<td align=left><label for="SOPNCT_crud">Số Phiếu Nhập <font color="red">(*)</font>
				</label></td>
				<td><input type="text" id="SOPNCT_crud"
					name="SOPNCT_crud" value=""
					class="text ui-widget-content ui-corner-all" size="30"
					maxlength="8" disabled style ="background-color: yellow;" /></td>
			</tr>
			<tr>
				<td align=left><label for="MAVTU_crud">Mã vật tư</label></td>
				<td align=left><select id="MAVTU_crud"></select></td>
			</tr>
			<tr>
				<td align=left><label for="SLNHAP_crud">Số Lượng Nhập</label></td>
				<td align=left><input type="text" id="SLNHAP_crud"
					name="SLNHAP_crud" value=""
					class="text ui-widget-content ui-corner-all" maxlength="60"
					size="30"/></td>
			</tr>
			<tr>
				<td align=left><label for="DGNHAP_crud">Đơn Giá Nhập</label></td>
				<td align=left><input type="text" id="DGNHAP_crud"
					name="DGNHAP_crud" value=""
					class="text ui-widget-content ui-corner-all" maxlength="60"
					size="30"/></td>
			</tr>
		</table>
	</form>
</div>
<br />
<div id="dialog_info" style="display: none" title="Thông báo">
Hãy chọn một bản ghi
</div>
<div id="dialog_confirm_delete" style="display: none" title="Thông báo">
Bạn có chắc muốn xóa không?
</div>
<br />

<script type="text/javascript">
	$('#btnCreateCT').hide();
	$('#btnEditCT').hide();
	$('#btnDeleteCT').hide();
	$(document).ready(function() {
		$("#NGAYNHAP_crud").datepicker({ 
			dateFormat: "dd/mm/yy", 
			dayNames: ['Thứ hai', 'Thứ ba', 'Thứ tư', 'Thứ năm', 'Thứ sáu', 'Thứ bảy', 'Chủ nhật'], 
			dayNamesMin: ['CN','T2','T3','T4','T5','T6','T7'], 
			dayNamesShort: ['CN','Th2','Th3','Th4','Th5','Th6','Th7'], 
			monthNames: ['Tháng 1','Tháng 2','Tháng 3','Tháng 4', 'Tháng 5','Tháng 6','Tháng 7','Tháng 8', 'Tháng 9','Tháng 10','Tháng 11','Tháng 12'], 
			yearSuffix: '' 
		});
		
		$("#SODH_search").keypress(function(event) {
			if (event.which == 13) {
				reloadPHIEUNHAPList();
			}
		});
		$("#SOPN_search").keypress(function(event) {
			if (event.which == 13) {
				reloadPHIEUNHAPList();
			}
		});
		$("#btnSearch").button().click(function() {
			reloadPHIEUNHAPList();
		}); 
		
		<%-- $.ajax({ 
			type: "GET", 
			url: '<%=request.getContextPath() %>/getListMaNCC',
			dataType: "xml", 
			success: function(xml) { 
				var SODH_crud = $('#SODH_crud'); 
				SODH_crud.find('option').remove().end(); 
				SODH_crud.append('<option value="" selected="true">-Chọn một dòng-</option>'); 
				$(xml).find('option').each(
				function() {
					var text = $(this).find('text').text();
					var value = $(this).find('value').text();
					SODH_crud.append("<option value='"+ value +"'>"+ text+ "</option>");
				});
			}
		}); --%>
		
		$.ajax({ 
			type: "GET", 
			url: '<%=request.getContextPath() %>/getListMavtu',
			dataType: "xml", 
			success: function(xml) { 
				var MAVTU_crud = $('#MAVTU_crud'); 
				MAVTU_crud.find('option').remove().end(); 
				MAVTU_crud.append('<option value="" selected="true">-Chọn một dòng-</option>'); 
				$(xml).find('option').each(
				function() {
					var text = $(this).find('text').text();
					var value = $(this).find('value').text();
					MAVTU_crud.append("<option value='"+ value +"'>"+ text+ "</option>");
				});
			}
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
	                    	  fncThemMoiPN();
	                      }
	                  }
	              }
	          });
		});
		
		$( "#btnEdit" ).button().click(function() {
			var id = jQuery("#PHIEUNHAPGrid").jqGrid('getGridParam','selrow');
			if(id){
				bind_crud();
				$("#SOPN_crud").prop("disabled", true);
				$("#SOPN_crud").css("backgroundColor","yellow");
				$( "#dialog_form_crud" ).dialog({
					autoOpen: true,
		              height: 300,
		              width: 500,
		              modal: true,
		              close: function(){
		            	  $("#SOPN_crud").prop("disabled", false);
		  				  $("#SOPN_crud").css("backgroundColor","white");
		              },
		              buttons: { 
		                  Cancel: {
		                      class:'button',
		                  	  text:'Thoát', 
		                      click: function() {
		                          $( this ).dialog( "close" );
		                          $("#SOPN_crud").prop("disabled", false);
				  				  $("#SOPN_crud").css("backgroundColor","white");
		                      }
		                  },
		                  Submit: {
		                	  class:'button',
		                  	  text:'Cập nhật', 
		                      click: function() {
		                    	  fncCapNhatDH();
		                    	  $("#SOPN_crud").prop("disabled", false);
				  				  $("#SOPN_crud").css("backgroundColor","white");
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
		
		$( "#btnDelete" ).button().click(function() {
			var id = jQuery("#PHIEUNHAPGrid").jqGrid('getGridParam','selrow');
			if(id){
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
		                    	  fncXoaBoDH();
		                    	  $(this).dialog( "close" );
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
		
		$( "#btnDetail" ).button().click(function() {
			reloadCTPNList();
			$('#btnCreateCT').show();
			$('#btnEditCT').show();
			$('#btnDeleteCT').show();
		});
		
		$( "#btnCreateCT" ).button().click(function() {
			clear_crud_ct();
			bind_crud_ct_insert();
			$( "#dialog_form_ct_crud" ).dialog({
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
	                    	  fncThemMoiPNCT();
	                      }
	                  }
	              }
	          });
		});
		
		$( "#btnEditCT" ).button().click(function() {
			var id = jQuery("#CTPNGrid").jqGrid('getGridParam','selrow');
			if(id){
				bind_crud_ct();
				$("#MAVTU_crud").prop("disabled", true);
				$("#MAVTU_crud").css("backgroundColor","yellow");
				$( "#dialog_form_ct_crud" ).dialog({
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
		                    	  fncCapNhatCTDH();
		                    	  $("#MAVTU_crud").prop("disabled", false);
				      			  $("#MAVTU_crud").css("backgroundColor","white");
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
		$( "#btnDeleteCT" ).button().click(function() {
			var id = jQuery("#CTPNGrid").jqGrid('getGridParam','selrow');
			if(id){
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
		                    	  fncXoaBoCTDH();
		                    	  $(this).dialog( "close" );
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