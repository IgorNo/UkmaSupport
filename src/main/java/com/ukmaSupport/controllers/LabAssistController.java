package com.ukmaSupport.controllers;

import com.ukmaSupport.models.Auditorium;
import com.ukmaSupport.models.Order;
import com.ukmaSupport.models.User;
import com.ukmaSupport.services.impl.OrderServiceImpl;
import com.ukmaSupport.services.interfaces.AuditoriumService;
import com.ukmaSupport.services.interfaces.OrderService;
import com.ukmaSupport.services.interfaces.UserService;
import com.ukmaSupport.services.interfaces.WorkplaceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
public class LabAssistController {

    @Autowired
    private OrderService orderDao;

    @Autowired
    private UserController userController;


    @RequestMapping(value = "/allAssistOrders", method = RequestMethod.POST)
    @ResponseBody
    public String showAllAssistOrders(Model model) {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = attr.getRequest().getSession();
        int assistid = (Integer) session.getAttribute("id");

        List<Order> orders = orderDao.getByAssist(assistid);
        model.addAttribute("assistOrders", orders);
        return "assistPage/assistHomePage";
    }

    @RequestMapping(value = "/assistCompletedOrders", method = RequestMethod.POST)
    @ResponseBody
    public String showAsistCompletedOrders(Model model) {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = attr.getRequest().getSession();
        int assistid = (Integer) session.getAttribute("id");

        List<Order> orders = orderDao.getByAssistAndStatus(assistid, "Done");
        model.addAttribute("asistCompletedOrders", orders);
        return "assistPage/assistHomePage";
    }

    @RequestMapping(value = "/assistUncompletedOrders", method = RequestMethod.POST)
    @ResponseBody
    public String showAssistUncompletedOrders(Model model) {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = attr.getRequest().getSession();
        int assistid = (Integer) session.getAttribute("id");

        List<Order> orders = orderDao.getByAssistAndStatus(assistid, "Undone");
        model.addAttribute("asistUncompletedOrders", orders);
        return "assistPage/assistHomePage";
    }

    @RequestMapping(value = "/editAssistProfile" , method = RequestMethod.POST)
    @ResponseBody
    public String editProfile(ModelMap model) {
       return userController.editProfile(model);
    }

    @RequestMapping(value = "/createAssistOrder" , method = RequestMethod.GET)
    @ResponseBody
    public String createAssistOrder(ModelMap model) {
        return userController.createOrder(model);
    }

    @RequestMapping(value = "/createAssistOrder" , method = RequestMethod.POST)
    @ResponseBody
    public String createAssistOrderPost(Order order,ModelMap model, BindingResult result) {
        return userController.createOrderPost(order, model, result);
    }


}
