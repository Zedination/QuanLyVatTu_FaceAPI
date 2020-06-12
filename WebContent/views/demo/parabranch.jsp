<!DOCTYPE HTML>

<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <!-- HEADER -->
<jsp:include page="/views/common/header.jsp" />
<link href="./resources/css/theme/css/style.default.css" rel="stylesheet" />
<link href="./resources/css/theme/css/custom.css" rel="stylesheet" />
<!-- HEADER -->
<body>
	<section>
		<!-- LEFTPANEL -->
		<jsp:include page="/views/common/leftpanel.jsp" />
		<!-- LEFTPANEL -->
			<div class="mainpanel">
			<jsp:include page="/views/common/headerbar.jsp" />
			
			<div class="pageheader">
			    <h2><i class="fa fa-archive"></i> Bảng mã chi nhánh </h2>							
			</div>
			
			<div class="contentpanel">
				<div class="row panel-body">
					<form id="frm-search">
							<div class="form-group">
									<label class="col-sm-2 control-label align-left">Mã chi nhánh:</label>
									<div class="col-sm-3">
										<input class="form-control input-xs" type="text" id="maCN_search" name="maCN_search" maxlength='3'>
									</div>
							</div>
					</form>
					<div>
						<a id="btnSearch" class="btn btn-xs btn-primary">Tìm kiếm</a> 
						<button id="update" class="btn btn-xs btn-success dg-row-detail" >Chỉnh sửa</button> 
						<button id="import" class="btn btn-xs btn-success " into='branch' >Import file</button> 
						
	                     <!--<a class="bidvmodal btn btn-success" href="ExportExcel?retrieve=branch&filename=branch.xlsx" >Export Excel</a> -->               
	                </div>	
					<div class="col-md-12">
						<table id="dg" class="easyui-datagrid"
	                        data-options="
	                            url:'${pageContext.request.contextPath}/ParaBranch',
	                            queryParams: {task:'view'},
	                            sortName: 'branchcode',
	                            sortOrder: 'ASC',
	                            singleSelect:true,
	                            pagination: true,
	                            pageSize: 20,
	                            rownumbers: true,
	                            pageList: [20,40,80,200]"
	                        style="height:600px">
	                        <thead>
	                            <tr>
	                            	<!-- <th data-options="field: 'bankcode', title: 'Bank Code', width: 70, sortable: false"></th> -->
	                                <th data-options="field: 'branchcode', title: 'Mã chi nhánh', width: 80, sortable: true"></th>
	                                <th data-options="field: 'branchnameenglish', title: 'Tên tiếng Anh', width: 250, sortable: true"></th>
	                                <th data-options="field: 'branchnamevietnamese', title: 'Tên tiếng Việt', width: 250"></th>	                                
	                                <th data-options="field: 'address', title: 'Địa chỉ', width: 300"></th>
	                                <th data-options="field: 'taxcode', title: 'Mã số thuế', width: 100"></th>
	                                <th data-options="field: 'thuchien', title: 'Quyền thực hiện', width: 100, formatter:function(value, row){ if (row.thuchien=='0') return 'Remote'; else if (row.thuchien=='1') return 'Trực tiếp'; else return ''}" ></th>
	                                <th data-options="field: 'gdv_phitc', title: 'GDV GD phi TC', width: 100"></th>
	                                <th data-options="field: 'email_gdv_gdphitc', title: 'Email GDV GD phi TC', width: 100"></th>
	                                <!-- <th data-options="field: 'ksv_phitc', title: 'KSV GD phi TC', width: 100"></th> -->
	                                <th data-options="field: 'gdv_gdgui', title: 'GDV GD gửi', width: 100"></th>
	                                <th data-options="field: 'email_gdv_gdgui', title: 'Email GDV GD gửi', width: 100"></th>
	                                <th data-options="field: 'ksv_gdgui', title: 'KSV GD gửi', width: 100"></th>
	                                <th data-options="field: 'processbranch', title: 'Chi nhánh thực hiện', width: 80"></th>	                                
	                                	                                
	                            </tr>
	                        </thead>
	                    </table>
	                                        
					</div>
				</div>
			</div>
		</div>		
	</section>
	
	<div id="dlg" class="modal extended-modal fade no-display" tabindex="-1" data-width="600">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
					<h4 class="modal-title">Chỉnh sửa Tham số chi nhánh</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<form id="frm" class="form-horizontal form-margin">
							<div class="form-group">
								<!-- <label class="col-sm-4 control-label align-left">Bank Code:</label>
								<div class="col-sm-2" id='bankcode'></div> -->
								<label class="col-sm-4 control-label align-left">Mã chi nhánh:</label>
								<div class="col-sm-2" id='branchcode'></div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label align-left">Tên tiếng Anh:</label>
								<div class="col-sm-8" id="englishname"></div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label align-left">Tên tiếng Việt:</label>
								<div class="col-sm-8" id="vietnamename"></div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label align-left">Địa chỉ:</label>
								<div class="col-sm-8">
									<input class="create form-control input-xs" type="text" id="address" name="address" maxlength='200'>
								</div>
							</div>							
							<div class="form-group">
								<label class="col-sm-4 control-label align-left">Mã số thuế:</label>
								<div class="col-sm-8">
									<input class="create form-control input-xs" type="text" id="taxcode" name="taxcode" maxlength='15'>
								</div>
							</div>	
							<div class="form-group">
								<label class="col-sm-4 control-label align-left">Quyền thực hiện:</label>
								<div class="col-sm-8">
									<select class='form-control input-xs' id="thuchien" name="thuchien" >
										<option value='0' >Remote</option>
										<option value='1' >Trực tiếp</option>
									</select>
								</div>
							</div>	
							<div class="form-group">
								<label class="col-sm-4 control-label align-left">GDV gd phi tc:</label>
								<div class="col-sm-8">
									<input class="create form-control input-xs" type="text" id="gdv_phitc" name="gdv_phitc" maxlength='20'>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label align-left">KSV gd phi tc:</label>
								<div class="col-sm-8">
									<input class="create form-control input-xs" type="text" id="ksv_phitc" name="ksv_phitc" maxlength='20'>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label align-left">GDV  gd gửi:</label>
								<div class="col-sm-8">
									<input class="create form-control input-xs" type="text" id="gdv_gdgui" name="gdv_gdgui" maxlength='20'>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label align-left">KSV  gd gửi:</label>
								<div class="col-sm-8">
									<input class="create form-control input-xs" type="text" id="ksv_gdgui" name="ksv_gdgui" maxlength='20'>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label align-left">Email GDV GD phi TC:</label>
								<div class="col-sm-8">
									<input class="create form-control input-xs" type="text" id="email_gdv_gdphitc" name="email_gdv_gdphitc" maxlength='50'>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label align-left">Email GDV GD gửi:</label>
								<div class="col-sm-8">
									<input class="create form-control input-xs" type="text" id="email_gdv_gdgui" name="email_gdv_gdgui" maxlength='50'>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label align-left">Chi nhánh thực hiện:</label>
								<div class="col-sm-8">
									<input class="create form-control input-xs" type="text" id="processbranch" name="processbranch" maxlength='3'>
								</div>
							</div>						
						</form>
					</div>
				</div>
				<div class="modal-footer">					
					<button type="button" id="save" class="btn btn-xs btn-primary" >Lưu</button>
					<button type="button" data-dismiss="modal" class="btn btn-xs btn-default">Đóng</button>					
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript">
	jQuery(document).ready(function() {
		setActiveNav("params", "parabranch");
	});
	
	jQuery(document).ready(function($) {

		$("#btnSearch").click(function(event) {
			// Disble the search button
			enableSearchButton(false);

			// Prevent the form from submitting via the browser.
			event.preventDefault();

			searchViaAjax();

		});

	});

	function searchViaAjax() {

		var search = {}
		search["username"] = $("#username").val();
		search["email"] = $("#email").val();

		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "${home}search/api/getSearchResult",
			data : JSON.stringify(search),
			dataType : 'json',
			timeout : 100000,
			success : function(data) {
				console.log("SUCCESS: ", data);
				display(data);
			},
			error : function(e) {
				console.log("ERROR: ", e);
				display(e);
			},
			done : function(e) {
				console.log("DONE");
				enableSearchButton(true);
			}
		});

	}
</script>
</body>
