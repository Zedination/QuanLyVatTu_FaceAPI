package com.devmaster.mvc.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Type;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.devmaster.mvc.entity.AjaxClient;
import com.devmaster.mvc.entity.DetectObj;
import com.devmaster.mvc.entity.ObjectSendToDetectApi;
import com.devmaster.mvc.entity.ResClient;
import com.devmaster.mvc.entity.ResponseObj;
import com.devmaster.mvc.entity.VerifiedObj;
import com.devmaster.mvc.entity.VerifyObjSendToAPI;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Controller
public class VerifyController {
	@GetMapping("/verify")
	public String getVerify() {
		return "qlvt/verify";
	}
//	không thể dùng @RequestParam("input1") String input1,@RequestParam("input2") String input2 vì khi sử dụng
//	Ajax upload data form có thể bị lỗi do có trường hợp không tồn tại param input1, input2
	@PostMapping("/verify")
	public ResponseEntity<?> postVerify(@RequestParam("files") MultipartFile[] files, HttpServletRequest request) throws ClientProtocolException, IOException, URISyntaxException, InterruptedException{
		Gson gson = new Gson();
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		String faceId1 = "";
		String faceId2 = "";
		for(int i =0;i<files.length;i++) {
			System.out.println(files[i].getOriginalFilename());
		}
		System.out.println(request.getParameter("input1"));
		System.out.println(request.getParameter("input2"));
		if(files.length==0) {
			ResponseObj res1 = detectUrl(request.getParameter("input1"));
			
			if(res1.getStatusCode()==200) {
				List<DetectObj> detectedList = new ArrayList<DetectObj>();
            	Type collectionType = new TypeToken<List<DetectObj>>(){}.getType();
            	
            	detectedList = gson.fromJson(res1.getResponseText(), collectionType);
            	if(detectedList.size()==1) {
            		for (DetectObj detectObj : detectedList) {
						faceId1= detectObj.getFaceId();
					}
            	}else if(detectedList.size()>1) {
            		return new ResponseEntity<String>("Có nhiều hơn 1 mặt người trong ảnh 1, vui lòng kiểm tra lại", responseHeaders ,HttpStatus.BAD_REQUEST);
            	}else {
            		return new ResponseEntity<String>("Không có mặt người trong ảnh 1, vui lòng kiểm tra lại", responseHeaders ,HttpStatus.BAD_REQUEST);
            	}
			}else {
				return new ResponseEntity<String>("Vượt quá số lượt gửi request trong 1 phút, vui lòng thử lại sau 3 phút!",responseHeaders , HttpStatus.BAD_REQUEST);
			}
			//Thread.sleep(3000);
			ResponseObj res2 = detectUrl(request.getParameter("input2"));
			
			if(res2.getStatusCode()==200) {
				List<DetectObj> detectedList = new ArrayList<DetectObj>();
            	Type collectionType = new TypeToken<List<DetectObj>>(){}.getType();
            	
            	detectedList = gson.fromJson(res2.getResponseText(), collectionType);
            	if(detectedList.size()==1) {
            		for (DetectObj detectObj : detectedList) {
						faceId2= detectObj.getFaceId();
					}
            	}else if(detectedList.size()>1) {
            		return new ResponseEntity<String>("Có nhiều hơn 1 mặt người trong ảnh 2, vui lòng kiểm tra lại",responseHeaders , HttpStatus.BAD_REQUEST);
            	}else {
            		return new ResponseEntity<String>("Không có mặt người trong ảnh 2, vui lòng kiểm tra lại",responseHeaders , HttpStatus.BAD_REQUEST);
            	}
			}else {
				return new ResponseEntity<String>("Vượt quá số lượt gửi request trong 1 phút, vui lòng thử lại sau 3 phút!",responseHeaders , HttpStatus.BAD_REQUEST);
			}
			//Thread.sleep(3000);
			ResponseObj res3 = verifyAPI(faceId1, faceId2);
			if(res3.getStatusCode()==200) {
				VerifiedObj obj = gson.fromJson(res3.getResponseText(), VerifiedObj.class);
				if(obj.getIsIdentical()==true) {
					//return new ResponseEntity<String>("So sánh thành công, Hai người vừa so sánh là cùng 1 người, độ giống nhau là "+obj.getConfidence(),responseHeaders , HttpStatus.OK);
					ResClient[] resClient1 = gson.fromJson(res1.getResponseText(), ResClient[].class);
					ResClient[] resClient2 = gson.fromJson(res2.getResponseText(), ResClient[].class);
					AjaxClient ajaxClient = new AjaxClient("So sánh thành công, Hai người vừa so sánh là cùng 1 người, độ giống nhau là "+obj.getConfidence(), resClient1[0], resClient2[0]);
					return new ResponseEntity<AjaxClient>(ajaxClient, HttpStatus.OK);
					
				}else {
					//return new ResponseEntity<String>("So sánh thành công, Hai người vừa so sánh là 2 người khác nhau, độ giống nhau là "+obj.getConfidence(),responseHeaders , HttpStatus.OK);
					ResClient[] resClient1 = gson.fromJson(res1.getResponseText(), ResClient[].class);
					ResClient[] resClient2 = gson.fromJson(res2.getResponseText(), ResClient[].class);
					AjaxClient ajaxClient = new AjaxClient("So sánh thành công, Hai người vừa so sánh là 2 người khác nhau, độ giống nhau là "+obj.getConfidence(), resClient1[0], resClient2[0]);
					return new ResponseEntity<AjaxClient>(ajaxClient, HttpStatus.OK);
				}
			}else {
				System.out.println(res3.getResponseText());
				return new ResponseEntity<String>("So sánh bị lỗi, vui lòng thử lại sau",responseHeaders , HttpStatus.BAD_REQUEST);
			}
		}else if(files.length==1&&request.getParameter("input1")==null) {
			ResponseObj res1 = new ResponseObj();
			for (MultipartFile multipartFile : files) {
				res1 = detectFile(multipartFile);
			}
			if(res1.getStatusCode()==200) {
				List<DetectObj> detectedList = new ArrayList<DetectObj>();
            	Type collectionType = new TypeToken<List<DetectObj>>(){}.getType();
            	
            	detectedList = gson.fromJson(res1.getResponseText(), collectionType);
            	if(detectedList.size()==1) {
            		for (DetectObj detectObj : detectedList) {
						faceId1= detectObj.getFaceId();
					}
            	}else if(detectedList.size()>1) {
            		return new ResponseEntity<String>("Có nhiều hơn 1 mặt người trong ảnh 1, vui lòng kiểm tra lại",responseHeaders , HttpStatus.BAD_REQUEST);
            	}else {
            		return new ResponseEntity<String>("Không có mặt người trong ảnh 1, vui lòng kiểm tra lại", responseHeaders ,HttpStatus.BAD_REQUEST);
            	}
			}else {
				return new ResponseEntity<String>("Vượt quá số lượt gửi request trong 1 phút, vui lòng thử lại sau 3 phút!",responseHeaders , HttpStatus.BAD_REQUEST);
			}
			//Thread.sleep(3000);
			ResponseObj res2 = detectUrl(request.getParameter("input2"));
			
			if(res2.getStatusCode()==200) {
				List<DetectObj> detectedList = new ArrayList<DetectObj>();
            	Type collectionType = new TypeToken<List<DetectObj>>(){}.getType();
            	
            	detectedList = gson.fromJson(res2.getResponseText(), collectionType);
            	if(detectedList.size()==1) {
            		for (DetectObj detectObj : detectedList) {
						faceId2= detectObj.getFaceId();
					}
            	}else if(detectedList.size()>1) {
            		return new ResponseEntity<String>("Có nhiều hơn 1 mặt người trong ảnh 2, vui lòng kiểm tra lại",responseHeaders , HttpStatus.BAD_REQUEST);
            	}else {
            		return new ResponseEntity<String>("Không có mặt người trong ảnh 2, vui lòng kiểm tra lại",responseHeaders , HttpStatus.BAD_REQUEST);
            	}
			}else {
				return new ResponseEntity<String>("Vượt quá số lượt gửi request trong 1 phút, vui lòng thử lại sau 3 phút!",responseHeaders , HttpStatus.BAD_REQUEST);
			}
			//Thread.sleep(3000);
			ResponseObj res3 = verifyAPI(faceId1, faceId2);
			if(res3.getStatusCode()==200) {
				VerifiedObj obj = gson.fromJson(res3.getResponseText(), VerifiedObj.class);
				if(obj.getIsIdentical()==true) {
					//return new ResponseEntity<String>("So sánh thành công, Hai người vừa so sánh là cùng 1 người, độ giống nhau là "+obj.getConfidence(),responseHeaders , HttpStatus.OK);
					ResClient[] resClient1 = gson.fromJson(res1.getResponseText(), ResClient[].class);
					ResClient[] resClient2 = gson.fromJson(res2.getResponseText(), ResClient[].class);
					AjaxClient ajaxClient = new AjaxClient("So sánh thành công, Hai người vừa so sánh là cùng 1 người, độ giống nhau là "+obj.getConfidence(), resClient1[0], resClient2[0]);
					return new ResponseEntity<AjaxClient>(ajaxClient, HttpStatus.OK);
				}else {
					//return new ResponseEntity<String>("So sánh thành công, Hai người vừa so sánh là 2 người khác nhau, độ giống nhau là "+obj.getConfidence(),responseHeaders , HttpStatus.OK);
					ResClient[] resClient1 = gson.fromJson(res1.getResponseText(), ResClient[].class);
					ResClient[] resClient2 = gson.fromJson(res2.getResponseText(), ResClient[].class);
					AjaxClient ajaxClient = new AjaxClient("So sánh thành công, Hai người vừa so sánh là 2 người khác nhau, độ giống nhau là "+obj.getConfidence(), resClient1[0], resClient2[0]);
					return new ResponseEntity<AjaxClient>(ajaxClient, HttpStatus.OK);
				}
			}else {
				return new ResponseEntity<String>("So sánh bị lỗi, vui lòng thử lại sau",responseHeaders , HttpStatus.BAD_REQUEST);
			}
		}else if(files.length==1&&request.getParameter("input2")==null) {
			ResponseObj res1 = detectUrl(request.getParameter("input1"));
			
			if(res1.getStatusCode()==200) {
				List<DetectObj> detectedList = new ArrayList<DetectObj>();
            	Type collectionType = new TypeToken<List<DetectObj>>(){}.getType();
            	
            	detectedList = gson.fromJson(res1.getResponseText(), collectionType);
            	if(detectedList.size()==1) {
            		for (DetectObj detectObj : detectedList) {
						faceId1= detectObj.getFaceId();
					}
            	}else if(detectedList.size()>1) {
            		return new ResponseEntity<String>("Có nhiều hơn 1 mặt người trong ảnh 1, vui lòng kiểm tra lại",responseHeaders , HttpStatus.BAD_REQUEST);
            	}else {
            		return new ResponseEntity<String>("Không có mặt người trong ảnh 1, vui lòng kiểm tra lại",responseHeaders , HttpStatus.BAD_REQUEST);
            	}
			}else {
				return new ResponseEntity<String>("Vượt quá số lượt gửi request trong 1 phút, vui lòng thử lại sau 3 phút!",responseHeaders , HttpStatus.BAD_REQUEST);
			}
			//Thread.sleep(3000);
			ResponseObj res2 = new ResponseObj();
			for (MultipartFile multipartFile : files) {
				res2 = detectFile(multipartFile);
			}
			
			if(res2.getStatusCode()==200) {
				List<DetectObj> detectedList = new ArrayList<DetectObj>();
            	Type collectionType = new TypeToken<List<DetectObj>>(){}.getType();
            	
            	detectedList = gson.fromJson(res2.getResponseText(), collectionType);
            	if(detectedList.size()==1) {
            		for (DetectObj detectObj : detectedList) {
						faceId2= detectObj.getFaceId();
					}
            	}else if(detectedList.size()>1) {
            		return new ResponseEntity<String>("Có nhiều hơn 1 mặt người trong ảnh 2, vui lòng kiểm tra lại",responseHeaders , HttpStatus.BAD_REQUEST);
            	}else {
            		return new ResponseEntity<String>("Không có mặt người trong ảnh 2, vui lòng kiểm tra lại",responseHeaders , HttpStatus.BAD_REQUEST);
            	}
			}else {
				return new ResponseEntity<String>("Vượt quá số lượt gửi request trong 1 phút, vui lòng thử lại sau 3 phút!",responseHeaders , HttpStatus.BAD_REQUEST);
			}
			//Thread.sleep(3000);
			ResponseObj res3 = verifyAPI(faceId1, faceId2);
			if(res3.getStatusCode()==200) {
				VerifiedObj obj = gson.fromJson(res3.getResponseText(), VerifiedObj.class);
				if(obj.getIsIdentical()==true) {
					//return new ResponseEntity<String>("So sánh thành công, Hai người vừa so sánh là cùng 1 người, độ giống nhau là "+obj.getConfidence(),responseHeaders , HttpStatus.OK);
					ResClient[] resClient1 = gson.fromJson(res1.getResponseText(), ResClient[].class);
					ResClient[] resClient2 = gson.fromJson(res2.getResponseText(), ResClient[].class);
					AjaxClient ajaxClient = new AjaxClient("So sánh thành công, Hai người vừa so sánh là cùng 1 người, độ giống nhau là "+obj.getConfidence(), resClient1[0], resClient2[0]);
					return new ResponseEntity<AjaxClient>(ajaxClient, HttpStatus.OK);
				}else {
					//return new ResponseEntity<String>("So sánh thành công, Hai người vừa so sánh là 2 người khác nhau, độ giống nhau là "+obj.getConfidence(),responseHeaders , HttpStatus.OK);
					ResClient[] resClient1 = gson.fromJson(res1.getResponseText(), ResClient[].class);
					ResClient[] resClient2 = gson.fromJson(res2.getResponseText(), ResClient[].class);
					AjaxClient ajaxClient = new AjaxClient("So sánh thành công, Hai người vừa so sánh là 2 người khác nhau, độ giống nhau là "+obj.getConfidence(), resClient1[0], resClient2[0]);
					return new ResponseEntity<AjaxClient>(ajaxClient, HttpStatus.OK);
				}
			}else {
				return new ResponseEntity<String>("So sánh bị lỗi, vui lòng thử lại sau",responseHeaders , HttpStatus.BAD_REQUEST);
			}
		}else {
			ResponseObj res1 = detectFile(files[0]);
			//Thread.sleep(3000);
			if(res1.getStatusCode()==200) {
				List<DetectObj> detectedList = new ArrayList<DetectObj>();
            	Type collectionType = new TypeToken<List<DetectObj>>(){}.getType();
            	
            	detectedList = gson.fromJson(res1.getResponseText(), collectionType);
            	if(detectedList.size()==1) {
            		for (DetectObj detectObj : detectedList) {
						faceId1= detectObj.getFaceId();
					}
            	}else if(detectedList.size()>1) {
            		return new ResponseEntity<String>("Có nhiều hơn 1 mặt người trong ảnh 1, vui lòng kiểm tra lại",responseHeaders , HttpStatus.BAD_REQUEST);
            	}else {
            		return new ResponseEntity<String>("Không có mặt người trong ảnh 1, vui lòng kiểm tra lại",responseHeaders , HttpStatus.BAD_REQUEST);
            	}
			}else {
				return new ResponseEntity<String>("Vượt quá số lượt gửi request trong 1 phút, vui lòng thử lại sau 3 phút!",responseHeaders , HttpStatus.BAD_REQUEST);
			}
			ResponseObj res2 = detectFile(files[1]);
			//Thread.sleep(3000);
			if(res2.getStatusCode()==200) {
				List<DetectObj> detectedList = new ArrayList<DetectObj>();
            	Type collectionType = new TypeToken<List<DetectObj>>(){}.getType();
            	
            	detectedList = gson.fromJson(res2.getResponseText(), collectionType);
            	if(detectedList.size()==1) {
            		for (DetectObj detectObj : detectedList) {
						faceId2= detectObj.getFaceId();
					}
            	}else if(detectedList.size()>1) {
            		return new ResponseEntity<String>("Có nhiều hơn 1 mặt người trong ảnh 2, vui lòng kiểm tra lại",responseHeaders , HttpStatus.BAD_REQUEST);
            	}else {
            		return new ResponseEntity<String>("Không có mặt người trong ảnh 2, vui lòng kiểm tra lại",responseHeaders , HttpStatus.BAD_REQUEST);
            	}
			}else {
				return new ResponseEntity<String>("Vượt quá số lượt gửi request trong 1 phút, vui lòng thử lại sau 3 phút!",responseHeaders , HttpStatus.BAD_REQUEST);
			}
			ResponseObj res3 = verifyAPI(faceId1, faceId2);
			if(res3.getStatusCode()==200) {
				VerifiedObj obj = gson.fromJson(res3.getResponseText(), VerifiedObj.class);
				if(obj.getIsIdentical()==true) {
					//return new ResponseEntity<String>("So sánh thành công, Hai người vừa so sánh là cùng 1 người, độ giống nhau là "+obj.getConfidence(),responseHeaders , HttpStatus.OK);
					ResClient[] resClient1 = gson.fromJson(res1.getResponseText(), ResClient[].class);
					ResClient[] resClient2 = gson.fromJson(res2.getResponseText(), ResClient[].class);
					AjaxClient ajaxClient = new AjaxClient("So sánh thành công, Hai người vừa so sánh là cùng 1 người, độ giống nhau là "+obj.getConfidence(), resClient1[0], resClient2[0]);
					return new ResponseEntity<AjaxClient>(ajaxClient, HttpStatus.OK);
				}else {
					//return new ResponseEntity<String>("So sánh thành công, Hai người vừa so sánh là 2 người khác nhau, độ giống nhau là "+obj.getConfidence(),responseHeaders , HttpStatus.OK);
					ResClient[] resClient1 = gson.fromJson(res1.getResponseText(), ResClient[].class);
					ResClient[] resClient2 = gson.fromJson(res2.getResponseText(), ResClient[].class);
					AjaxClient ajaxClient = new AjaxClient("So sánh thành công, Hai người vừa so sánh là 2 người khác nhau, độ giống nhau là "+obj.getConfidence(), resClient1[0], resClient2[0]);
					return new ResponseEntity<AjaxClient>(ajaxClient, HttpStatus.OK);
				}
			}else {
				return new ResponseEntity<String>("So sánh bị lỗi, vui lòng thử lại sau",responseHeaders , HttpStatus.BAD_REQUEST);
			}
		}
	}
	public ResponseObj detectUrl(String url) throws ClientProtocolException, IOException, URISyntaxException {
		HttpClient httpclient = HttpClients.createDefault();
		Gson gson = new Gson();
		URIBuilder builder = new URIBuilder("https://nhandienkhuonmat.cognitiveservices.azure.com/face/v1.0/detect");

        builder.setParameter("returnFaceId", "true");
        builder.setParameter("returnFaceLandmarks", "false");
        builder.setParameter("recognitionModel", "recognition_02");
        builder.setParameter("returnRecognitionModel", "false");
        builder.setParameter("detectionModel", "detection_02");

        URI uri = builder.build();
        HttpPost apiRequest = new HttpPost(uri);
        apiRequest.setHeader("Content-Type", "application/json");
        apiRequest.setHeader("Ocp-Apim-Subscription-Key", "2584c2d2b3424fd9a1f589710b124690");
        ObjectSendToDetectApi objectSendToDetectApi = new ObjectSendToDetectApi(url);
        String requestBody = gson.toJson(objectSendToDetectApi);
        StringEntity reqEntity = new StringEntity(requestBody);
        apiRequest.setEntity(reqEntity);

        HttpResponse detectResponse = httpclient.execute(apiRequest);
        String json1 = IOUtils.toString(detectResponse.getEntity().getContent(), "UTF-8");
        return new ResponseObj(json1,(int)detectResponse.getStatusLine().getStatusCode());
	}
	public ResponseObj detectFile(MultipartFile file) throws URISyntaxException, IOException {
		HttpClient httpclient = HttpClients.createDefault();
		URIBuilder builder = new URIBuilder("https://nhandienkhuonmat.cognitiveservices.azure.com/face/v1.0/detect");

        builder.setParameter("returnFaceId", "true");
        builder.setParameter("returnFaceLandmarks", "false");
        builder.setParameter("recognitionModel", "recognition_02");
        builder.setParameter("returnRecognitionModel", "false");
        builder.setParameter("detectionModel", "detection_02");

        URI uri = builder.build();
        HttpPost apiRequest = new HttpPost(uri);
        apiRequest.setHeader("Content-Type", "application/octet-stream");
        apiRequest.setHeader("Ocp-Apim-Subscription-Key", "2584c2d2b3424fd9a1f589710b124690");
        ByteArrayEntity reqEntity = new ByteArrayEntity(file.getBytes(), ContentType.APPLICATION_OCTET_STREAM);
        apiRequest.setEntity(reqEntity);

        HttpResponse detectResponse = httpclient.execute(apiRequest);
//        HttpEntity entity = detectResponse.getEntity();
        String json1 = IOUtils.toString(detectResponse.getEntity().getContent(), "UTF-8");
        return new ResponseObj(json1,(int)detectResponse.getStatusLine().getStatusCode());
	}
	public ResponseObj verifyAPI(String faceId1, String faceId2) throws URISyntaxException, ClientProtocolException, IOException {
		HttpClient httpclient = HttpClients.createDefault();
		Gson gson = new Gson();
		URIBuilder builder = new URIBuilder("https://nhandienkhuonmat.cognitiveservices.azure.com/face/v1.0/verify");
        URI uri = builder.build();
        HttpPost apiRequest = new HttpPost(uri);
        apiRequest.setHeader("Content-Type", "application/json");
        apiRequest.setHeader("Ocp-Apim-Subscription-Key", "2584c2d2b3424fd9a1f589710b124690");
        VerifyObjSendToAPI verifyObjSendToAPI = new VerifyObjSendToAPI(faceId1,faceId2);
        System.out.println(verifyObjSendToAPI.toString());
        String requestBody = gson.toJson(verifyObjSendToAPI);
        StringEntity reqEntity = new StringEntity(requestBody);
        apiRequest.setEntity(reqEntity);

        HttpResponse detectResponse = httpclient.execute(apiRequest);
        String json = IOUtils.toString(detectResponse.getEntity().getContent(), "UTF-8");
        return new ResponseObj(json,(int)detectResponse.getStatusLine().getStatusCode());
	}
}
