package com.ukmaSupport.controllers;

import com.ukmaSupport.dao.interfaces.UserDao;
import com.ukmaSupport.mailService.MailService;
import com.ukmaSupport.mailService.templates.Mail;
import com.ukmaSupport.mailService.templates.RegistrationMail;
import com.ukmaSupport.models.*;
import com.ukmaSupport.utils.RegistrationValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/register")
public class Registration {
    @Autowired
    private UserDao userDao;

    @Autowired
    private RegistrationMail registrationMail;

    @Autowired
    @Qualifier("registrationValidator")
    private RegistrationValidator validator;

    @RequestMapping(method = RequestMethod.GET)
    public String viewRegistration(Model model) {
        com.ukmaSupport.models.User userForm = new User();
        model.addAttribute("userForm", userForm);
        return "registration/registration";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String processRegistration(@ModelAttribute("userForm") User user, Model model, BindingResult result) {
        model.addAttribute("userForm", user);
        validator.validate(user, result);
        if (result.hasErrors())
            return "registration/registration";
        userDao.saveOrUpdate(user);

        registrationMail.send(user.getEmail());

        return "registration/registrationSuccess";
    }
}