package com.ukmaSupport.controllers;

import com.ukmaSupport.models.Auditorium;
import com.ukmaSupport.models.Order;
import com.ukmaSupport.models.Workplace;
import com.ukmaSupport.services.interfaces.AuditoriumService;
import com.ukmaSupport.services.interfaces.OrderService;
import com.ukmaSupport.services.interfaces.WorkplaceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.List;


@Controller
public class UserController {

    final static String DONE = "done";
    final static String UNDONE = "Undone";

    @Autowired
    private OrderService orderService;

    @Autowired
    private AuditoriumService auditoriumService;

    @Autowired
    private WorkplaceService workplaceService;



    @RequestMapping(value = "/ajaxtest", method = RequestMethod.GET)
    public @ResponseBody List<Workplace> getCharNum(@RequestParam("text") String text) {
        System.out.println(text);
        List<Workplace> workplaces = workplaceService.getByAuditoryName(text);

        return workplaces;
    }

    @RequestMapping(value = "/createOrder", method = RequestMethod.GET)
    public String createOrder(ModelMap model) {
        Order order = new Order();
        List<Auditorium> auditoriums = auditoriumService.getAll();
        model.addAttribute("newOrder", order);
        model.addAttribute("auditoriums", auditoriums);
        return "userPage/createOrderPage";
    }

    @RequestMapping(value = "/createOrder", method = RequestMethod.POST)
    public String createOrderPost(@ModelAttribute("newOrder") Order order,ModelMap model, BindingResult result) {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = attr.getRequest().getSession();
        order.setUserId((Integer) session.getAttribute("id"));
        order.setStatus(UNDONE);
        order.setCreatedAt(new Timestamp(new java.util.Date().getTime()));
        order.setAssistantId(order.getUserId());
        order.setWorkplace_id(workplaceService.getByNumber(Integer.parseInt(order.getWorkplace_access_num())).getId());
        orderService.createOrUpdate(order);
        return "redirect:/userhome";
    }
   @RequestMapping(value = "/userhome" , method = RequestMethod.GET)
    public String listUsersOrder(ModelMap model) {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = attr.getRequest().getSession();
        int userid = (Integer) session.getAttribute("id");

        System.out.println(userid);
        List<Order> orders =  orderService.getByUserId(userid);
        model.addAttribute("userOrder", orders);
        return "userPage/userHomePage";
    }

    @RequestMapping(value = "/uncomplited" , method = RequestMethod.GET)
    public String uncomlitedOrder(ModelMap model) {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = attr.getRequest().getSession();
        int userid = (Integer) session.getAttribute("id");

        System.out.println(userid);
        List<Order> orders =  orderService.getByUserIdStatus(userid,UNDONE);
        model.addAttribute("userOrder", orders);
        return "userPage/userHomePage";
    }

    @RequestMapping(value = "/complited" , method = RequestMethod.GET)
    public String comlitedOrder(ModelMap model) {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = attr.getRequest().getSession();

        int userid = (Integer) session.getAttribute("id");
        System.out.println(userid);
        List<Order> orders =  orderService.getByUserIdStatus(userid, DONE);
        model.addAttribute("userOrder", orders);
        return "userPage/userHomePage";
    }

}
