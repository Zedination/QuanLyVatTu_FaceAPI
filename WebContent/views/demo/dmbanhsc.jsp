<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/views/common/common-libs.jsp" />
<title>Tham Số Chi Nhánh</title>

<input type="hidden" id="buttonVisible" />
<div id="mainbody">
	<jsp:include page="/views/common/header.jsp" />
	<div id="ja-wrapper">
		<div id="ja-wrapper-top"></div>
		<!-- COPY HERE -->
		<div id="ja-wrapper-inner" class="clearfix">
			<h1>DANH MỤC CHI NHÁNH</h1>
			<br />
			<div id="dialog-search" title="Tìm kiếm">
				<table width="100%">
					<tr>
						<td align=right><label for="BRANCHCODE_search">Mã Chi nhánh</label></td>
						<td align=left><input type="text" id="BRANCHCODE_search"
							name="BRANCHCODE_search" value=""
							class="text ui-widget-content ui-corner-all"
							style="width: 300px;" /></td>
					</tr>
					<tr>
						<td align=right><label for="BRANCHNAME_search">Tên Chi nhánh</label></td>
						<td align=left><input type="text" id="BRANCHNAME_search"
							name="BRANCHNAME_search" value=""
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
			<table id="DMBANHSCGrid"></table>
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
	   url: "createBranch",
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
		   		showMessage("Thêm mới Chi nhánh thành công!");
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadDMBANHSCList()
    hideLoadingIcon();
    $("#dialog_form_crud").dialog( "close" );
}

function fncCapNhat(){
	$.ajax({
	   type: "POST",
	   url: "updateBranch",
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
		   		showMessage("Cập nhật Chi nhánh thành công!");
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadDMBANHSCList()
    hideLoadingIcon();
    $("#dialog_form_crud").dialog( "close" );
}

function fncXoaBo(){
	$.ajax({
	   type: "POST",
	   url: "deleteBranch",
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
		   		showMessage("Cập nhật Chi nhánh thành công!");
		    } else {
		    	showMessage(obj.msg);
			};
	   }
    });
	reloadDMBANHSCList()
    hideLoadingIcon();
    $("#dialog_form_crud").dialog( "close" );
}

function buildDataSubmit() {
	var data = new Object();
	data.branchcode=$('#BRANCHCODE_crud').val();
	data.branchname=$('#BRANCHNAME_crud').val();
	data.location=$('#LOCATION_crud').val();
	return data;
}

function getCondition(){
	var condition = new Object();
	condition.branchcode=$('#BRANCHCODE_search').val();
	condition.branchname=$('#BRANCHNAME_search').val();
	return condition;
}

function reloadDMBANHSCList() {
	$('#DMBANHSCGrid').jqGrid("clearGridData", true);
    $('#DMBANHSCGrid').jqGrid('setGridParam',{
        postData:{}
    }).trigger("reloadGrid");
}

function checkSpecialChar(control)
{
	var noiDung;
	var replaceND;
	
	if(control == "BRANCHCODE_crud") {
	    replaceND = $("#BRANCHCODE_crud").val();
	    noiDung = replaceND.trim();
	    var splChars = "~`!@#$%^&*?<>{}|[]";
		for (var i = 0; i < noiDung.length; i++) {
		    if (splChars.indexOf(noiDung.charAt(i)) != -1){
		    	replaceND = replaceND.replace(noiDung.charAt(i), "");
			}
		}
		$("#BRANCHCODE_crud").val(replaceND);
	}
	if(control == "BRANCHNAME_crud") {
	    replaceND = $("#BRANCHNAME_crud").val();
	    noiDung = replaceND.trim();
	    var splChars = "~`!@#$%^&*?<>{}|[]";
		for (var i = 0; i < noiDung.length; i++) {
		    if (splChars.indexOf(noiDung.charAt(i)) != -1){
		    	replaceND = replaceND.replace(noiDung.charAt(i), "");
			}
		}
		$("#BRANCHNAME_crud").val(replaceND);
	}
}

function clear_crud()
{
	$("#BRANCHCODE_crud").val("");
	$("#BRANCHNAME_crud").val("");
	$("#LOCATION_crud").val("");
}

function bind_crud()
{
	var id = jQuery("#DMBANHSCGrid").jqGrid('getGridParam','selrow'); 
	if (id) {
		var ret = jQuery("#DMBANHSCGrid").jqGrid('getRowData',id);
		$("#BRANCHCODE_crud").val(ret.branchCode);
		$("#BRANCHNAME_crud").val(ret.branchName);
		$("#LOCATION_crud").val(ret.location);
	}
}

$(function() {
	jQuery("#DMBANHSCGrid").jqGrid({ 
		url:'listBranch', 
		datatype: "json", 
		colNames : [ 'Mã chi nhánh','Tên chi nhánh','Địa điểm'],
        colModel : [ {
                name : 'branchCode',
                index : 'branchCode',
                width : 150
        }, {
                name : 'branchName',
                index : 'branchName',
                width : 150,
                editable : false
        }, {
                name : 'location',
                index : 'location',
                width : 550,
                editable : false
        }],
		rowNum:10,  rowList:[15,30,60,80,100], pager: '#Pager1', 
		scrollrows: true,
		autowidth: true,
		height: 300,
		width:650,
		shrinkToFit:false,
		serializeGridData: function (postData) {
        	var condition = getCondition();
       		condition.rowPerPage = postData.rows;
            condition.currentPage = postData.page;
            condition.fromRow = (parseInt(postData.page) - 1) * postData.rows;
            condition.endRow = postData.rows * postData.page;
            condition.event= postData.event;
            return condition;
        },
		caption: " Danh sách Chi nhánh",
		sortname: 'ID', viewrecords: true, sortorder: "ASC"


	}).navGrid('#Pager1',{edit:false,add:false,del:false,search:false,refresh:true,view:false,position:"left",cloneToTop:true});
	})
</script>


<div id="dialog_form_crud" style="display: none;" title="CRUD">
	<form>
		<table width="100%">
			<tr>
				<td align=left><label for="BRANCHCODE_crud">Mã Chi nhánh <font color="red">(*)</font>
				</label></td>
				<td><input type="text" id="BRANCHCODE_crud"
					name="BRANCHCODE_crud" value=""
					class="text ui-widget-content ui-corner-all" size="20"
					maxlength="8" onkeyup="checkSpecialChar('BRANCHCODE_crud')"
					onkeypress="checkSpecialChar('BRANCHCODE_crud')" /></td>
			</tr>
			<tr>
				<td align=left><label for="BRANCHNAME_crud">Tên Chi nhánh</label></td>
				<td align=left><input type="text" id="BRANCHNAME_crud"
					name="BRANCHNAME_crud" value=""
					class="text ui-widget-content ui-corner-all" maxlength="60"
					size="40" onkeyup="checkSpecialChar('BRANCHNAME_crud')"
					onkeypress="checkSpecialChar('BRANCHNAME_crud')" /></td>
			</tr>
			<tr>
				<td align=left><label for="LOCATION_crud">Vị trí</label></td>
				<td align=left><input type="text" id="LOCATION_crud"
					name="LOCATION_crud" value=""
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
				reloadDMBANHSCList();
			}
		});
		$("#BRANCHNAME_search").keypress(function(event) {
			if (event.which == 13) {
				reloadDMBANHSCList();
			}
		});
		$("#btnSearch").button().click(function() {
			reloadDMBANHSCList();
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
