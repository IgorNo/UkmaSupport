package com.ukmaSupport.mailService.templates;

import com.ukmaSupport.mailService.MailService;
import com.ukmaSupport.utils.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ForgotPasswordMail {
    private static final String FROM_ADDR = Constants.MAIL_SERVER;  //mail server

    @Autowired
    private MailService mailService;

    public void send(String toAddr, String link){
        String subject = "You can change your password now";
        String body = "You can change your password: " + link + "\n\nUKMA Support\n" + Constants.SERVER;
        mailService.sendEmail(toAddr, FROM_ADDR, subject, body);
    }
}
