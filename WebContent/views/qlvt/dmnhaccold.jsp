<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/views/common/common-libs.jsp" />
<title>DANH MUC NHA CUNG CAP</title>

<input type="hidden" id="buttonVisible" />
<div id="mainbody">
	<jsp:include page="/views/common/header.jsp" />
	<div id="ja-wrapper">
		<div id="ja-wrapper-top"></div>
		<!-- COPY HERE -->
		<div id="ja-wrapper-inner" class="clearfix">
			<h1>DANH MỤC NHA CUNG CAP</h1>
			<br />
			<div id="dialog-search" title="Tìm kiếm">
				<table width="100%">
					<tr>
						<td align=right><label for="MANCC_search">Mã nhà cung cấp</label></td>
						<td align=left><input type="text" id="MANCC_search"
							name="MANCC_search" value=""
							class="text ui-widget-content ui-corner-all"
							style="width: 300px;" /></td>
					</tr>
					<tr>
						<td align=right><label for="TENNCC_search">Tên nhà cung cấp</label></td>
						<td align=left><input type="text" id="TENNCC_search"
							name="TENNCC_search" value=""
							class="text ui-widget-content ui-corner-all"
							style="width: 300px;" /></td>
					</tr>
					<tr>
						<td></td>
						<td align=left></td>
					</tr>
				</table>
			</div>
			<button id="btnSearch" style="float: left;" >Tìm kiếm</button>
			<button id="btnCreate" name="button" style="float: left;">Thêm mới</button>
			<button id="btnEdit" name="button" style="float: left;">Sửa</button>
			<button id="btnDelete" name="button" style="float: left;">Xóa</button>
			<br /> <br />
			<table id="DMNCCGrid"></table>
			<div id="Pager1"></div>
			<br />

		</div>
		<jsp:include page="/views/common/footer.jsp" />
	</div>
</div>

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
		   		showMessage("Thêm mới Vật tư thành công!");
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
		   		showMessage("Cập nhật Vật tư thành công!");
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
		   		showMessage("Cập nhật Vật tư thành công!");
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadVATTUList()
    hideLoadingIcon();
    $("#dialog_form_crud").dialog( "close" );
}

function buildDataSubmit() {
	var data = new Object();
	data.maNhacc=$('#MANCC_crud').val();
	data.tenNhacc=$('#TENNCC_crud').val();
	data.diaChi=$('#DIACHI_crud').val();
	data.dienThoai=$('#DIENTHOAI_crud').val();
	return data;
}

function getCondition(){
	var condition = new Object();
	condition.maNhacc=$('#MANCC_search').val();
	condition.tenNhacc=$('#TENNCC_search').val();
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
		$("#MANCC_crud").val(ret.maNhacc);
		$("#TENNCC_crud").val(ret.tenNhacc);
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
                name : 'maNhacc',
                index : 'maNhacc',
                width : 150
        }, {
                name : 'tenNhacc',
                index : 'tenNhacc',
                width : 150,
                editable : false
        }, {
                name : 'diaChi',
                index : 'diaChi',
                width : 250,
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
		sortname: 'MANCC', viewrecords: true, sortorder: "ASC",
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
	              width: 400,
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
			bind_crud();
			$( "#dialog_form_crud" ).dialog({
				autoOpen: true,
	              height: 300,
	              width: 400,
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
	                  	  text:'Cập nhật', 
	                      click: function() {
	                    	  
	                    	  fncCapNhat();
	                      }
	                  }
	              }
	          });
		});
		
		$( "#btnDelete" ).button().click(function() {
			bind_crud();
			$( "#dialog_form_crud" ).dialog({
				autoOpen: true,
	              height: 300,
	              width: 400,
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
	                          showConfirm("Bạn có chắc chắn muốn Xóa bỏ?", "fncXoaBo");
	                      }
	                  }
	              }
	          });
		});
	});
	
</script>
