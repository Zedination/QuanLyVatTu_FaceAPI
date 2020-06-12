<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<script>
		function showMessage(message) {
			document.getElementById('dialog_show_message').innerHTML= message ;
			$( "#dialog_show_message" ).dialog({
				title: "Thông báo",
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
		
		function showMsgIncludeFocus(message, controlFocus) {
			document.getElementById('dialog_show_message').innerHTML= message ;
			$( "#dialog_show_message" ).dialog({
				title: "Thông báo",
                modal: true,
                height: 230,
                width: 350,
                buttons: {
                    OK: function() {
                        $( this ).dialog( "close" );
                        $("#" + controlFocus).focus();
                    }
                }
            });
		}
		
		function showMissInput(message, missInputName) {
			document.getElementById('dialog_show_message').innerHTML= message ;
			$( "#dialog_show_message" ).dialog({
				title: "Thông báo",
                modal: true,
                height: 230,
                width: 350,
                buttons: {
                    OK: function() {
                        $( this ).dialog( "close" );
                        $("#"+missInputName).focus();
                    }
                }
            });
		}
		
		//Hàm này hoạt động tốt!
		function showConfirm(message, fncCallBack) {
			$("#dialog_show_message").html(message);
			$( "#dialog_show_message" ).dialog({
				title: "Xác nhận",
		        modal: true,
		        height: 230,
		        width: 350,
		        buttons: {
		            OK: function() {
		            	$( this ).dialog( "close" );
		            	if(fncCallBack != null) {
		            		var fn = window[fncCallBack];
		            		fn();
		            	}
		            },
		            Cancel: function() {
		                $( this ).dialog( "close" );
		            }
		        }
		    });
		}
		
		//Hàm này chưa hoạt động được!
		/* function showConfirm(message, fncCallBack) {
			$("#dialog_show_message").html(message);
			$( "#dialog_show_message" ).dialog({
				title: "Xác nhận",
                modal: true,
                height: 230,
                width: 350,
                buttons: {
                    OK: function() {
                    	$( this ).dialog( "close" );
                    	if(fncCallBack != null) {
                    		var fn = window[fncCallBack];
                    		fn();
                    	}
                    },
                    Cancel: function() {
                        $( this ).dialog( "close" );
                    }
                }
            });
		} */
		
		function showError(message) {
			if(message == null) {
				document.getElementById('dialog_show_message').innerHTML="<font style='color:red;'>Có lỗi xảy ra. Vui lòng thử lại hoặc liên hệ với hỗ trợ.</font>";
			} else {
				document.getElementById('dialog_show_message').innerHTML="<font style='color:red;'></font>" + message + ".<font style='color:red;'> Vui lòng thử lại hoặc liên hệ với hỗ trợ.</font>";
			}
			$( "#dialog_show_message" ).dialog({
				title: "Báo lỗi",
                modal: true,
                height: 230,
                width: 370,
                buttons: {
                    OK: function() {
                    	$( this ).dialog( "close" );
                    }
                }
            });
            return false;
		}
		
		//Sử dụng hàm showError() dưới đây đang có 1 vấn đề: Trên grid có nhiều dòng, click chọn 1 dòng để xử lý, khi có lỗi xảy ra ->
		//	-> sử dụng hàm showError() để thông báo lỗi thì ngay sau đó chọn dòng thứ 2 để xử lý thì ko thể thực hiện được. Phải refresh lại cả trang.
		/* function showError(message) {
			if(message == null) {
				document.getElementById('dialog_show_message').innerHTML="<font style='color:red;'>Có lỗi xảy ra. Vui lòng thử lại hoặc liên hệ với hỗ trợ.</font>";
			} else {
				document.getElementById('dialog_show_message').innerHTML="<font style='color:red;'></font>" + message + ".<font style='color:red;'> Vui lòng thử lại hoặc liên hệ với hỗ trợ.</font>";
			}
			$( "#dialog_show_message" ).dialog({
				title: "Báo lỗi",
                autoOpen: false,
                height: 230,
                width: 370,
                buttons: {
                    OK: function() {
                    	$( this ).dialog( "close" );
                    }
                },
                open: function (event, ui) {//line 1
                }
            });
            $("#dialog_show_message").dialog('open').show();//line 2
            return false;
		} */
		
		function showValidate() {
			$( "#dialog_validate" ).dialog({
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
		
		function showLoadingIcon() {
		    $("#dlg_loading" ).dialog({modal: true,height: 100,dialogClass: "no-close",closeOnEscape: false,resizable: false});
		}

		function hideLoadingIcon(){
			$( "#dlg_loading" ).dialog( "close" );
		}
		
		function trim( value ) { 
			 var reL = /\s*((\S+\s*)*)/; 
			 var reR = /((\s*\S+)*)\s*/; 
			 value = value.replace(reL, "$1"); 
			 return value.replace(reR, "$1"); 
		}
		
		
		/******** Begin list functions use to validate DatePicker control in jsp form  **************/
		
		// Declaring valid date character, minimum year and maximum year
		var dtCh= "/";
		var minYear=1900;
		var maxYear=2100;
		function isInteger(s){
			var i;
		    for (i = 0; i < s.length; i++){   
		        // Check that current character is number.
		        var c = s.charAt(i);
		        if (((c < "0") || (c > "9"))) return false;
		    }
		    // All characters are numbers.
		    return true;
		}
		
		function stripCharsInBag(s, bag){
			var i;
		    var returnString = "";
		    // Search through string's characters one by one.
		    // If character is not in bag, append to returnString.
		    for (i = 0; i < s.length; i++){   
		        var c = s.charAt(i);
		        if (bag.indexOf(c) == -1) returnString += c;
		    }
		    return returnString;
		}
		
		function daysInFebruary (year){
			// February has 29 days in any year evenly divisible by four,
		    // EXCEPT for centurial years which are not also divisible by 400.
		    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
		}
		
		function DaysArray(n) {
			for (var i = 1; i <= n; i++) {
				this[i] = 31;
				if (i==4 || i==6 || i==9 || i==11) {this[i] = 30;}
				if (i==2) {this[i] = 29;}
		   } 
		   return this;
		}
		
		function isDate(controlName, ctlNameDisplay){
			var dtStr = $("#" + controlName).val();
			if(dtStr != '') {
				var daysInMonth = DaysArray(12);
				var pos1=dtStr.indexOf(dtCh);
				var pos2=dtStr.indexOf(dtCh,pos1+1);
				var strDay=dtStr.substring(0,pos1);
				var strMonth=dtStr.substring(pos1+1,pos2);
				var strYear=dtStr.substring(pos2+1);
				strYr=strYear;
				if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1);
				if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1);
				for (var i = 1; i <= 3; i++) {
					if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1);
				}
				month=parseInt(strMonth);
				day=parseInt(strDay);
				year=parseInt(strYr);
				if (pos1==-1 || pos2==-1){
					showMsgIncludeFocus("Lỗi dữ liệu trường thông tin \"" + ctlNameDisplay + "\": <font style='color:red;'>Định dạng Ngày phải là mm/dd/yyyy</font>", controlName);
					return false;
				}
				if (strMonth.length<1 || month<1 || month>12){
					showMsgIncludeFocus("Lỗi dữ liệu trường thông tin \"" + ctlNameDisplay + "\": <font style='color:red;'>Hãy điền Tháng hợp lệ (1 - 12)</font>", controlName);
					return false;
				}
				if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
					showMsgIncludeFocus("Lỗi dữ liệu trường thông tin \"" + ctlNameDisplay + "\": <font style='color:red;'>Hãy điền Ngày hợp lệ theo Tháng(1 - 31)</font>", controlName);
					return false;
				}
				if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
					showMsgIncludeFocus("Lỗi dữ liệu trường thông tin \"" + ctlNameDisplay + "\": <font style='color:red;'>Hãy điền năm trong khoảng "+minYear+" và "+maxYear + "</font>", controlName);
					return false;
				}
				if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
					showMsgIncludeFocus("Lỗi dữ liệu trường thông tin \"" + ctlNameDisplay + "\": <font style='color:red;'>Hãy điền Ngày/Tháng/Năm hợp lệ</font>", controlName);
					return false;
				}
				
				if(!isDateMore(day, month, year)) {
					showMsgIncludeFocus("Lỗi dữ liệu trường thông tin \"" + ctlNameDisplay + "\": <font style='color:red;'>Hãy điền Ngày hợp lệ theo Tháng & Năm(1 - 31)</font>", controlName);
					return false;
				}
				return true;
			} else return true;
		}
		
		function isDateMore(day, month, year) // Check Day by Month, Year
		{
		    var monthLength = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
		
		    // Adjust for leap years
		    if(year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
		        monthLength[1] = 29;
		
		    // Check the range of the day
		    return day > 0 && day <= monthLength[month - 1];
		}
		/******** End list functions use to validate DatePicker control in jsp form  **************/
		
	</script>
	
	<div id="dialog_validate" style="display: none" title="Thông báo">
		Dữ liệu nhập vào chưa đầy đủ. Hãy kiểm tra lại các trường có dấu <font style='color:red;'>(*)</font><br />
	</div>
	
	<div id="dialog_show_message" style="display: none" title="">
		Nội dung thông báo
	</div>
	
	<div id="dialog_confirm" style="display: none" title="Cảnh báo">
		Bạn có chắc chắn muốn xóa không?
	</div>
	
	<div id="dlg_loading" style="display:none ; " title="Xin vui lòng chờ trong giây lát...">
	    <p style="width:100%;text-align:center;">
	        <img src="./resources/images/ajax_loading.gif" width="220" height="19" border="0" />
	    </p>
	</div>
</body>
</html>