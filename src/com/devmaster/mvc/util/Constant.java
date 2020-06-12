package com.devmaster.mvc.util;

import java.util.HashMap;
import java.util.Map;

public class Constant {
	public static final String APP_NAME = "TEN CHUONG TRINH";
	public static final String APP_VERSION = "1.0.0";
	
	public static final String SESSION_ROLES = "session_roles";
	public static final String SESSION_CURRENT_USER = "session_current_user";
	public static final String SESSION_FUNCTION_LIST = "session_function_list";
	public static final String SESSION_TIMEOUT = "Bạn đã hết phiên làm việc! Vui lòng đăng nhập lại.";
	
	public static final String RETURN_FAIL = "failed";
	public static final String RETURN_SUCCESS = "success";
	public static final String XML_HEADER = "<?xml version='1.0' encoding=\"utf-8\"?>";
	public static final String CONTENT_TYPE_XML = "text/xml; charset=UTF-8";
	public static final String CONTENT_TYPE_TEXT = "text/plaint; charset=UTF-8";
	public static final String CONTENT_TYPE_JSON = "text/json; charset=utf-8";
	
	public static final String NO_PERMISSION = "Vui lòng ấn F5 để thực hiện chức năng này!";
	
	public static final String CODE_SUCCESS = "000";
	public static final String MSG_SUCCESS = "success";
	public static final String FORMAT_PDF_PREVIEW = "PDF_PREVIEW";
	public static final String FORMAT_PDF = "PDF";
	public static final String FORMAT_DOC = "DOC";
	public static final String FORMAT_XLS = "XLS";
	public static final String CONTENT_TYPE_PDF_VIEWONJSP = "application/pdf";
	public static final String CONTENT_TYPE_PDF_SAVEDIALOG = "application/pdf";
	public static final String CONTENT_TYPE_DOC = "application/doc";
	public static final String CONTENT_TYPE_XLS = "application/xls";
	public static String CONNECTED_USER;
	public static Map<String, String> listUserOnline = new HashMap<String, String>();
}
