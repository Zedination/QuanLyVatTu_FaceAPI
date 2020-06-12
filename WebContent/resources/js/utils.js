

function setDisabled(inputName,true_false,bgColor)
{
	var strInput=document.getElementById(inputName);
	strInput.disabled=true_false;
	strInput.style.background=bgColor;
}
function setReadOnly(inputName,true_false,bgColor)
{
	var strInput=document.getElementById(inputName);
	strInput.readOnly=true_false;
	strInput.style.background=bgColor;
}
function getUrlParameter( name ,url){	
	name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  	var regexS = "[\\?&]"+name+"=([^&#]*)";
  	var regex = new RegExp( regexS );
  	var results = regex.exec(url);
  	if( results == null )
    	return "";
  	else
    	return results[1];
}
function getFormAsString(formName)
{ 	 
 	returnString ="";
 	formElements=document.forms[formName].elements; 	
 	for ( var i=formElements.length-1; i>=0; --i )
 	{
 		returnString=returnString+"&"+(formElements[i].name)+"="+(formElements[i].value);
 	}
 	return returnString; 
 }
function getParameterDetail()
{	
	var para;
	var p_ref;
	var p_accountNumber;
	var p_accountType;
	var p_referenceNumber;
	var p_runningSeq3;
	var mtChange=document.getElementById('messageCode').value; 	
	var p_direction = document.getElementById('direction').value;
	
	p_subAction="viewDetail";
	p_accountNumber=document.getElementById('accountNumber').value ;
	p_accountType=document.getElementById('accountType').value;
	p_referenceNumber=document.getElementById('referenceNumber').value;
	p_runningSeq3=document.getElementById('runningSeq3').value;
	para="subAction="+p_subAction+"&accountNumber="+p_accountNumber+"&accountType="+p_accountType+"&referenceNumber="+p_referenceNumber+"&runningSeq3="+p_runningSeq3+"&direction="+p_direction+"&messageType="+mtChange;	
	return para;
}
/*------------------------Login Remember User ID */

function getCookie(document,NameOfCookie)
{
	if (document.cookie.length > 0){
	c_start = document.cookie.indexOf(NameOfCookie + "=");
	if (c_start != -1){
	c_start = c_start + NameOfCookie.length + 1;
	c_end = document.cookie.indexOf(";",c_start);
	if (c_end == -1) c_end = document.cookie.length;
	return unescape(document.cookie.substring(c_start,c_end)) ;
	}
	}
	return "";
}

function setCookie(document,NameOfCookie,value,expiredays)
{
	if (!getCookie(document,NameOfCookie)) {
	var exdate = new Date();
	exdate.setDate(exdate.getDate()+expiredays);
	document.cookie = NameOfCookie+ "=" +escape(value)+((expiredays==null) ? "" : ";expires="+exdate.toGMTString());
	}
}

function delCookie(document,NameOfCookie) 
{
	if (getCookie(document,NameOfCookie)) {
	document.cookie = NameOfCookie + "=" + ";expires=Thu, 01-Jan-70 00:00:01 GMT";
	}
}

function checkCookie(document)
{
	name = getCookie(document,'j_username');
	if (name != null && name != ""){
	document.loginForm.j_username.value = name;
	document.loginForm.rememberUserId.checked = true;
	}
}

function toggle(document)
{
	if(document.loginForm.rememberUserId.checked == true){
	var fieldValue = document.loginForm.j_username.value;
	setCookie(document,'j_username',fieldValue,365);
	}else{
	delCookie(document,'j_username');
	}
} 
//Format Currency:SWE
function formatCurrency(num) {
	if(num=="")return "";
    num = num.toString().replace(/\$|\,/g,'');
    if(isNaN(num)) return "";
   // num = "0";
    sign = (num == (num = Math.abs(num)));
    num = Math.floor(num*100+0.50000000001);
    cents = num%100;
    num = Math.floor(num/100).toString();
    if(cents<10)
    cents = "0" + cents;
    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
    num = num.substring(0,num.length-(4*i+3))+','+
    num.substring(num.length-(4*i+3));
    return (((sign)?'':'-')  + num + '.' + cents);
}
function spanFormatCurrencyOnblur(object) {
	object.value=formatCurrency(object.value);
	if (object.parentNode.getElementsByTagName('span')[0]) 
		object.parentNode.getElementsByTagName('span')[0].style.display = 'none';	
}
function spanFormatCurrencyOnfocus(object) {
	if (object.parentNode.getElementsByTagName('span')[0]) 
		object.parentNode.getElementsByTagName('span')[0].style.display = 'inline'; 
		object.value=object.value.replace(/,/g,'');
}

/*-----------------------------------------------------*/
//Check tien te cung voi dau phay dong 

//load xml file
function loadXML() 
{
/*
	if (window.ActiveXObject){
	var xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
	xmlDoc.async=false; //Enforce download of XML file first. IE only.
	}
	else if (document.implementation && document.implementation.createDocument)
	var xmlDoc= document.implementation.createDocument("","doc",null);
	if (typeof xmlDoc!="undefined")
	//xmlDoc.load("dailynews.xml");
	xmlDoc.load(xmlFile);
*/
	if (window.XMLHttpRequest)
	  {
	  xhttp=new XMLHttpRequest();
	  }
	else // IE 5/6
	  {
	  xhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xhttp.open("GET","scripts/currCheck.xml",false);
	xhttp.send();
	xmlDoc=xhttp.responseXML; 

	//-------------------------------------
	var currCodes =new Array();
	if (typeof xmlDoc!="undefined"){
		if (window.ActiveXObject) //if IE, simply execute script (due to async prop).
		{
			currCodes=getCurrency(xmlDoc);
		}
		else //else if NS6, execute script when XML object has loaded
		{
			currCodes=xmlDoc.onload=getCurrency(xmlDoc);
		}
	}
	return currCodes;
}
function getCurrency(xmlDoc){
	//alert(xmlDoc);
	//Regular expression used to match any non-whitespace character
	var notWhitespace = /\S/;
	//Cache "messages" element of xml file
	var msgobj=xmlDoc.getElementsByTagName("Messages")[0];
	//REMOVE white spaces in XML file. Intended mainly for NS6/Mozilla
	for (var i=0;i<msgobj.childNodes.length;i++){
		if ((msgobj.childNodes[i].nodeType == 3)&&(!notWhitespace.test(msgobj.childNodes[i].nodeValue))) {
		// that is, if it's a whitespace text node
			msgobj.removeChild(msgobj.childNodes[i]);
			i--;
		}
	}

	//Mang luu tru tien te: (Loai tien, dau phay thap phan: USD,2)
	var currCode =new Array();
	for (i=0;i<msgobj.childNodes.length;i++){
		currCode[i]=xmlDoc.getElementsByTagName("Messages")[0].childNodes[i].firstChild.nodeValue;
	}

	//document.getElementById("container").innerHTML=
	//xmlDoc.getElementsByTagName("Messages")[0].childNodes[today].firstChild.nodeValue; //getAttribute("id")  //firstChild.text
	return currCode;
}
//Kiem tra tinh hop le cua viec nhap tien:
function checkCurrFractional(currCodeID,valueID)
{	
	var curr=document.getElementById(currCodeID).value;
	var object=document.getElementById(valueID);
	if (object.parentNode.getElementsByTagName('span')[0]) 
		object.parentNode.getElementsByTagName('span')[0].style.display = 'none';
	object.value=formatCurrency(object.value);
	if (object.value=="")return;
	
	if (curr=="")return;
	
	
	var currCodes =new Array();
	//currCodes[0]="USD;2"
	//currCodes[1]="JPY;0"
	currCodes=loadXML();//Doc file XML lay mang gia tri:
	
	for(var i=0;i<currCodes.length;i++)
	{
		var s=currCodes[i].split(";");
		if(curr==s[0])
		{
			var fract=object.value.split(".");
			if(fract[1]=="00") return;
			else
			{
				if(s[1]=="0")
				{
					alert("Loai tien ("+curr+") khong co phan thap phan");
					object.value=formatCurrency(fract[0]);
					object.focus();
					return;
				}
			}
		}
	}
}

//ket thuc check tien
//Kiem tra mat khau: chua ca chu va so

 function isValidPassword(text)
{
//	var chardigit='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789/-_/!/@/#/$/%/^/&/*/~/.';
//	var charset='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789/-_/!/@/#/$/%/^/&/*/~/.';
	var chardigit='0123456789';
	var charset='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz/-_/!/@/#/$/%/^/&/*/~/.';
	var i=0;
	var correctDigit='false';
    var correctChar='false';

	var ch;

	if (text.length < 6 || text.length > 20){
		alert('Mat khau phai co do dai tu 6 den 20 ky tu va chua ca chu lan so!');
		return false;
	}
    i=0;
    //Check ky tu
	while(i<text.length && correctChar=='false')
	{
		ch=text.charAt(i);
		if(charset.indexOf(ch)>-1)//Neu la chua ky tu
		    correctChar='true';
        i++;

	}//end of while

    //Check So
    while(i<text.length && correctDigit=='false' )
	{
          	ch=text.charAt(i);
            if(chardigit.indexOf(ch)>-1)   //Neu la chua so
		        correctDigit='true';
		i++;

	}//end of while


	if (correctChar=='true' && correctDigit=='true')
		return true;
	else{
		alert('Mat khau phai chua ca chu va so');
		return false;

	}
}//end of isValidPasswd(text)
//Chi cho phep nhap so

function numbersonly(myfield, e, dec)
{
	var key;
	var keychar;
	
	if (window.event)
	   key = window.event.keyCode;
	else if (e)
	   key = e.which;
	else
	   return true;
	keychar = String.fromCharCode(key);
	
	// control keys
	if ((key==null) || (key==0) || (key==8) || 
	    (key==9) || (key==13) || (key==27) )
	   return true;
	
	// numbers
	else if ((("0123456789").indexOf(keychar) > -1))
	   return true;
	
	// decimal point jump
	else if (dec && (keychar == "."))
	   {
	   myfield.form.elements[dec].focus();
	   return false;
	   }
	else
	   return false;
}
//Nhap loai tien te

function numbersCurrency(myfield, e, dec)
{
	var key;
	var keychar;
	
	if (window.event)
	   key = window.event.keyCode;
	else if (e)
	   key = e.which;
	else
	   return true;
	keychar = String.fromCharCode(key);
	
	// control keys
	if ((key==null) || (key==0) || (key==8) || 
	    (key==9) || (key==13) || (key==27) )
	   return true;
	
	// numbers
	else if ((("0123456789.").indexOf(keychar) > -1))
	   return true;
	
	// decimal point jump
	else if (dec && (keychar == "."))
	   {
	   myfield.form.elements[dec].focus();
	   return false;
	   }
	else
	   return false;
}
//Capslock detect

function capLock(e){ 
	kc = e.keyCode?e.keyCode:e.which;
	sk = e.shiftKey?e.shiftKey:((kc == 16)?true:false); 
	if(((kc >= 65 && kc <= 90) && !sk)||((kc >= 97 && kc <= 122) && sk))
		document.getElementById('divMayus').style.display = 'inline'; 
	else  
		document.getElementById('divMayus').style.display = 'none';
}

$.datepicker.regional['en'] = {clearText: 'Clear',
		clearStatus: 'Erase the current date',		
		closeText: 'Close',		
		closeStatus: 'Close without change',		
		prevText: '<Prev',		
		prevBigText: '<<',		
		prevStatus: 'Show the previous month',		
		prevBigStatus: 'Show the previous year',		
		nextText: 'Next>',		
		nextBigText: '>>',		
		nextStatus: 'Show the next month',		
		nextBigStatus: 'Show the next year',		
		currentText: 'Today',		
		currentStatus: 'Show the current month',		
		monthNames: ['January','February','March','April','May','June', 'July','August','September','October','November','December'],		
		monthNamesShort: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],		
		monthStatus: 'Show a different month',		
		yearStatus: 'Show a different year',		
		weekHeader: 'Wk',		
		weekStatus: 'Week of the year',		
		dayNames: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],		
		dayNamesShort: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],		
		dayNamesMin: ['Su','Mo','Tu','We','Th','Fr','Sa'],		
		dayStatus: 'Set DD as first week day',		
		dateStatus: 'Select D, M d',		
		dateFormat: 'dd/mm/yy',		
		firstDay: 0,		
		initStatus: 'Select a date',		
		isRTL: false};