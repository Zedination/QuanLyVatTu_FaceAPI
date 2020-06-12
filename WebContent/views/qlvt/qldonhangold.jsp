<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/views/common/common-libs.jsp" />
<title>QUẢN LÝ ĐƠN HÀNG</title>

<input type="hidden" id="buttonVisible" />
<div id="mainbody">
	<jsp:include page="/views/common/header.jsp" />
	<div id="ja-wrapper">
		<div id="ja-wrapper-top"></div>
		<!-- COPY HERE -->
		<div id="ja-wrapper-inner" class="clearfix">
			<h1>QUẢN LÝ ĐƠN HÀNG</h1>
			<br />
			<div id="dialog-search" title="Tìm kiếm">
				<table width="100%">
					<tr>
						<td align=right><label for="SODH_search">Mã Đơn hàng</label></td>
						<td align=left><input type="text" id="SODH_search" name="SODH_search" value=""
							class="text ui-widget-content ui-corner-all"
							style="width: 300px;" /></td>
					</tr>
					<tr>
						<td align=right><label for="MANHACC_search">Mã Nhà CC</label></td>
						<td align=left><input type="text" id="MANHACC_search" name="MANHACC_search" value=""
							class="text ui-widget-content ui-corner-all"
							style="width: 300px;" /></td>
					</tr>
					<tr>
						<td></td>
						<td align=left></td>
					</tr>
				</table>
			</div>
			<button id="btnSearch" style="float: left;" >Tìm kiếm ĐH</button>&nbsp;
			<button id="btnCreate" name="button" style="float: left;">Thêm mới ĐH</button>&nbsp;
			<button id="btnEdit" name="button" style="float: left;">Sửa ĐH</button>&nbsp;
			<button id="btnDelete" name="button" style="float: left;">Xóa ĐH</button>&nbsp;
			<button id="btnDetail" name="button" style="float: left;">Xem CT ĐH</button>
			<br /> <br />
			<table id="QLDONHANGGrid"></table>
			<div id="Pager1"></div>
			<br /> <br />
			<button id="btnCreateCT" name="button" style="float: left;">Thêm mới CT</button>&nbsp;
			<table id="CTDONHANGGrid"></table>
			<div id="Pager2"></div>
			<br />

		</div>
		<jsp:include page="/views/common/footer.jsp" />
	</div>
</div>

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

function fncCapNhatDH(){
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
	reloadDONHANGList()
    hideLoadingIcon();
    $("#dialog_form_crud").dialog( "close" );
}

function fncXoaBoDH(){
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
	reloadDONHANGList()
    hideLoadingIcon();
    $("#dialog_form_crud").dialog( "close" );
}

function buildDataSubmit() {
	var data = new Object();
	data.sodh=$('#SODH_crud').val();
	data.ngaydh=$('#NGAYDH_crud').val();
	data.mancc=$('#MANCC_crud').val();
	return data;
}

function getCondition(){
	var condition = new Object();
	condition.sodh=$('#SODH_search').val();
	condition.mancc=$('#MANHACC_search').val();
	return condition;
}

function getSoDH(){
	var condition = new Object();
	var id = jQuery("#QLDONHANGGrid").jqGrid('getGridParam','selrow'); 
	if (id) {
		var ret = jQuery("#QLDONHANGGrid").jqGrid('getRowData',id);
		condition.sodh = ret.sodh;
	}
	return condition;
}

function reloadDONHANGList() {
	$('#QLDONHANGGrid').jqGrid("clearGridData", true);
    $('#QLDONHANGGrid').jqGrid('setGridParam',{
        postData:{}
    }).trigger("reloadGrid");
    $('#btnCreateCT').hide();
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
	$("#SODH_crud").val("");
	$("#MAVTU_crud").val("");
	$("#SLDAT_crud").val("");
}

function bind_crud()
{
	var id = jQuery("#QLDONHANGGrid").jqGrid('getGridParam','selrow'); 
	if (id) {
		var ret = jQuery("#QLDONHANGGrid").jqGrid('getRowData',id);
		$("#MAVTU_crud").val(ret.maVtu);
		$("#TENVTU_crud").val(ret.tenVtu);
		$("#DVTINH_crud").val(ret.dvTinh);
		$("#PHANTRAM_crud").val(ret.phanTram);
	}
}
function bind_crud_ct()
{
	var id = jQuery("#CTDONHANGGrid").jqGrid('getGridParam','selrow'); 
	if (id) {
		var ret = jQuery("#CTDONHANGGrid").jqGrid('getRowData',id);
		$("#SODHCT_crud").val(ret.sodh);
		$("#MAVTU_crud").val(ret.mavtu);
		$("#SLDAT_crud").val(ret.sldat);
	}
}

function showFormCT() {
	bind_crud_ct();
	$( "#dialog_form_ct_crud" ).dialog({
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
                	  fncThemMoiDHCT();
                  }
              }
          }
      });
}

$(function() {
	jQuery("#QLDONHANGGrid").jqGrid({ 
		url:'listDonHang', 
		datatype: "json", 
		colNames : [ 'Số Đơn hàng','Ngày đặt hàng','Nhà cung cấp'],
        colModel : [ {
                name : 'sodh',
                index : 'sodh',
                width : 100,
                align: 'center'
        }, {
                name : 'ngaydh',
                index : 'ngaydh',
                width : 150,
                editable : false,
                align: 'center'
        }, {
                name : 'mancc',
                index : 'mancc',
                width : 150,
                editable : false,
                align: 'center'
        }],
		rowNum:10,  rowList:[15,30,60,80,100], pager: '#Pager1', 
		scrollrows: true,
		autowidth: true,
		height: 200,
		width:650,
		shrinkToFit:false,
		caption: " Danh sách Đơn hàng",
		sortname: 'sodh', viewrecords: true, sortorder: "ASC",
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
        },

	}).navGrid('#Pager1',{edit:false,add:false,del:false,search:false,refresh:true,view:false,position:"left",cloneToTop:true});
	})

$(function() {
	jQuery("#CTDONHANGGrid").jqGrid({ 
		url:'listCTDH', 
		datatype: "json", 
		colNames : [ 'Số Đơn hàng','Mã vật tư','Số lượng đặt'],
        colModel : [ {
                name : 'sodh',
                index : 'sodh',
                width : 150
        }, {
                name : 'mavtu',
                index : 'mavtu',
                width : 150,
                editable : false
        }, {
                name : 'sldat',
                index : 'sldat',
                width : 250,
                editable : false
        }],
		rowNum:10,  rowList:[15,30,60,80,100], pager: '#Pager2', 
		scrollrows: true,
		autowidth: true,
		height: 200,
		width:650,
		shrinkToFit:false,
		caption: " Chi tiết Đơn hàng",
		sortname: 'sodh', viewrecords: true, sortorder: "ASC",
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
        	showFormCT();
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
					class="text ui-widget-content ui-corner-all" size="20"
					maxlength="8" onkeyup="checkSpecialChar('SODH_crud')"
					onkeypress="checkSpecialChar('SODH_crud')" /></td>
			</tr>
			<tr>
				<td align=left><label for="NGAYDH_crud">Ngày đơn hàng</label></td>
				<td align=left><input type="text" id="NGAYDH_crud"
					name="NGAYDH_crud" value=""
					class="text ui-widget-content ui-corner-all" maxlength="60"
					size="40" onkeyup="checkSpecialChar('TENNCC_crud')"
					onkeypress="checkSpecialChar('TENNCC_crud')" /></td>
			</tr>
			<tr>
				<td align=left><label for="MANCC_crud">Mã nhà CC</label></td>
				<td align=left><select id="MANCC_crud">
					<option value="mancc1">Điện máy xanh</option>
					<option value="mancc2">Nguyễn Kim</option>
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
					class="text ui-widget-content ui-corner-all" size="20"
					maxlength="8" /></td>
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
					size="40"/></td>
			</tr>
		</table>
	</form>
</div>
<br />

<script type="text/javascript">
	$(document).ready(function() {
		$("#NGAYDH_crud").datepicker({ 
			dateFormat: "dd/mm/yy", 
			dayNames: ['Thứ hai', 'Thứ ba', 'Thứ tư', 'Thứ năm', 'Thứ sáu', 'Thứ bảy', 'Chủ nhật'], 
			dayNamesMin: ['CN','T2','T3','T4','T5','T6','T7'], 
			dayNamesShort: ['CN','Th2','Th3','Th4','Th5','Th6','Th7'], 
			monthNames: ['Tháng 1','Tháng 2','Tháng 3','Tháng 4', 'Tháng 5','Tháng 6','Tháng 7','Tháng 8', 'Tháng 9','Tháng 10','Tháng 11','Tháng 12'], 
			yearSuffix: '' 
		});
		
		$("#MANCC_search").keypress(function(event) {
			if (event.which == 13) {
				reloadDONHANGList();
			}
		});
		$("#TENNCC_search").keypress(function(event) {
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
	                    	  fncThemMoiDH();
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
	                    	  fncCapNhatDH();
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
	                          showConfirm("Bạn có chắc chắn muốn Xóa bỏ?", "fncXoaBoDH");
	                      }
	                  }
	              }
	          });
		});
		
		$( "#btnDetail" ).button().click(function() {
			reloadCTDONHANGList();
			$('#btnCreateCT').show();
		});
		
		$( "#btnCreateCT" ).button().click(function() {
			clear_crud();
			$( "#dialog_form_ct_crud" ).dialog({
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
	                    	  fncThemMoiDHCT();
	                      }
	                  }
	              }
	          });
		});
	});
	
</script>
