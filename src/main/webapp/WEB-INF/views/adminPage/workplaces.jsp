<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title><spring:message code="admin.workplaces.title"/></title>
    <link href="../../../resources/img/favicon.ico" rel="shortcut icon" type="image/vnd.microsoft.icon"/>
    <link rel="stylesheet" href="../../../resources/css/bootstrap.css">
    <link rel="stylesheet" href="../../../resources/css/main.css" type="text/css" media="screen"/>
    <script src="../../../resources/js/jquery-1.11.3.js"></script>
    <script src="../../../resources/js/bootstrap.min.js"></script>
    <script src="../../../resources/js/tsort.js"></script>
    <script>
        $(document).ready(function () {
            $("#test").click(function (e) {

                var dataWorkplaces = parseInt($("#lol").val());
                // alert(dataWorkplaces);
                // alert(${name});
                addWorkplaces = {
                    workplaces: dataWorkplaces,
                    number: "${name}"
                };


                var postParamForDatatable = $.ajax({
                    url: "${pageContext.request.contextPath}/admin/createWorkplaces",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify(addWorkplaces),
                    success: function (response) {
                        $.ajax({
                            url: '/admin/auditoriums/${name}/getWorkplaces',
                            type: 'GET',
                            success: function (response) {
                                var sorted = response.sort(function (a, b) {
                                    if (a.status < b.status) {
                                        return 1;
                                    }
                                    if (a.status > b.status) {
                                        return -1;
                                    }
                                    return 0;
                                });
                                var trHTML = '';
                                $.each(sorted, function (i, workplace) {
                                    trHTML += "<tr>" +
                                    '<td>' + workplace.accessNumber + "</td>" +
                                    "<td>" + '<form action="/admin/workplaceReport/' + workplace.accessNumber + '"><button class="glyphicon glyphicon-save-file" type="submit"></button></form>' + "</td>" +
                                    "<td>" + '<form action="/admin/auditoriums/${name}/workplaces/delete/' + workplace.id + '"><center><button class="icon-btn btn btn-primary btn-block" type="submit"><span class="glyphicon glyphicon-remove icon" aria-hidden="true"></span></button></center></form>' + "</td>" +
                                    "</tr>";
                                });
                                $('#records_table tbody').empty();
                                $('#records_table').append(trHTML);
                            }
                        });
                    }
                });

            });
        });
        $(document).ready(function () {
            $("#records_table").tablesort();
        });
        jQuery(function ($) {
            $('tbody tr[data-href]').addClass('clickable').click(function () {
                window.location = $(this).attr('data-href');
            });
        });

        $.ajax({
            url: '/admin/auditoriums/${name}/getWorkplaces',
            type: 'GET',
            success: function (response) {
                var sorted = response.sort(function (a, b) {
                    if (a.status < b.status) {
                        return 1;
                    }
                    if (a.status > b.status) {
                        return -1;
                    }
                    return 0;
                });
                var trHTML = '';
                $.each(sorted, function (i, workplace) {
                    trHTML += "<tr >" +
                    '<td>' + workplace.accessNumber + "</td>" +
                    "<td>" + '<form action="/admin/workplaceReport/' + workplace.accessNumber + '"><button class="glyphicon glyphicon-save-file" type="submit"></button></form>' + "</td>" +
                    "<td>" + '<form action="/admin/auditoriums/${name}/workplaces/delete/' + workplace.id + '"><center><button class="icon-btn btn btn-primary btn-block" type="submit"><span class="glyphicon glyphicon-remove icon" aria-hidden="true"></span></button></center></form>' + "</td>" +
                    "</tr>";
                });
                $('#records_table tbody').empty();
                $('#records_table').append(trHTML);
            }
        });
    </script>
</head>

<body>

<div id="wrap">
    <nav id="header">
        <div class="container-fluid">
            <div class="navbar-header" style="width: 290px;">
                <a href=""><img id="logo" alt="brand" src="../../../resources/img/logo.png"></a>
            </div>
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li><a class="menu-element active" href="/admin/auditoriums"><spring:message
                            code="admin.auditoriums"/></a></li>
                    <li class="dropdown">
                        <a class="dropdown-toggle menu-element" data-toggle="dropdown" href="#"><spring:message
                                code="admin.users"/><b
                                class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a class="menu-element-li" href="/admin/allUsers"><spring:message
                                    code="admin.allUsers"/></a></li>
                            <li><a class="menu-element-li" href="/admin/users"><spring:message code="admin.users"/></a>
                            </li>
                            <li><a class="menu-element-li" href="/admin/assistants"><spring:message
                                    code="admin.assistants"/></a></li>
                            <li><a class="menu-element-li" href="/admin/professors"><spring:message
                                    code="admin.professors"/></a></li>
                            <li><a class="menu-element-li" href="/admin/blockedUsers"><spring:message
                                    code="admin.blocked"/></a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a class="dropdown-toggle menu-element" data-toggle="dropdown" href="#"><spring:message
                                code="admin.orders"/><b
                                class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a class="menu-element-li" href="/admin/allOrders"><spring:message
                                    code="admin.orders"/></a></li>
                            <li><a class="menu-element-li" href="/admin/myOrders"><spring:message
                                    code="admin.myOrders"/></a>
                            </li>
                        </ul>
                    </li>
                    <li><a id="editProfile" class="menu-element" href="/admin/editProfile"><spring:message
                            code="admin.edit"/></a></li>
                    <li><a class="menu-element" href="/logout"><spring:message code="admin.logout"/></a></li>
                </ul>
            </div>
        </div>
    </nav>


    <div class="table-align bottom-block top-table">
        <table id="records_table" class="tbl table table_auditorium table-striped">
            <thead>
            <tr>
                <th><spring:message code="admin.workplaces.workplace"/><img class="icon-sort"
                                                                            src="../../../resources/img/sort15.png"
                                                                            width="8px" height="14px"></th>
                <th></th>
            </tr>
            </thead>
        </table>
    </div>
    <center><a data-toggle="modal" data-target="#addWorkplace" class="btn btn-primary button-style"><spring:message
            code="admin.workplaces.addWorkplace"/></a></center>
    <div id="footer">
        <div class="thick"></div>
        <div class="thin"></div>
        <div><p class="footertext"><spring:message code="login.footer"/></p></div>
        <div id="localization">
            <a href="?lang=en" class="language"><spring:message code="language.en"/></a>
            <a href="?lang=ua" class="language"><spring:message code="language.ua"/></a>
        </div>
    </div>

    <div class="modal fade" id="addWorkplace" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" style="width:300px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <center><h4 class="modal-title" id="myModalLabel">Add workplace</h4></center>
                </div>
                <div class="modal-body">
                    <center><input id="lol" type="email" class="form-control form-style form-auditorium" placeholder=""
                                   style="text-align: center;"></center>
                </div>
                <div class="modal-footer">
                    <center>
                        <button type="button" id="test" class="btn btn-default" data-dismiss="modal">Add workplace
                        </button>
                    </center>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
