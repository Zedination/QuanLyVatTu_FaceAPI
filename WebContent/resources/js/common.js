var cuaSoXemGiaoDich;
function gotoElement(elementId){
    var el = document.getElementById(elementId);
    if (el != null)
    {        
       el.scrollIntoView();
       el.focus();
    }
 }
function goToPageElement(idname)
{
	if (document.getElementById)
	{
		return document.getElementById(idname);
	}
	else if (document.all)
	{
		return document.all[idname];
	}
	else if (document.layers)
	{
		return document.layers[idname];
	}
	else
	{
		return null;
	}
}
function formatDateInput(txt){
	if(txt.value.length>10){
		txt.value=txt.value.substring(0,10);
		return;
	}
	if(txt.value.length==2 && (txt.value.indexOf("/")==-1)){
		txt.value+="/";
	}
	if(txt.value.length==5 && (txt.value.substr(txt.value.length-1)!="/"))
		txt.value+="/";
}
function openPageXemGiaoDich(url){
    var abc=window.open('','CuaSoXemGiaoDich','width=900,height=800,location=yes,directories=yes,menubar=yes,resizable=yes,scrollbars=yes');
    abc.focus();
    abc.location.href=url;
    return false;
}
function openPageXemGiaoDichRefresh(tag,url){
    var cu = document.getElementById(tag).parentNode.parentNode;
    var abc=window.open('','CuaSoXemGiaoDich','width=700,height=550,location=yes,directories=yes,menubar=yes,resizable=yes,scrollbars=yes');
    abc.location.href=url;
    window.location = window.location;
    abc.focus();
    return false;
}
function formatTien(txtId)
{
	var nStr = '';
	nStr+=txtId.value;
	while(nStr.indexOf(',')>=0){
		nStr=nStr.replace(',','');	
	}
	nStr=nStr.replace(' ','');
	if(isNaN(nStr)){
		alert('Ban phai nhap so vao day');
		return;
	}
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)){
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	txtId.value=x1 + x2;
}
function refreshParent(){
	window.opener.location.reload(false);
}
//ham nay lay gia tri giua 2 the cua 1 chuoi text co dinh dang xml
function getValueOfTag(xmlString,openTag, closeTag){
	var kq="";
	try {
		kq=xmlString.substr(xmlString.indexOf(openTag)+openTag.length,xmlString.indexOf(closeTag)-xmlString.indexOf(openTag)+1-closeTag.length);
	}
	catch(exception){
	    kq="";
	}
	finally {
	}
	return kq;
}