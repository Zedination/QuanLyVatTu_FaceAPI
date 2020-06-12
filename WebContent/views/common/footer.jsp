<%@page
	language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="ja-wrapper-bottom">
	<p style="float:left;color:#091266;margin:0;padding:10px 0px 0px 30px;">
		VIỆN CÔNG NGHỆ VÀ ĐÀO TẠO DEVMASTER
	</p>
	<p style="float:right;color:#091266;margin:0;padding:10px 30px 0px 0px;">
		 Version 1.0
	</p>
	<br>
	<div id='userName'></div>
</div>
<div id="sysmsg-error-box" style="top: 0px; display: none;" >
		<div class="sysmsgw hidd" id="sysmsg-error">
			<div class="sysmsg"><span></span><span class="close">Đóng</span></div>
		</div>
</div>

<div id="confirm_dlg" style="display:none; font-size:14px" title="Thông báo">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
	<span id="confirm_text">Bạn có chắc chắn?</span>
	</p>
</div>


<div id="validate_dlg" style="display:none; font-size:14px" title="Thông báo">
	Dữ liệu nhập vào chưa đầy đủ, vui lòng kiểm tra lại các trường bắt buộc: <br />
	<span id="validate_text">Dữ liệu nhập vào chưa đầy đủ, vui lòng kiểm tra lại các trường bắt buộc: <br /></span>
</div>

<!-- <div id="dlg_search" style="display:none" title="Tìm kiếm">
	<b>Họ Tên:</b><br/>
	<input type="text" name="keyword" id="keyword" class="text ui-widget-content ui-corner-all" maxlength="50" size="42"/>
</div>
 -->

<div id="dlg_search" style="display:none" title="Vấn tin cán bộ">
	<table width="100%">
		<tr>
			<td><label for="HoTen">Họ Tên:</label></td>
			<td><input type="text" name="keyword" id="keyword" class="text ui-widget-content ui-corner-all" maxlength="200"  size="50"/></td>
		</tr>
	</table>
</div>

<div id="dlg_validate" style="display:none" title="Thông báo">
	Dữ liệu nhập vào chưa đầy đủ, vui lòng kiểm tra lại các trường bắt buộc: <br />
</div>

<div id="dlg_success" style="display:none;width:400px;" title="Thông báo">
	Thực hiện thành công!
</div>
