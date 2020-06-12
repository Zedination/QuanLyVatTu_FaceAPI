<!DOCTYPE html>
<html lang="en">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<base href="<%=basePath%>">


<!-- All common css in here. -->
<link href="./resources/css/template.css" rel="stylesheet" />
<link href="./resources/css/style.css" rel="stylesheet">
<link href="./resources/css/ja.cssmenu.css" rel="stylesheet" />
<link href="./resources/css/ui.theme.css" rel="stylesheet" />
<link href="./resources/css/jquery-ui-lightness.css" rel="stylesheet">
<link href="./resources/css/jquery.checkboxtree.min.css" rel="stylesheet">
<link href="./resources/css/jquery-ui-1.8.2.custom.css" rel="stylesheet">
<link href="./resources/css/ui.jqgrid.css" rel="stylesheet">

<!-- All common js in here. -->
<script src="./resources/js/jquery-1.7.2.min.js"></script>
<script src="./resources/js/trirand/i18n/grid.locale-en.js"></script>
<script src="./resources/js/trirand/jquery.jqGrid.min.js"></script>
<script src="./resources/js/jquery.bgiframe-2.1.2.js"></script>
<script src="./resources/js/jquery-ui.min.js"></script>
<script src="./resources/js/jquery-ui-1.8.6.custom.min.js"></script>
<script src="./resources/js/jquery-ui-timepicker-addon.js"></script>
<script src="./resources/js/jquery.checkboxtree.min.js"></script>
<script src="./resources/js/jquery.maskedinput-1.2.2.js"></script>
	
</html> 