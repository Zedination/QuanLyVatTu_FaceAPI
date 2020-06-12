package com.devmaster.mvc.controller;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.User;
import com.devmaster.mvc.jdbc.forgotpasswordjdbc;
@Controller
public class forgotpasswordcontroller extends AbstractController {
	
	@RequestMapping(value = "/forgot-password", method = RequestMethod.GET)
	public String viewForgot_Password(Model model) {
		return "common/forgot-password";
	}
	
	@RequestMapping(value = "/forgot-password", method = RequestMethod.POST)
	public String doSendMail(Model model,HttpServletRequest request) throws AddressException, MessagingException {
		User u = new User();
		u.setEmail(request.getParameter("email"));
		String pathReturn;
		AjaxResponseBody response = new AjaxResponseBody();
		forgotpasswordjdbc forpass = new forgotpasswordjdbc();
		String[] arrResult = forpass.check(u);
		response.setCode("");
		if ("Thành công".equals(arrResult[0])) {
			 String newpass = RandomString.getAlphaNumericString(10);
			 
			 String code = forpass.resetPass(arrResult[1], newpass);
			 if("000".equals(code)) {
				 sendMail(u.getEmail(),arrResult[1],newpass);
				 pathReturn = "common/resetSuccess";
			 }else {
				 response.setMsg("Có lỗi trong quá trình reset mật khẩu. Vui lòng thử lại hoặc phản hồi với chúng tôi!");
				 pathReturn = "common/forgot-password";
			 }
			 
		}else {
			response.setMsg(arrResult[0]);
			pathReturn = "common/forgot-password";
		}
		model.addAttribute("response", response);
		return pathReturn;
	}
// hàm bên dưới viết đúng nhưng hiện tại tôi không biết cách thiết lập config location chứa bean "mailSender2" nằm trong file applicationContext1.xml
	// của Spring context
//	public void sendMail(String  email, String username, String newpass) {
//		ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext1.xml");
//		MailSender mailSender = (MailSender) context.getBean("mailSender2");
//		System.out.println("Sending text...");
//		SimpleMailMessage message = new SimpleMailMessage();
//		message.setFrom("testspringmvlocalhost@gmail.com");
//		message.setTo(email);
//		message.setSubject("Mật khẩu mới của bạn!");
//		message.setText("Mật khẩu mới cho tài khoản "+username+" là "+newpass+"");
//		// sending message
//		mailSender.send(message);
//		System.out.println("Sending text done!");
//		context.close();
//	}
//	

// Hàm gửi mail với SMTP bằng java thông thường
	//Chú ý: bạn cần phải khai báo thư viện 
//	<dependency>
//    <groupId>com.sun.mail</groupId>
//    <artifactId>javax.mail</artifactId>
//    <version>1.5.1</version>
//    </dependency>
//    tương ứng với javax.mail-1.5.1.jar
//thay vì sử dụng thư viện 
//<dependency>
//<groupId>javax.mail</groupId>
//<artifactId>mail</artifactId>
//<version>1.4</version>
//</dependency>
//tương ứng với file "mail-1.4.jar" nằm trong thư mục "lib" của project này
//để hàm gửi mail dưới đây có thể hoạt động trên server Tomcat
//	GIẢI THÍCH: đại loại javax.mail-[version].jar là phiên bản mở rộng và đầy đủ của mail-[version].jar. Để gửi mail được trên server
//	cần sử dụng javax.mail. Chi tiết cách sửa lỗi : 
//		https://stackoverflow.com/questions/16807758/java-lang-noclassdeffounderror-com-sun-mail-util-maillogger-for-junit-test-case
	public void sendMail(String  email, String username, String newpass) throws AddressException, MessagingException {
		Properties mailServerProperties;
		Session getMailSession;
		MimeMessage mailMessage;

		// Step1: setup Mail Server
		mailServerProperties = System.getProperties();
		mailServerProperties.put("mail.smtp.port", "587");
		mailServerProperties.put("mail.smtp.auth", "true");
		mailServerProperties.put("mail.smtp.starttls.enable", "true");

		// Step2: get Mail Session
		getMailSession = Session.getDefaultInstance(mailServerProperties, null);
		mailMessage = new MimeMessage(getMailSession);

		// thay abc@gmail.com bằng địa chỉ người nhận
		mailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(email)); 

		// Bạn có thể chọn CC, BCC
		// generateMailMessage.addRecipient(Message.RecipientType.CC, new
		// InternetAddress("cc@gmail.com")); //Địa chỉ cc gmail

		mailMessage.setSubject("Mật khẩu mới của bạn");
		mailMessage.setText("Mật khẩu mới cho tài khoản "+username+" là "+newpass+"");

		// Step3: Send mail
		Transport transport = getMailSession.getTransport("smtp");

		// Thay your_gmail thành gmail của bạn, thay your_password thành mật khẩu gmail của bạn
		transport.connect("smtp.gmail.com", "testspringmvlocalhost@gmail.com", "localhost");
		transport.sendMessage(mailMessage, mailMessage.getAllRecipients());
		transport.close();
	}
	
	//hàm này là hàm tạo ngẫu nhiên 1 chuỗi String
	public static class RandomString { 
		  
	    // function to generate a random string of length n 
	    static String getAlphaNumericString(int n) 
	    { 
	  
	        // chose a Character random from this String 
	        String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	                                    + "0123456789"
	                                    + "abcdefghijklmnopqrstuvxyz"; 
	  
	        // create StringBuffer size of AlphaNumericString 
	        StringBuilder sb = new StringBuilder(n); 
	  
	        for (int i = 0; i < n; i++) { 
	  
	            // generate a random number between 
	            // 0 to AlphaNumericString variable length 
	            int index 
	                = (int)(AlphaNumericString.length() 
	                        * Math.random()); 
	  
	            // add Character one by one in end of sb 
	            sb.append(AlphaNumericString 
	                          .charAt(index)); 
	        } 
	  
	        return sb.toString(); 
	    } 
	}
}
