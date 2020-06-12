package com.devmaster.mvc.util;

import java.lang.reflect.Type;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
  
public class JsonUtil {  
  
    /** 
     * Null serialize is used because else Gson will ignore all null fields. 
     */  
    private static Gson gson = new GsonBuilder().serializeNulls().create();  
  
    /** 
     * Made private because all methods are static and hence do not need 
     * object instantiation 
     */  
    private JsonUtil() {}  
    /** 
     * To Json Converter using Goolge's Gson Package 
 
     * this method converts a simple object to a json string 
 
     *  
     * @param obj 
     * @return a json string 
     */  
    public static <T> String toJsonObj(T obj) {  
        return gson.toJson(obj);  
    }  
  
    /** 
     * Converts a collection of objects using Google's Gson Package 
     *  
     * @param objCol 
     * @return a json string array 
     */  
    public static <T> String toJsonList(List<T> objCol) {  
        return gson.toJson(objCol);  
    }  
  
    /** 
     * Returns the specific object given the Json String 
     * @param <T> 
     * @param jsonString 
     * @param obj 
     * @return a specific object as defined by the user calling the method 
     */  
    public static <T> T fromJsonToObj(String jsonString,Class<T>obj) {  
        return gson.fromJson(jsonString, obj);  
    }  
      
    /** 
     * Returns a list of specified object from the given json array 
     * @param <T> 
     * @param jsonString 
     * @param t the type defined by the user 
     * @return a list of specified objects as given in the json array 
     */  
    public static <T> List<T> fromJsonToList(String jsonString,Type t){   
        return gson.fromJson(jsonString, t);  
    }  
  
    public static String toHTML(String unicode) {
		if (unicode == null)
			return " ";
		if (unicode.equals(""))
			return " ";
		String output = "";
		char[] charArray = unicode.toCharArray();

		for (int i = 0; i < charArray.length; ++i) {
			char a = charArray[i];
			if ((int) a > 128) {
				output += "&#" + (int) a + ";";
			} else {
				output += a;
			}
			// Special Characters
			if (a == '&')
				output = output.substring(0, output.length() - 1) + "&amp;";
			if (a == '<')
				output = output.substring(0, output.length() - 1) + "&lt;";
			if (a == '>')
				output = output.substring(0, output.length() - 1) + "&gt;";
			if (a == '"')
				output = output.substring(0, output.length() - 1) + "&quot;";
			if (a == '\'')
				output = output.substring(0, output.length() - 1) + "&#39;";
		}
		return output;
	}
}  