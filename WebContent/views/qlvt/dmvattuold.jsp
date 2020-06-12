<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/views/common/common-libs.jsp" />
<title>DM VẬT TƯ</title>

<input type="hidden" id="buttonVisible" />
<div id="mainbody">
	<jsp:include page="/views/common/header.jsp" />
	<div id="ja-wrapper">
		<div id="ja-wrapper-top"></div>
		<!-- COPY HERE -->
		<div id="ja-wrapper-inner" class="clearfix">
			<h1>DANH MỤC VẬT TƯ</h1>
			<br />
			<div id="dialog-search" title="Tìm kiếm">
				<table width="100%">
					<tr>
						<td align=right><label for="MAVTU_search">Mã Vật tư</label></td>
						<td align=left><input type="text" id="MAVTU_search"
							name="MAVTU_search" value=""
							class="text ui-widget-content ui-corner-all"
							style="width: 300px;" /></td>
					</tr>
					<tr>
						<td align=right><label for="TENVTU_search">Tên Vật tư</label></td>
						<td align=left><input type="text" id="TENVTU_search"
							name="TENVTU_search" value=""
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
			<button id="btnReport" name="button" style="float: left;">Xuất báo báo</button>
			<br /> <br />
			<table id="DMVATTUGrid"></table>
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
	reloadVATTUList()
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
                width : 150,
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
		rowNum:10,  rowList:[15,30,60,80,100], pager: '#Pager1', 
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
					maxlength="8" onkeyup="checkSpecialChar('BRANCHCODE_crud')"
					onkeypress="checkSpecialChar('BRANCHCODE_crud')" /></td>
			</tr>
			<tr>
				<td align=left><label for="TENVTU_crud">Tên Vật tư</label></td>
				<td align=left><input type="text" id="TENVTU_crud"
					name="TENVTU_crud" value=""
					class="text ui-widget-content ui-corner-all" maxlength="60"
					size="40" onkeyup="checkSpecialChar('BRANCHNAME_crud')"
					onkeypress="checkSpecialChar('BRANCHNAME_crud')" /></td>
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
<br />

<script type="text/javascript">
	$(document).ready(function() {
		$("#BRANCHCODE_search").keypress(function(event) {
			if (event.which == 13) {
				reloadVATTUList();
			}
		});
		$("#BRANCHNAME_search").keypress(function(event) {
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
		
		$("#btnReport").button().click(function() {
			
					
					
				   var PrintUrl='${pageContext.request.contextPath}/rptVattu?mavtu='+$("#MAVTU_search").val()+'&tenvtu='+$("#TENVTU_search").val();
				   var randomnumber = Math.floor((Math.random()*100)+1);
				   window.open(PrintUrl,"_blank",'PopUp',randomnumber,'scrollbars=1,menubar=0,resizable=1;dialogWidth:0px;dialogHeight:0px');
  
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
