// Declaring valid date character, minimum year and maximum year
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
//Ham kiem tra tinh hop le cua ngay thang nam
function isDate(dtStr){
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
		$.showErr("Hay nhap dinh dang ngay hop le: dd/mm/yyyy \n (The date format should be : dd/mm/yyyy)");
		//alert("Hay nhap dinh dang ngay hop le: dd/mm/yyyy \n (The date format should be : dd/mm/yyyy)" )
		return false;
	}
	if (strMonth.length<1 || month<1 || month>12){
		//alert("Nhap lai thang: 01-12  \n (Please enter a valid month)")
		$.showErr("Nhap lai thang: 01-12  \n (Please enter a valid month)");
		return false;
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		$.showErr("Hay nhap ngay hop le. \n (Please enter a valid day)");
		return false;
	}
	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
		$.showErr("Hay nhap nam hop le giua "+minYear+" va "+maxYear+" \n (Please enter a valid 4 digit year between "+minYear+" and "+maxYear+")");
		return false;
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		$.showErr("Hay nhap ngay hop le \n (Please enter a valid date)");
		return false;
	}
	return true;
}

var errHideTimeOut;
$(window).scroll(function(){
	if($("#sysmsg-error") != "none" || $("#sysmsg-success") != "none")
	{
		var top = $.getBodyScrollTop();
		if(top < 157)
			top = 157;
		$("#sysmsg-error-box").stop();
		$("#sysmsg-error-box").animate({"top":top},{duration:300}); 
	}
});

$.maxZIndex = $.fn.maxZIndex = function(opt) 
{
    var def = { inc: 10, group: "*" };
    $.extend(def, opt);    
    var zmax = 0;
    $(def.group).each(function() {
        var cur = parseInt($(this).css('z-index'));
        zmax = cur > zmax ? cur : zmax;
    });
    if (!this.jquery)
        return zmax;

    return this.each(function() {
        zmax += def.inc;
        $(this).css("z-index", zmax);
    });
}

$.showErr = function(str)
{
	var top = $.getBodyScrollTop();
	//if(top < 157)
		//top = 0;
		//$("#divDialog").maxZIndex({ inc: 5 });
	    
	    // Get the zIndex as a number
	 var zindex=$.maxZIndex()+1;
	$("#sysmsg-error-box").css({"top":top});
	//$("#sysmsg-error-box").css("z-index","100");
	//$("#sysmsg-error-box").css("z-index",'"'+zindex+'"');
	document.getElementById("sysmsg-error-box").style.zIndex = zindex;
	$("#sysmsg-error span:first").html(str);
	$("#sysmsg-error").show();
	$("#sysmsg-error-box").show();
	clearTimeout(errHideTimeOut);
	
	var hideErr = function(){
		$("#sysmsg-error-box").slideUp(300);
	};
	
	errHideTimeOut = setTimeout(hideErr,5000);
	
	$("#sysmsg-error-box .close").one("click", function(){
		$("#sysmsg-error-box").hide();
	});
}

var successHideTimeOut;
$.showSuccess = function(str)
{
	var top = $.getBodyScrollTop();
	if(top < 157)
		top = 157;
	$("#sysmsg-error-box").css({"top":top});
	$("#sysmsg-success span:first").html(str);
	$("#sysmsg-success").show();
	$("#sysmsg-error").hide();
	$("#sysmsg-error-box").show();
	
	clearTimeout(successHideTimeOut);
	
	var hideSuccess = function(){
		$("#sysmsg-error-box").slideUp(300);
	};
	
	successHideTimeOut = setTimeout(hideSuccess,5000);
	
	$("#sysmsg-error-box .close").one("click", function(){
		$("#sysmsg-error-box").hide();
	});
}

$.getBodyScrollTop=function(){
    var scrollPos; 
    if (typeof window.pageYOffset != 'undefined') { 
        scrollPos = window.pageYOffset; 
    } 
    else if (typeof document.compatMode != 'undefined' && 
        document.compatMode != 'BackCompat') { 
        scrollPos = document.documentElement.scrollTop; 
    } 
    else if (typeof document.body != 'undefined') { 
        scrollPos = document.body.scrollTop; 
    } 
    return scrollPos;
}


$.minLength = function(value, length , isByte) {
	var strLength = $.trim(value).length;
	if(isByte)
		strLength = $.getStringLength(value);
		
	return strLength >= length;
};

$.maxLength = function(value, length , isByte) {
	var strLength = $.trim(value).length;
	if(isByte)
		strLength = $.getStringLength(value);
		
	return strLength <= length;
};
$.getStringLength=function(str)
{
	str = $.trim(str);
	
	if(str=="")
		return 0; 
		
	var length=0; 
	for(var i=0;i <str.length;i++) 
	{ 
		if(str.charCodeAt(i)>255)
			length+=2; 
		else
			length++; 
	}
	
	return length;
}
//So sanh date
function IsDateGreater(DateValue1, DateValue2)
{
	//10/20/2010
	var array1=DateValue1.split("/");
	var array2=DateValue2.split("/");
	var value01=array1[2]+''+array1[1]+''+array1[0];
	var value02=array2[2]+''+array2[1]+''+array2[0];
	var num01 = new Number(value01);
	var num02 = new Number(value02);
	if(num01<num02)
		return false;
	else
		return true;
}

function IsDateLess(DateValue1, DateValue2)
{
	var DaysDiff;
	Date1 = new Date(DateValue1);
	Date2 = new Date(DateValue2);
	DaysDiff = Math.floor((Date1.getTime() - Date2.getTime())/(1000*60*60*24));
	//alert("DaysDiff ="+DaysDiff);
	if(DaysDiff <= 0)
	return true;
	else
	return false;
}

function IsDateEqual(DateValue1, DateValue2)
{
	var DaysDiff;
	Date1 = new Date(DateValue1);
	Date2 = new Date(DateValue2);
	DaysDiff = Math.floor((Date1.getTime() - Date2.getTime())/(1000*60*60*24));
	if(DaysDiff == 0)
	return true;
	else
	return false;
}




$.checkEmail = function(val){
	var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/; 
	return reg.test(val);
};


function add_cart(id,attr)
{
	var ajaxurl = APP_ROOT+"/cart.php?act=addcart&id="+id;
	if(attr != '')
		ajaxurl += attr;
	$.ajax({ 
		url: ajaxurl,
		dataType: "json",
		success: function(obj){
			if(obj.open_win == 1)
			{
				$.weeboxs.open(obj.html, {contentType:'text',showButton:false,title:LANG['SELECT_AND_ADDCART'],width:550});
			}
			else if(obj.open_win == 2)
			{
				$.showErr(obj.info);
			}
			else
			{
				location.href = CART_URL;
			}
		},
		error:function(ajaxobj)
		{
			alert(ajaxobj.responseText);
		}
	});
	
}

function del_cart(id)
{
	var ajaxurl = APP_ROOT+"/cart.php?act=delcart&id="+id;
	$.ajax({ 
		url: ajaxurl,
		dataType: "json",
		success: function(obj){
			if(obj.status == 1)
			{
				$("#cart_list").html(obj.html);
			}
			else
			{
				location.href = CART_URL;
			}
		},
		error:function(ajaxobj)
		{
			alert(ajaxobj.responseText);
		}
	});
}

function modify_cart(id,htmlobj)
{
	var number = $(htmlobj).val();
	var ajaxurl = APP_ROOT+"/cart.php?act=modifycart&id="+id+"&number="+number;
	$.ajax({ 
		url: ajaxurl,
		dataType: "json",
		success: function(obj){
			if(obj.status == 1)
			{
				$("#cart_list").html(obj.html);
			}
			else
			{
				$.showErr(obj.info);
			}
		},
		error:function(ajaxobj)
		{
			alert(ajaxobj.responseText);
		}
	});	
}

function submit_cart()
{
	var ajaxurl = APP_ROOT+"/cart.php?act=check&ajax=1";
	$.ajax({ 
		url: ajaxurl,
		dataType: "json",
		success: function(obj){
			if(obj.status == 1)
			{
				location.href = CART_CHECK_URL;
			}
			else
			{
				$.showErr(obj.info);
			}
		},
		error:function(ajaxobj)
		{
			alert(ajaxobj.responseText);
		}
	});		
}


$.copyText = function(id)
{
	var txt = $(id).val();
	if(window.clipboardData)
	{
		window.clipboardData.clearData();
		var judge = window.clipboardData.setData("Text", txt);
		if(judge === true)
			alert(LANG.JS_COPY_SUCCESS);
		else
			alert(LANG.JS_COPY_NOT_SUCCESS);
	}
	else if(navigator.userAgent.indexOf("Opera") != -1)
	{
		window.location = txt;
	} 
	else if (window.netscape) 
	{
		try
		{
			netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
		}
		catch(e)
		{
			alert(LANG.JS_NO_ALLOW);
		}
		var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);
		if (!clip)
			return;
		var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
		if (!trans)
			return;
		trans.addDataFlavor('text/unicode');
		var str = new Object();
		var len = new Object();
		var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
		var copytext = txt;
		str.data = copytext;
		trans.setTransferData("text/unicode",str,copytext.length*2);
		var clipid = Components.interfaces.nsIClipboard;
		if (!clip)
			return false;
		clip.setData(trans,null,clipid.kGlobalClipboard);
		alert(LANG.JS_COPY_SUCCESS);
	}
};


function submit_mail(o)
{	
	var email = $(o).parent("td").parent("tr").find("input[name='email']").val();
	if(email == '')
	{
		$.showErr(LANG.EMAIL_EMPTY_TIP);
		return;
	}
	if(!$.checkEmail(email))
	{
		$.showErr(LANG.EMAIL_FORMAT_ERROR_TIP);
		return;
	}
	var ajaxurl = APP_ROOT+"/subscribe.php?act=addmail&email="+email+"&ajax=1";
	$.ajax({ 
		url: ajaxurl,
		dataType: "json",
		success: function(obj){
			if(obj.status == 1)
			{
				$.showSuccess(LANG.SUBSCRIBE_SUCCESS);
				return;
			}
			else
			{
				$.showErr(obj.info);
				return;
			}
		},
		error:function(ajaxobj)
		{
			alert(ajaxobj.responseText);
		}
	});	
}


function load_consignee(consignee_id)
{
	var ajaxurl = APP_ROOT+"/ajax.php?act=load_consignee&id="+consignee_id;
	$.ajax({ 
		url: ajaxurl,
		success: function(html){
			$("#cart_consignee").html(html);
			load_delivery();
		},
		error:function(ajaxobj)
		{
			alert(LANG['REFRESH_TOO_FAST']);
		}
	});	
}


function load_delivery()
{
	var select_last_node = $("#cart_consignee").find("select[value!='0']");
	if(select_last_node.length>0)
	{		
		var region_id = $(select_last_node[select_last_node.length - 1]).val();
	}
	else
	{
		var region_id = 0;
	}
	
	var ajaxurl = APP_ROOT+"/ajax.php?act=load_delivery&id="+region_id;
	$.ajax({ 
		url: ajaxurl,
		success: function(html){
			$("#cart_delivery").html(html);
			count_buy_total();  
		},
		error:function(ajaxobj)
		{
			alert(LANG['REFRESH_TOO_FAST']);
		}
	});	
}


function count_buy_total()
{
	$("#order_done").attr("disabled",true);
	var query = new Object();
	

	var delivery_id = $("input[name='delivery']:checked").val();

	if(!delivery_id)
	{
		delivery_id = 0;
	}
	query.delivery_id = delivery_id;

	
	var select_last_node = $("#cart_consignee").find("select[value!='0']");
	if(select_last_node.length>0)
	{		
		var region_id = $(select_last_node[select_last_node.length - 1]).val();
	}
	else
	{
		var region_id = 0;
	}
	query.region_id = region_id;
	
	
	var account_money = $("input[name='account_money']").val();
	if(!account_money||$.trim(account_money)=='')
	{
		account_money = 0;
	}
	query.account_money = account_money;
	

	if($("#check-all-money").attr("checked"))
	{
		query.all_account_money = 1;
	}
	else
	{
		query.all_account_money = 0;
	}
	

	var ecvsn = $("input[name='ecvsn']").val();
	if(!ecvsn)
	{
		ecvsn = '';
	}
	var ecvpassword = $("input[name='ecvpassword']").val();
	if(!ecvpassword)
	{
		ecvpassword = '';
	}
	query.ecvsn = ecvsn;
	query.ecvpassword = ecvpassword;
	

	var payment = $("input[name='payment']:checked").val();
	if(!payment)
	{
		payment = 0;
	}
	query.payment = payment;
	
	if(!isNaN(order_id)&&order_id>0)
	var ajaxurl = APP_ROOT+"/ajax.php?act=count_order_total&id="+order_id;
	else
	var ajaxurl = APP_ROOT+"/ajax.php?act=count_buy_total";
	$.ajax({ 
		url: ajaxurl,
		data:query,
		type: "POST",
		dataType: "json",
		success: function(data){
			$("#cart_total").html(data.html);
			$("input[name='account_money']").val(data.account_money);
			if(data.pay_price == 0)
			{
				$("input[name='payment']").attr("checked",false);
			}
			$("#order_done").attr("disabled",false);
		},
		error:function(ajaxobj)
		{
			alert(LANG['REFRESH_TOO_FAST']);
		}
	});	
}



function submit_buy()
{
	$("#order_done").attr("disabled",true);
	var query = new Object();
	

	var delivery_id = $("input[name='delivery']:checked").val();

	if(!delivery_id)
	{
		delivery_id = 0;
	}
	query.delivery_id = delivery_id;


	var select_last_node = $("#cart_consignee").find("select[value!='0']");
	if(select_last_node.length>0)
	{		
		var region_id = $(select_last_node[select_last_node.length - 1]).val();
	}
	else
	{
		var region_id = 0;
	}
	query.region_id = region_id;
	

	var account_money = $("input[name='account_money']").val();
	if(!account_money||$.trim(account_money)=='')
	{
		account_money = 0;
	}
	query.account_money = account_money;
	

	if($("#check-all-money").attr("checked"))
	{
		query.all_account_money = 1;
	}
	else
	{
		query.all_account_money = 0;
	}
	

	var ecvsn = $("input[name='ecvsn']").val();
	if(!ecvsn)
	{
		ecvsn = '';
	}
	var ecvpassword = $("input[name='ecvpassword']").val();
	if(!ecvpassword)
	{
		ecvpassword = '';
	}
	query.ecvsn = ecvsn;
	query.ecvpassword = ecvpassword;
	
	
	var payment = $("input[name='payment']:checked").val();
	if(!payment)
	{
		payment = 0;
	}
	query.payment = payment;
	
	if(!isNaN(order_id)&&order_id>0)
	var ajaxurl = APP_ROOT+"/ajax.php?act=count_order_total&id="+order_id;
	else
	var ajaxurl = APP_ROOT+"/ajax.php?act=count_buy_total";
	$.ajax({ 
		url: ajaxurl,
		data:query,
		type: "POST",
		dataType: "json",
		success: function(data){
			if(data.is_delivery == 1)
			{
			
				if(!data.region_info||data.region_info.region_level != 4)
				{
					$.showErr(LANG['FILL_CORRECT_CONSIGNEE_ADDRESS']);
					$("#order_done").attr("disabled",false);
					return;
				}
				if($.trim($("input[name='consignee']").val())=='')
				{
					$.showErr(LANG['FILL_CORRECT_CONSIGNEE']);
					$("#order_done").attr("disabled",false);
					return;
				}
				if($.trim($("input[name='address']").val())=='')
				{
					$.showErr(LANG['FILL_CORRECT_ADDRESS']);
					$("#order_done").attr("disabled",false);
					return;
				}
				if($.trim($("input[name='zip']").val())=='')
				{
					$.showErr(LANG['FILL_CORRECT_ZIP']);
					$("#order_done").attr("disabled",false);
					return;
				}
				if($.trim($("input[name='mobile']").val())=='')
				{
					$.showErr(LANG['FILL_MOBILE_PHONE']);
					$("#order_done").attr("disabled",false);
					return;
				}
				if(!$.checkMobilePhone($("input[name='mobile']").val()))
				{
					$.showErr(LANG['FILL_CORRECT_MOBILE_PHONE']);
					$("#order_done").attr("disabled",false);
					return;
				}
				if(!data.delivery_info)
				{
					$.showErr(LANG['PLEASE_SELECT_DELIVERY']);
					$("#order_done").attr("disabled",false);
					return;
				}			
			}
			
			if(data.pay_price!=0&&!data.payment_info)
			{
				$.showErr(LANG['PLEASE_SELECT_PAYMENT']);
				$("#order_done").attr("disabled",false);
				return;
			}	
			
			$("#cart_form").submit();
		},
		error:function(ajaxobj)
		{			
			alert("error: "+ajaxobj.responseText);
			return false;
		}
	});	
}

function submit_sms()
{
	$.weeboxs.open(APP_ROOT+"/sms.php?act=subscribe", {contentType:'ajax',showButton:false,title:LANG['SMS_SUBSCRIBE'],width:400,height:200});	
}
function unsubmit_sms()
{
	$.weeboxs.open(APP_ROOT+"/sms.php?act=unsubscribe", {contentType:'ajax',showButton:false,title:LANG['SMS_UNSUBSCRIBE'],width:400,height:200});	
}



function check_coupon()
{
	var coupon_sn = $.trim($("#coupon_sn").val());
	var ajaxurl = APP_ROOT+"/coupon.php?act=check_coupon&coupon_sn="+coupon_sn;
	$.ajax({ 
		url: ajaxurl,
		success: function(msg){
			alert(msg);
		},
		error:function(ajaxobj)
		{
			alert(ajaxobj.responseText);
		}
	});	
}

function use_coupon()
{
	var coupon_sn = $.trim($("#coupon_sn").val());
	var coupon_pwd = $.trim($("#coupon_pwd").val());
	var ajaxurl = APP_ROOT+"/coupon.php?act=use_coupon&coupon_sn="+coupon_sn+"&coupon_pwd="+coupon_pwd;
	$.ajax({ 
		url: ajaxurl,
		dataType: "json",
		success: function(obj){
			if(obj.status==2)
			{
				$.weeboxs.open(APP_ROOT+"/coupon.php?act=ajax_supplier_login", {contentType:'ajax',showButton:false,title:LANG['SUPPLIER_LOGIN'],width:500,height:150});	
			}
			if(obj.status == 0)
			{
				
				alert(obj.msg);
			}
			if(obj.status == 1)
			{
				
				alert(obj.msg);
			}
		},
		error:function(ajaxobj)
		{
			alert(ajaxobj.responseText);
		}
	});
}
