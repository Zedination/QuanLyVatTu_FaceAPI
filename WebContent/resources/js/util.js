/**
 * 
 */
function endsWith(str, suffix) {
    return str.indexOf(suffix, str.length - suffix.length) !== -1;
}
 function removeHTMLTags(htmlString){
     if(htmlString){
       var mydiv = document.createElement("div");
        mydiv.innerHTML = htmlString;

         if (document.all) // IE Stuff
         {
             return mydiv.innerText;
            
         }   
         else // Mozilla does not work with innerText
         {
             return mydiv.textContent;
         }                           
   }
} 
 
 function getValueFromDiv(mydiv){     
         if (document.all) // IE Stuff
         {
             return mydiv.innerText;
            
         }   
         else // Mozilla does not work with innerText
         {
             return mydiv.textContent;
         }                              
} 
 
 function encodeHTML(str){
	 var aStr = str.split(''),
	     i = aStr.length,
	     aRet = [];

	   while (--i) {
	    var iC = aStr[i].charCodeAt();
	    if (iC < 65 || iC > 127 || (iC>90 && iC<97)) {
	      aRet.push('&#'+iC+';');
	    } else {
	      aRet.push(aStr[i]);
	    }
	  }
	 return aRet.reverse().join('');
	}
 function  trim(stringToTrim) 
 {
 	return stringToTrim.replace(/^\s+|\s+$/g,"");
 }	
 
 function replace(s, old, rep)
 {
 	while (s.indexOf(old) > -1)
 	{
 		s = s.replace(old, rep);
 	}
 	return s;
 }
 
 function formatDDMMYYYY(value) {
	 try
	 {
		value = trim(value);
		if (value =="") return value;
	    var y = value.substring(0,4);
	    var m = value.substring(5,7);
	    var d = value.substring(8,10);
	    return d+'/'+m+'/'+y;
	 }
	 catch(err)
	 {
		return value;
	 }

	}
 /*--------------Convert to Unicode------------------------*/
 
 function escapeToUtf16(str)
 {
     var escaped="";
     for(var i=0;i<str.length;++i)
     {
         var hex=str.charCodeAt(i).toString(16).toUpperCase();
         escaped+="\\u"+"0000".substr(hex.length)+hex;
     }
         return escaped;
  }
 function convertUtf16CodesToString(utf16_codes)
 {
     var unescaped='';
     for(var i=0;i<utf16_codes.length;++i)
     {
         unescaped+=String.fromCharCode(utf16_codes[i]);
     }
     return unescaped;
  }
 function convertEscapedCodesToCodes(str,prefix,base,num_bits)
 {
     var parts=str.split(prefix);
     parts.shift();
     var codes=[];
     var max=Math.pow(2,num_bits);
     for(var i=0;i<parts.length;++i)
     {
        var code=parseInt(parts[i],base);
        if(code>=0&&code<max)
        {
             codes.push(code);
        }else{}
     }
     return codes;
  }
 function convertEscapedUtf16CodesToUtf16Codes(str)
 {
     return convertEscapedCodesToCodes(str,"\\u",16,16);
 }
 function unescapeFromUtf16(str)
 {
     var utf16_codes=convertEscapedUtf16CodesToUtf16Codes(str);
      return convertUtf16CodesToString(utf16_codes);
 }
 /*--------------------------------------------------------*/
 
 /*----------------------Check Sesion-----------------------*/
 var interval;
 function init()
 {
     interval = setInterval(checkSession,3000);
 }
 function get_random()
 {
     var ranNum= Math.floor(Math.random()*14665349);
     return ranNum;
 }
 /*---------------------End check session-----------------*/
 
 
 /*-------------Numberic only for text */

 function isNumberKey(evt)
 {
    var charCode = (evt.which) ? evt.which : event.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57))
       return false;

    return true;
 }

 function toNumber(string) 
 {
	 if(string == null || string == undefined) return 0;
	 string = string.split(',').join('');
	 if(string == '' || isNaN(string)) return 0;
	 return parseFloat(string);	 
 }

 jQuery(document).ready(function(){
 	var lc = window.location.pathname;
 	 lc = lc.substring(0, lc.substring(1, lc.length).indexOf('/') + 1);
	 $('body').append('<div id="ajax_lock" style="position:fixed;left:0px;top:0px;z-index:400;width:100%;height:100%;display:none;background-image: url(' 
			 	+ lc + '/images/ajax-lock.png);"><div style="margin-top:' + ($(window).height()/2 - 50) 
			 	+ 'px;margin-left:' + ($(window).width()/2 - 50) + 'px;"><img src="' + lc + '/images/ajax-loading.gif"/></div></div>');
 });
 
 function ajaxLoading() {
 	$('#ajax_lock').show();
 }
 
 function ajaxLoaded() {
 	$('#ajax_lock').hide();
 }
 function getTag(source, begin, end) {
		s = source.split(begin);
		s = s[1].split(end);
		if (s[0] == "")
			s[0] = " ";
		//return (s[0]).trim();
		return $.trim(s[0]);
}

 var trangThaiStr = ["", "Tạo mới", "Chờ duyệt", "Đã duyệt", "Từ chối duyệt", "Hủy duyệt", "Đã Chốt"];

 function isDate(txtDate) { //MM/yyyy
     var objDate,  // date object initialized from the txtDate string
         mSeconds, // txtDate in milliseconds
         month,    // month
         year;     // year
     if (txtDate.length !== 7) {
         return false;
     }
     if (txtDate.substring(4, 5) !== '/') {
         return false;
     }
     month = txtDate.substring(5, 7) - 1;
     year = txtDate.substring(0, 4) - 0;
     if (year < 1000 || year > 3000) {
         return false;
     }
     mSeconds = (new Date(year, month, 1)).getTime();
     objDate = new Date();
     objDate.setTime(mSeconds);
     if (objDate.getFullYear() !== year ||
         objDate.getMonth() !== month) {
         return false;
     }
     return true;
 };
 /*---------------------------------------*/
 


 function getCellValue(rowId, cellId) {
     var cell = jQuery('#' + rowId + '_' + cellId);        
     var val = cell.val();
    	return val;
 }

 function setCellValue(rowId, cellId, value) {
     var cell = jQuery('#' + rowId + '_' + cellId);
     cell.val(value);
 }
 
 var isNumeric = function(nr){
		return ( (typeof (nr) === typeof(1)) && (null !== nr) && isFinite(nr));
};



function isLunarDate(ExpiryDate) {  //dd/MM/yyyy
    if (ExpiryDate.length !== 10) { 
        return false; 
    } 
    if (ExpiryDate.substring(2, 3) !== '/' || ExpiryDate.substring(5, 6) !== '/') { 
        return false; 
    } 
    day = ExpiryDate.substring(0, 2) - 0;
    month = ExpiryDate.substring(3, 5) - 0; 
    year = ExpiryDate.substring(6, 10) - 0; 
    if (year < 1000 || year > 3000) { 
        return false; 
    } 
    if (month < 1 || month > 12) { 
        return false; 
    } 
    if (day < 1 || day > 31) { 
        return false; 
    } 
    // otherwise return true 
    return true; 
}


function string2Date(date){//dd/MM/yyyy
	   var parts = date.split("/");
	   return new Date(parts[2], parts[1] - 1, parts[0]);
}

function startsWith(data, subData) {
	return data.indexOf(subData) == 0;
}

function fourdigits(number) {
	 return (number < 1000) ? number + 1900 : number;
}

function checkFuction(roles) {
	var collection = document.getElementsByName('menulink');
	var length = collection.length-1;
	for (var i=length; i>=0; i--) 
	{
		if(roles.toUpperCase().indexOf(collection[i].id.toUpperCase()) > -1)
		{ 
			collection[i].style.display = "";
		}
		else
		{
			collection[i].style.display = "none";
			//alert(collection[i].id);				
			//($("#" + collection[i].id).parent()).remove();
			//length--;
		}
	}
}

function checkSubFunc(subFunc) {
	var collection = document.getElementsByName('subfunc');
	if(subFunc.length <= 0) subFunc = ''; 
	if (collection.length > 0)
	{
		var length = collection.length-1;
		for (var i = length; i>=0; i--) 
		{
			if(subFunc.indexOf(collection[i].id) > -1)
			{ 
				collection[i].style.display = "";
			}
			else
			{
				$("#" + collection[i].id).remove();
				length--;	
			}
		}
	}
}

function checkUserHsc(bdscode)
{
	var r = false;
	if(bdscode=="" || bdscode == null)
	{
		r=false;
	}else{
		if(bdscode=="99011044")
		{
			r = true;
		}
	}
	return r;
}