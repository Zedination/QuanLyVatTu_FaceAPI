package com.devmaster.mvc.model;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.devmaster.mvc.entity.User;


public class UserValidator implements Validator {

	@Override
	public boolean supports(Class clazz) {
		return User.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		User user = (User) target;

		/*if (!user.getUsername().equals("abc")) {
			errors.rejectValue("username", "Email.userForm.emailWrong1", "Đời như cái vời");
		}*/

		// do "complex" validation here

	}

}