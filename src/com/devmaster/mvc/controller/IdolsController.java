package com.devmaster.mvc.controller;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.lang.reflect.Type;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.io.IOUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.Candidates;
import com.devmaster.mvc.entity.DetectObj;
import com.devmaster.mvc.entity.IdentitiedObj;
import com.devmaster.mvc.entity.IdentityObjSendToApi;
import com.devmaster.mvc.entity.JQGridDTO;
import com.devmaster.mvc.entity.MyFile;
import com.devmaster.mvc.entity.ObjectSendToDetectApi;
import com.devmaster.mvc.entity.IdolsDTO;
import com.devmaster.mvc.jdbc.IdolsJdbc;
import com.devmaster.mvc.util.Constant;
import com.devmaster.mvc.util.JasperUtil;
import com.devmaster.mvc.util.JsonUtil;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Controller
public class IdolsController extends AbstractController {
	@RequestMapping(value = "/diemdanh", method = RequestMethod.GET)
	public String viewListIdols(Model model) {
		return "qlvt/diemdanh";
	}
	
	
	@RequestMapping("/listIdols")
	public void listBranch(HttpServletRequest request, HttpServletResponse response) {
		IdolsDTO listIdols = new IdolsDTO();
		initGetDTO(listIdols, request);
		JQGridDTO<IdolsDTO> gridData = new IdolsJdbc().listIdol(listIdols);
		
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(gridData));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
//	@RequestMapping(value = "/createVatTu", method = RequestMethod.POST)
//	public void createBranch(HttpServletRequest request, HttpServletResponse response) {
//		IdolsDTO postDTO = new IdolsDTO();
//		initPostDTO(postDTO, request);
//		AjaxResponseBody reponse = new IdolsJdbc().createBranch(postDTO);
//		try {
//			response.setContentType(Constant.CONTENT_TYPE_JSON);
//			response.getWriter().write(JsonUtil.toJsonObj(reponse));
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//	}
	@RequestMapping(value = "/updateIdols", method = RequestMethod.POST)
	public void updateBranch(HttpServletRequest request, HttpServletResponse response) {
		IdolsDTO postDTO = new IdolsDTO();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new IdolsJdbc().updateIdols(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/resetDiemDanh", method = RequestMethod.POST)
	public void resetDiemDanh(HttpServletRequest request, HttpServletResponse response) {
		AjaxResponseBody reponse = new IdolsJdbc().resetDiemDanh();
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public void initPostDTO(IdolsDTO postDTO, HttpServletRequest request) {
		postDTO.setPersonId(request.getParameter("personId"));
//		postDTO.setName(request.getParameter("name"));
//		postDTO.setUserData(request.getParameter("userData"));
		postDTO.setDiemDanh(request.getParameter("diemDanh"));
	}
	
	
	public void initGetDTO(IdolsDTO searchDTO, HttpServletRequest request) {
		super.initGetDTO(searchDTO, request);
		searchDTO.setPersonId(request.getParameter("personId"));
		searchDTO.setName(request.getParameter("name"));
	}
//	@RequestMapping(value = "/deleteVatTu", method = RequestMethod.POST)
//	public void deleteBranch(HttpServletRequest request, HttpServletResponse response) {
//		IdolsDTO postDTO = new IdolsDTO();
//		initPostDTO(postDTO, request);
//		AjaxResponseBody reponse = new IdolsJdbc().deleteBranch(postDTO);
//		try {
//			response.setContentType(Constant.CONTENT_TYPE_JSON);
//			response.getWriter().write(JsonUtil.toJsonObj(reponse));
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//	}
	
	@RequestMapping("/rptIdols")
	public void rptIdols(HttpServletRequest request, HttpServletResponse response) {
		
		try {
			Map<String, Object> param = new HashMap<String, Object>();
			System.out.println(request.getParameter("personId"));
			param.put("id", request.getParameter("personId"));
			param.put("name", request.getParameter("name"));
			JasperUtil.createReport("vav-idols-report-recognition_02", param, Constant.FORMAT_XLS, request, response);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/nhandien-url", method = RequestMethod.POST)
	public void nhandien_url(HttpServletRequest request, HttpServletResponse response) {
		HttpClient httpclient = HttpClients.createDefault();
		Gson gson = new Gson();
		AjaxResponseBody res = new AjaxResponseBody();
        try
        {
            URIBuilder builder = new URIBuilder("https://nhandienkhuonmat.cognitiveservices.azure.com/face/v1.0/detect");

            builder.setParameter("returnFaceId", "true");
            builder.setParameter("returnFaceLandmarks", "false");
//            builder.setParameter("returnFaceAttributes", "{string}");
            builder.setParameter("recognitionModel", "recognition_02");
            builder.setParameter("returnRecognitionModel", "false");
            builder.setParameter("detectionModel", "detection_02");

            URI uri = builder.build();
            HttpPost apiRequest = new HttpPost(uri);
            apiRequest.setHeader("Content-Type", "application/json");
            apiRequest.setHeader("Ocp-Apim-Subscription-Key", "2584c2d2b3424fd9a1f589710b124690");
            ObjectSendToDetectApi objectSendToDetectApi = new ObjectSendToDetectApi(request.getParameter("url"));
            String requestBody = gson.toJson(objectSendToDetectApi);
            System.out.println(request.getParameter("url"));
//            String requestBody = request.getParameter("url").toString();
//            String requestBody = "{ \"url\": \"https://image2.tienphong.vn/w665/Uploaded/2020/bpivpvoi/2019_11_16/ngoc_trinh_2_gygb.jpg\" }";
            // Request body
            StringEntity reqEntity = new StringEntity(requestBody);
            apiRequest.setEntity(reqEntity);

            HttpResponse detectResponse = httpclient.execute(apiRequest);
//            HttpEntity entity = detectResponse.getEntity();
            String json1 = IOUtils.toString(detectResponse.getEntity().getContent(), "UTF-8");
            //Thread.sleep(3100);
            if (!json1.equals("[]")&&(int)detectResponse.getStatusLine().getStatusCode() == 200)
            {
            	System.out.println("json1 : "+json1);
//                System.out.println(EntityUtils.toString(entity));
                System.out.println(detectResponse.getStatusLine().getStatusCode());
                if((int)detectResponse.getStatusLine().getStatusCode() == 200) {
                	
                	List<DetectObj> detectedList = new ArrayList<DetectObj>();
                	Type collectionType = new TypeToken<List<DetectObj>>(){}.getType();
                	
                	detectedList = gson.fromJson(json1, collectionType);
                	List<String> listFaceId = new ArrayList<String>();
                	for (DetectObj detectObj : detectedList) {
						listFaceId.add(detectObj.getFaceId());
					}
                	IdentityObjSendToApi identityObjSendToApi = new IdentityObjSendToApi("vav-idols-02",listFaceId, 1);
                	String bodyForIdentity = gson.toJson(identityObjSendToApi);
                	try
                    {
                        URIBuilder identityBuilder = new URIBuilder("https://nhandienkhuonmat.cognitiveservices.azure.com/face/v1.0/identify");


                        URI uri1 = identityBuilder.build();
                        HttpPost request1 = new HttpPost(uri1);
                        request1.setHeader("Content-Type", "application/json");
                        request1.setHeader("Ocp-Apim-Subscription-Key", "2584c2d2b3424fd9a1f589710b124690");


                        // Request body
                        StringEntity reqEntityForIdentity = new StringEntity(bodyForIdentity);
                        request1.setEntity(reqEntityForIdentity);

                        HttpResponse identityResponse = httpclient.execute(request1);
                        String json2 = IOUtils.toString(identityResponse.getEntity().getContent(), "UTF-8");
//                        HttpEntity entity1 = identityResponse.getEntity();

                        if (json2 != null&&(int)identityResponse.getStatusLine().getStatusCode() == 200)
                        {
                        	System.out.println("json2 : "+json2);
//                            System.out.println(EntityUtils.toString(entity1));
                            System.out.println(identityResponse.getStatusLine().getStatusCode());
                            if((int)identityResponse.getStatusLine().getStatusCode() == 200) {
                            	List<IdentitiedObj> identitiedObj = new ArrayList<IdentitiedObj>();
                            	Type collectionType2 = new TypeToken<List<IdentitiedObj>>(){}.getType();
                            	identitiedObj = gson.fromJson(json2, collectionType2);
//                            	IdentitiedObj identitiedObj = gson.fromJson(json2, IdentitiedObj.class);
                            	System.out.println(identitiedObj.toString());
                            	int flag = 0;
                            	for (IdentitiedObj identitiedObj2 : identitiedObj) {
									for (Candidates test : identitiedObj2.getCandidates()) {
										
										try {
											if(Float.valueOf(test.getConfidence()) >= 0.5) {
												res = new IdolsJdbc().updateIdols_API(test.getPersonId());
												System.out.println(test.getPersonId()+"\n"+test.getConfidence());
												flag++;
											}
										} catch (Exception e) {
											e.printStackTrace();
											System.out.println(e.getMessage());
											res.setCode("999");
											res.setMsg(e.getMessage());
										}
										
									}
								}
                            	if(flag == 0) {
                            		res.setCode("999");
                            		res.setMsg("Không thể nhận diện (Identity) được bất kỳ ai. Có thể trong ảnh của bạn không có ai nằm trong danh sách bên dưới!");
                            	}
                            }else {
                            	res.setCode(String.valueOf(identityResponse.getStatusLine().getStatusCode()));
                            	res.setMsg("Nhận diện (Identity) khuôn mặt bị lỗi: "+identityResponse.getStatusLine().toString());
                            }
                        }else {
                        	res.setCode(String.valueOf(identityResponse.getStatusLine().getStatusCode()));
                        	res.setMsg("Nhận diện (Identity) khuôn mặt bị lỗi: "+identityResponse.getStatusLine().toString()+"\n Có thể do ảnh không có mặt người");
                        }
                    }
                    catch (Exception e)
                    {
                    	res.setCode("999");
                    	res.setMsg(e.getMessage());
                    	e.printStackTrace();
                        System.out.println(e.getMessage());
                    }
                }else {
                	res.setCode(String.valueOf(detectResponse.getStatusLine().getStatusCode()));
                	res.setMsg("Không phát hiện (Detect) thấy khuôn mặt trong ảnh!. Ảnh của bạn không có mặt người!");
                }
            }else if(json1.equals("[]")&&(int)detectResponse.getStatusLine().getStatusCode() == 200) {
            	res.setCode(String.valueOf(detectResponse.getStatusLine().getStatusCode()));
            	res.setMsg("Không phát hiện (Detect) thấy khuôn mặt trong ảnh!. Ảnh của bạn không có mặt người!");
            }else {
            	res.setCode(String.valueOf(detectResponse.getStatusLine().getStatusCode()));
            	res.setMsg("Lỗi máy chủ! Vui lòng thử lại sau 3 phút.");
            }
        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
            e.printStackTrace();
            res.setCode("999");
        	res.setMsg(e.getMessage());
        }
        System.out.println("Đang phản hồi trạng thái tới client! Trạng thái: "+res.getCode());
        try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(res));
			System.out.println("Phản hồi trạng thái thành công!");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/uploadFileIdols", method = RequestMethod.POST)
	public void nhandien_file(HttpServletRequest request, HttpServletResponse response,@RequestParam("FILE_input") MultipartFile myFile) throws ClientProtocolException, IOException {
		//MultipartFile multipartFile = myFile.getMultipartFile();
		System.out.println(myFile.getOriginalFilename());
		System.out.println(myFile.getBytes());
		HttpClient httpclient = HttpClients.createDefault();
		Gson gson = new Gson();
		AjaxResponseBody res = new AjaxResponseBody();
        try
        {
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
            //ObjectSendToDetectApi objectSendToDetectApi = new ObjectSendToDetectApi(request.getParameter("url"));
            //String requestBody = gson.toJson(objectSendToDetectApi);
            //System.out.println(request.getParameter("url"));
//            String requestBody = request.getParameter("url").toString();
//            String requestBody = "{ \"url\": \"https://image2.tienphong.vn/w665/Uploaded/2020/bpivpvoi/2019_11_16/ngoc_trinh_2_gygb.jpg\" }";
            // Request body
            //StringEntity reqEntity = new StringEntity(requestBody);
			/*
			 * MultipartEntityBuilder builderFile = MultipartEntityBuilder.create();
			 * builderFile.addBinaryBody("multipartFile", myFile.getBytes(),
			 * ContentType.APPLICATION_OCTET_STREAM, myFile.getOriginalFilename());
			 * HttpEntity multipart = builderFile.build();
			 */
            //lưu ý:Entity của request gửi tới Microsoft Face API phải có dạng ByteArrayEntity để tránh lỗi Http 400: "Decoding error, image format unsupported."
            ByteArrayEntity reqEntity = new ByteArrayEntity(myFile.getBytes(), ContentType.APPLICATION_OCTET_STREAM);
            apiRequest.setEntity(reqEntity);

            HttpResponse detectResponse = httpclient.execute(apiRequest);
//            HttpEntity entity = detectResponse.getEntity();
            String json1 = IOUtils.toString(detectResponse.getEntity().getContent(), "UTF-8");
            //Thread.sleep(3100);
            if (!json1.equals("[]")&&(int)detectResponse.getStatusLine().getStatusCode() == 200)
            {
            	System.out.println("json1 : "+json1);
//                System.out.println(EntityUtils.toString(entity));
                System.out.println(detectResponse.getStatusLine().getStatusCode());
                if((int)detectResponse.getStatusLine().getStatusCode() == 200) {
                	
                	List<DetectObj> detectedList = new ArrayList<DetectObj>();
                	Type collectionType = new TypeToken<List<DetectObj>>(){}.getType();
                	
                	detectedList = gson.fromJson(json1, collectionType);
                	List<String> listFaceId = new ArrayList<String>();
                	for (DetectObj detectObj : detectedList) {
						listFaceId.add(detectObj.getFaceId());
					}
                	IdentityObjSendToApi identityObjSendToApi = new IdentityObjSendToApi("vav-idols-02",listFaceId, 1);
                	String bodyForIdentity = gson.toJson(identityObjSendToApi);
                	System.out.println("send faceids:" +bodyForIdentity);
                	try
                    {
                        URIBuilder identityBuilder = new URIBuilder("https://nhandienkhuonmat.cognitiveservices.azure.com/face/v1.0/identify");


                        URI uri1 = identityBuilder.build();
                        HttpPost request1 = new HttpPost(uri1);
                        request1.setHeader("Content-Type", "application/json");
                        request1.setHeader("Ocp-Apim-Subscription-Key", "2584c2d2b3424fd9a1f589710b124690");


                        // Request body
                        StringEntity reqEntityForIdentity = new StringEntity(bodyForIdentity);
                        request1.setEntity(reqEntityForIdentity);

                        HttpResponse identityResponse = httpclient.execute(request1);
                        String json2 = IOUtils.toString(identityResponse.getEntity().getContent(), "UTF-8");
//                        HttpEntity entity1 = identityResponse.getEntity();
                        System.out.println("json2 : "+json2);
                        if (json2 != null&&(int)identityResponse.getStatusLine().getStatusCode() == 200)
                        {
//                            System.out.println(EntityUtils.toString(entity1));
                            System.out.println(identityResponse.getStatusLine().getStatusCode());
                            if((int)identityResponse.getStatusLine().getStatusCode() == 200) {
                            	List<IdentitiedObj> identitiedObj = new ArrayList<IdentitiedObj>();
                            	Type collectionType2 = new TypeToken<List<IdentitiedObj>>(){}.getType();
                            	identitiedObj = gson.fromJson(json2, collectionType2);
//                            	IdentitiedObj identitiedObj = gson.fromJson(json2, IdentitiedObj.class);
                            	System.out.println(identitiedObj.toString());
                            	int flag = 0;
                            	for (IdentitiedObj identitiedObj2 : identitiedObj) {
									for (Candidates test : identitiedObj2.getCandidates()) {
										
										try {
											if(Float.valueOf(test.getConfidence()) >= 0.5) {
												res = new IdolsJdbc().updateIdols_API(test.getPersonId());
												System.out.println(test.getPersonId()+"\n"+test.getConfidence());
												flag++;
											}
										} catch (Exception e) {
											e.printStackTrace();
											System.out.println(e.getMessage());
											res.setCode("999");
											res.setMsg(e.getMessage());
										}
										
									}
								}
                            	if(flag == 0) {
                            		res.setCode("999");
                            		res.setMsg("Không thể nhận diện (Identity) được bất kỳ ai. Có thể trong ảnh của bạn không có ai nằm trong danh sách bên dưới!");
                            	}
                            }else {
                            	res.setCode(String.valueOf(identityResponse.getStatusLine().getStatusCode()));
                            	res.setMsg("Nhận diện (Identity) khuôn mặt bị lỗi: "+identityResponse.getStatusLine().toString());
                            }
                        }else {
                        	res.setCode(String.valueOf(identityResponse.getStatusLine().getStatusCode()));
                        	res.setMsg("Nhận diện (Identity) khuôn mặt bị lỗi: "+identityResponse.getStatusLine().toString()+"\n Có thể do ảnh không có mặt người!");
                        }
                    }
                    catch (Exception e)
                    {
                    	res.setCode("999");
                    	res.setMsg(e.getMessage());
                    	e.printStackTrace();
                        System.out.println(e.getMessage());
                    }
                }else {
                	res.setCode(String.valueOf(detectResponse.getStatusLine().getStatusCode()));
                	res.setMsg("Không phát hiện (Detect) thấy khuôn mặt trong ảnh!. Ảnh của bạn không có mặt người!");
                }
            }else if(json1.equals("[]")&&(int)detectResponse.getStatusLine().getStatusCode() == 200) {
            	res.setCode(String.valueOf(detectResponse.getStatusLine().getStatusCode()));
            	res.setMsg("Không phát hiện (Detect) thấy khuôn mặt trong ảnh!. Ảnh của bạn không có mặt người!");
            }else {
            	res.setCode(String.valueOf(detectResponse.getStatusLine().getStatusCode()));
            	res.setMsg("Lỗi máy chủ! Vui lòng thử lại sau 3 phút");
            }
        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
            e.printStackTrace();
            res.setCode("999");
        	res.setMsg(e.getMessage());
        }
        System.out.println("Đang phản hồi trạng thái tới client! Trạng thái: "+res.getCode());
        try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(res));
			System.out.println("Phản hồi trạng thái thành công!");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
