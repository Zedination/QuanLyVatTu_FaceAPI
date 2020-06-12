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
    <%-- <script type="text/ecmascript" src="<c:url value="resources/jqgrid/js/jquery.min.js"/>"></script> --%>
    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
    <script
  src="https://code.jquery.com/jquery-1.12.1.js"
  integrity="sha256-VuhDpmsr9xiKwvTIHfYWCIQ84US9WqZsLfR4P7qF6O8="
  crossorigin="anonymous"></script>
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
	
    <title>Danh mục đơn hàng</title>
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
			<h1 style="text-align: center;">DANH MỤC ĐƠN HÀNG</h1>
            <br />
            <br>
            <br>
			<div id="dialog-search" title="Tìm kiếm" style="margin-bottom: 50px;">
				<table width="100%">
					<tr>
                        <td align=right><label for="SODH_search">Mã Đơn Hàng &nbsp;</label></td>
                        
						<td align=left><input type="text" id="SODH_search"
							name="SODH_search" value=""
							class="text ui-widget-content ui-corner-all form-control"
							style="width: 300px;" /></td>
					</tr>
					<tr>
					<tr>
                        <td align=right><label for="MANHACC_search">Mã Nhà Cung Cấp &nbsp;</label></td>
                        
						<td align=left><input type="text" id="MANHACC_search"
							name="MANHACC_search" value=""
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
				<div class = "col-md-6">
					<table id="QLDONHANGGrid" ></table>
					<div id="Pager1"></div>
			<!-- <div class = "button-div">
			
			</div> -->
				</div>
				
				<div class = "col-md-6">
					<table id="CTDONHANGGrid"></table>
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
function fncThemMoiDH(){
	$.ajax({
	   type: "POST",
	   url: "createDONDH",
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
		   		showMessage("Thêm mới Đơn hàng thành công!");
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadDONHANGList();
	reloadCTDONHANGList();
    hideLoadingIcon();
    $("#dialog_form_crud").dialog( "close" );
}

function fncThemMoiDHCT(){
	$.ajax({
	   type: "POST",
	   url: "createCTDONDH",
	   data: buildDataCTDHSubmit(),
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
		   		showMessage("Thêm mới Chi Tiết Đơn hàng thành công!");
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadDONHANGList();
	reloadCTDONHANGList();
    hideLoadingIcon();
    $("#dialog_form_ct_crud").dialog( "close" );
}


function fncCapNhatDH(){
	$.ajax({
	   type: "POST",
	   url: "updateDONDH",
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
		   		showMessage("Cập nhật Đơn Hàng thành công!");
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadDONHANGList();
    hideLoadingIcon();
    $("#dialog_form_crud").dialog( "close" );
}

function fncCapNhatCTDH(){
	$.ajax({
	   type: "POST",
	   url: "updateCTDONDH",
	   data: buildDataCTDHSubmit(),
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
		   		showMessage("Cập nhật Chi Tiết Đơn Hàng thành công!");
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadDONHANGList();
	reloadCTDONHANGList();
    hideLoadingIcon();
    $("#dialog_form_ct_crud").dialog( "close" );
}

function fncXoaBoDH(){
	$.ajax({
	   type: "POST",
	   url: "deleteDONDH",
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
		   		showMessage("Xóa Đơn Hàng thành công!");
		   		reloadDONHANGList();
		    } else {
		    	showMessage(obj.msg);
		    	reloadDONHANGList();
			};
	   }
    });
	reloadDONHANGList();
    hideLoadingIcon();
 	/* $("#dialog_form_crud").dialog( "close" ); */
}

function fncXoaBoCTDH(){
	$.ajax({
	   type: "POST",
	   url: "deleteCTDONDH",
	   data: buildDataCTDHSubmit(),
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
		   		showMessage("Xóa Chi Tiết Đơn Hàng thành công!");
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadDONHANGList();
	reloadCTDONHANGList();
    hideLoadingIcon();
    $("#dialog_form_ct_crud").dialog( "close" );
}

function buildDataSubmit() {
	var data = new Object();
	data.soDH=$('#SODH_crud').val();
	data.ngaydh=$('#NGAYDH_crud').val();
	data.mancc=$('#MANCC_crud').val();
	return data;
}

function buildDataCTDHSubmit() {
	var data = new Object();
	data.soDH=$('#SODHCT_crud').val();
	data.mavtu=$('#MAVTU_crud').val();
	data.sldat=$('#SLDAT_crud').val();
	return data;
}
function getCondition(){
	var condition = new Object();
	condition.soDH=$('#SODH_search').val();
	condition.mancc=$('#MANHACC_search').val();
	return condition;
}

function getSoDH(){
	var condition = new Object();
	var id = jQuery("#QLDONHANGGrid").jqGrid('getGridParam','selrow'); 
	if (id) {
		var ret = jQuery("#QLDONHANGGrid").jqGrid('getRowData',id);
		condition.soDH = ret.soDH;
	}
	return condition;
}

function reloadDONHANGList() {
	$('#QLDONHANGGrid').jqGrid("clearGridData", true);
    $('#QLDONHANGGrid').jqGrid('setGridParam',{
        postData:{}
    }).trigger("reloadGrid");
    $('#btnCreateCT').hide();
	$('#btnEditCT').hide();
	$('#btnDeleteCT').hide();
}

function reloadCTDONHANGList() {
	$('#CTDONHANGGrid').jqGrid("clearGridData", true);
    $('#CTDONHANGGrid').jqGrid('setGridParam',{
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
	$("#SODH_crud").val("");
	$("#NGAYDH_crud").val("");
	$("#MANCC_crud").val("");
}

function clear_crud_ct()
{
	$("#SODHCT_crud").val("");
	$("#MAVTU_crud").val("");
	$("#SLDAT_crud").val("");
}

function bind_crud()
{
	var id = jQuery("#QLDONHANGGrid").jqGrid('getGridParam','selrow'); 
	if (id) {
		var ret = jQuery("#QLDONHANGGrid").jqGrid('getRowData',id);
		$("#SODH_crud").val(ret.soDH);
		$("#NGAYDH_crud").val(ret.ngaydh);
		$("#MANCC_crud").val(ret.mancc);
	}
}
function bind_crud_ct()
{
	var id = jQuery("#CTDONHANGGrid").jqGrid('getGridParam','selrow'); 
	if (id) {
		var ret = jQuery("#CTDONHANGGrid").jqGrid('getRowData',id);
		$("#SODHCT_crud").val(ret.soDH);
		$("#MAVTU_crud").val(ret.mavtu);
		$("#SLDAT_crud").val(ret.sldat);
	}
}

function bind_crud_ct_insert()
{
	var id = jQuery("#QLDONHANGGrid").jqGrid('getGridParam','selrow'); 
	if (id) {
		var ret = jQuery("#QLDONHANGGrid").jqGrid('getRowData',id);
		$("#SODHCT_crud").val(ret.soDH);
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
	jQuery("#QLDONHANGGrid").jqGrid({ 
		url:'listDonHang', 
		datatype: "json", 
		colNames : [ 'Số Đơn hàng','Ngày đặt hàng','Mã nhà cung cấp'],
        colModel : [ {
                name : 'soDH',
                index : 'soDH',
                width : 150,
                align: 'center'
        }, {
                name : 'ngaydh',
                index : 'ngaydh',
                width : 250,
                editable : false,
                align: 'center'
        }, {
                name : 'mancc',
                index : 'mancc',
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
		caption: " Danh sách Đơn hàng",
		sortname: 'soDH', viewrecords: true, sortorder: "ASC",
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
        	reloadCTDONHANGList();
        	$('#btnCreateCT').show();
			$('#btnEditCT').show();
			$('#btnDeleteCT').show();
        },

	}).navGrid('#Pager1',{edit:false,add:false,del:false,search:false,refresh:true,view:false,position:"left",cloneToTop:true});
	})

$(function() {
	jQuery("#CTDONHANGGrid").jqGrid({ 
		url:'listCTDH', 
		datatype: "json", 
		colNames : [ 'Số Đơn hàng','Mã vật tư','Số lượng đặt'],
        colModel : [ {
                name : 'soDH',
                index : 'soDH',
                width : 170,
                align: 'center'
        }, {
                name : 'mavtu',
                index : 'mavtu',
                width : 200,
                editable : false,
                align: 'center'
        }, {
                name : 'sldat',
                index : 'sldat',
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
		caption: " Chi tiết Đơn hàng",
		sortname: 'soDH', viewrecords: true, sortorder: "ASC",
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
				<td align=left><label for="SODH_crud">Số đơn hàng <font color="red">(*)</font>
				</label></td>
				<td><input type="text" id="SODH_crud"
					name="SODH_crud" value=""
					class="text ui-widget-content ui-corner-all" size="30"
					maxlength="8" onkeyup="checkSpecialChar('SODH_crud')"
					onkeypress="checkSpecialChar('SODH_crud')" /></td>
			</tr>
			<tr>
				<td align=left><label for="NGAYDH_crud">Ngày đơn hàng</label></td>
				<td align=left><input type="text" id="NGAYDH_crud"
					name="NGAYDH_crud" value=""
					class="text ui-widget-content ui-corner-all" maxlength="60"
					size="30" onkeyup="checkSpecialChar('NGAYDH_crud')"
					onkeypress="checkSpecialChar('NGAYDH_crud')" /></td>
			</tr>
			<tr>
				<td align=left><label for="MANCC_crud">Mã nhà CC</label></td>
				<td align=left><select id="MANCC_crud">
				</select></td>
			</tr>
		</table>
	</form>
</div>

<div id="dialog_form_ct_crud" style="display: none;" title="CRUD">
	<form>
		<table width="100%">
			<tr>
				<td align=left><label for="SODHCT_crud">Số đơn hàng <font color="red">(*)</font>
				</label></td>
				<td><input type="text" id="SODHCT_crud"
					name="SODHCT_crud" value=""
					class="text ui-widget-content ui-corner-all" size="30"
					maxlength="8" disabled style ="background-color: yellow;" /></td>
			</tr>
			<tr>
				<td align=left><label for="MAVTU_crud">Mã vật tư</label></td>
				<td align=left><select id="MAVTU_crud"></select></td>
			</tr>
			<tr>
				<td align=left><label for="SLDAT_crud">Số lượng đặt</label></td>
				<td align=left><input type="text" id="SLDAT_crud"
					name="SLDAT_crud" value=""
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
		$("#NGAYDH_crud").datepicker({ 
			dateFormat: "dd/mm/yy", 
			dayNames: ['Thứ hai', 'Thứ ba', 'Thứ tư', 'Thứ năm', 'Thứ sáu', 'Thứ bảy', 'Chủ nhật'], 
			dayNamesMin: ['CN','T2','T3','T4','T5','T6','T7'], 
			dayNamesShort: ['CN','Th2','Th3','Th4','Th5','Th6','Th7'], 
			monthNames: ['Tháng 1','Tháng 2','Tháng 3','Tháng 4', 'Tháng 5','Tháng 6','Tháng 7','Tháng 8', 'Tháng 9','Tháng 10','Tháng 11','Tháng 12'], 
			yearSuffix: '' 
		});
		
		$("#MANHACC_search").keypress(function(event) {
			if (event.which == 13) {
				reloadDONHANGList();
			}
		});
		$("#SODH_search").keypress(function(event) {
			if (event.which == 13) {
				reloadDONHANGList();
			}
		});
		$("#btnSearch").button().click(function() {
			reloadDONHANGList();
		}); 
		
		$.ajax({ 
			type: "GET", 
			url: '<%=request.getContextPath() %>/getListMaNCC',
			dataType: "xml", 
			success: function(xml) { 
				var MANCC_crud = $('#MANCC_crud'); 
				MANCC_crud.find('option').remove().end(); 
				MANCC_crud.append('<option value="" selected="true">-Chọn một dòng-</option>'); 
				$(xml).find('option').each(
				function() {
					var text = $(this).find('text').text();
					var value = $(this).find('value').text();
					MANCC_crud.append("<option value='"+ value +"'>"+ text+ "</option>");
				});
			}
		});
		
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
	                    	  fncThemMoiDH();
	                      }
	                  }
	              }
	          });
		});
		
		$( "#btnEdit" ).button().click(function() {
			var id = jQuery("#QLDONHANGGrid").jqGrid('getGridParam','selrow');
			if(id){
				bind_crud();
				$("#SODH_crud").prop("disabled", true);
				$("#SODH_crud").css("backgroundColor","yellow");
				$( "#dialog_form_crud" ).dialog({
					autoOpen: true,
		              height: 300,
		              width: 500,
		              modal: true,
		              close: function(){
		            	  $("#SODH_crud").prop("disabled", false);
		  				  $("#SODH_crud").css("backgroundColor","white");
		              },
		              buttons: { 
		                  Cancel: {
		                      class:'button',
		                  	  text:'Thoát', 
		                      click: function() {
		                          $( this ).dialog( "close" );
		                          $("#SODH_crud").prop("disabled", false);
				  				  $("#SODH_crud").css("backgroundColor","white");
		                      }
		                  },
		                  Submit: {
		                	  class:'button',
		                  	  text:'Cập nhật', 
		                      click: function() {
		                    	  fncCapNhatDH();
		                    	  $("#SODH_crud").prop("disabled", false);
				  				  $("#SODH_crud").css("backgroundColor","white");
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
			var id = jQuery("#QLDONHANGGrid").jqGrid('getGridParam','selrow');
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
		
		$( "#btnDetail" ).button().click(function() {
			reloadCTDONHANGList();
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
	                    	  fncThemMoiDHCT();
	                      }
	                  }
	              }
	          });
		});
		
		$( "#btnEditCT" ).button().click(function() {
			var id = jQuery("#CTDONHANGGrid").jqGrid('getGridParam','selrow');
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
			var id = jQuery("#CTDONHANGGrid").jqGrid('getGridParam','selrow');
			if(id){
				bind_crud_ct();
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