<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title><spring:message code="admin.auditoriums.title"/></title>
    <link href="../../../resources/img/favicon.ico" rel="shortcut icon" type="image/vnd.microsoft.icon"/>
    <link rel="stylesheet" href="../../../resources/css/bootstrap.css">
    <link rel="stylesheet" href="../../../resources/css/main.css" type="text/css" media="screen"/>
    <script src="../../../resources/js/jquery-1.11.3.js"></script>
    <script src="../../../resources/js/bootstrap.min.js"></script>
    <script src="../../../resources/js/tsort.js"></script>

    <script>
        $.ajax({
            url: '/admin/getAllAssistant',
            type: 'GET',
            success: function (data) {
                $('#assistant').html('');// to clear the previous option
                $('#assistant').append($('<option>').text("Set empty").attr('value', 0));
                $.each(data, function (i, user) {
                    $('#assistant').append($('<option>').text(user.firstName).attr('value', user.id));

                });

            }  });

            $(document).ready(function () {
                var auditoriumId;
                $('#myModal').on('show.bs.modal', function (e) {
                     auditoriumId = $(e.relatedTarget).attr('data-id');
                });

                    $("#setAssist").click(function () {

                        var setAssist = $( "#assistant" ).val();
                        setAssistance = {
                            assistID: setAssist,
                            auditoriumID:auditoriumId
                        };

                        var postParamForDatatable = $.ajax({
                            url: "${pageContext.request.contextPath}/admin/setAssistToAuditorium",
                            type: "POST",
                            contentType: "application/json",
                            data: JSON.stringify(setAssistance),  success: function (response) {
                                $.ajax({
                                    url: '/admin/getAuditoriums',
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
                                        $.each(sorted, function (i, auditorium) {
                                            if (auditorium.userId == 0) {
                                                trHTML += "<tr>" +
                                                        '<td width="200px">' + '<a href="/admin/auditoriums/' + auditorium.number + '">' + auditorium.number + '</a>' + "</td>" +
                                                            //  "<td>" + '<form action="/admin/auditoriumReport/' + auditorium.number + '"><button class="glyphicon glyphicon-save-file" type="submit"></button></form>' + "</td>" +
                                                        '<td width="230px">' + auditorium.assistantName + "</td>" +
                                                            //'<td >' + "" + "</td>" +
                                                        '   <td class="change-col">' + '<input type="image" src="../../../resources/img/edit.jpg" class="assistId" data-toggle="modal"' + 'data-id="' + auditorium.number + '"  data-target="#myModal" width="15px" height="15px" style="margin-left: 5px; margin-top: 0px;float:left;">' + "</td>" +
                                                        "<td>" + '<form action="/admin/auditoriums/delete/' + auditorium.id + '"><button class="icon-btn btn btn-primary btn-block" type="submit"><span class="glyphicon glyphicon-remove icon" aria-hidden="true"></span></button></form>' + "</td>" +
                                                        "</tr>";
                                            } else {
                                                trHTML += "<tr>" +
                                                        '<td width="200px">' + '<a href="/admin/auditoriums/' + auditorium.number + '">' + auditorium.number + '</a>' + "</td>" +
                                                            //   "<td>" + '<form action="/admin/auditoriumReport/' + auditorium.number + '"><button class="glyphicon glyphicon-save-file" type="submit"></button></form>' + "</td>" +
                                                        '<td width="230px">' + auditorium.assistantName + "</td>" +
                                                        '   <td class="change-col">' + '<input type="image" src="../../../resources/img/edit.jpg" class="assistId" data-toggle="modal"' + 'data-id="' + auditorium.number + '"  data-target="#myModal" width="15px" height="15px" style="margin-left: 5px; margin-top: 0px;float:left;">' + "</td>" +
                                                            //      "<td>" + '<form action="/admin/assistantReport/' + auditorium.userId + '"><button class="glyphicon glyphicon-save-file" type="submit"></button></form>' + "</td>" +
                                                        "<td>" + '<form action="/admin/auditoriums/delete/' + auditorium.id + '"><button class="icon-btn btn btn-primary btn-block" type="submit"><span class="glyphicon glyphicon-remove icon" aria-hidden="true"></span></button></form>' + "</td>" +
                                                        "</tr>";
                                            }
                                        });
                                        $('#records_table tbody').empty();
                                        $('#records_table').append(trHTML);
                                    }
                                });
                            }



                        });
                            });
             //   });
            });





    </script>
    <script>
        $(document).ready(function () {
            $("#test").click(function (e) {

                var dataAuditorium = $("input").val();
                addAuditorium = {
                    auditorium: dataAuditorium
                };

                var postParamForDatatable = $.ajax({
                    url: "${pageContext.request.contextPath}/admin/createAuditoriums",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify(addAuditorium),
                    success: function (response) {
                        $.ajax({
                            url: '/admin/getAuditoriums',
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
                                $.each(sorted, function (i, auditorium) {
                                    if (auditorium.userId == 0) {
                                        trHTML += "<tr>" +
                                                '<td width="200px">' + '<a href="/admin/auditoriums/' + auditorium.number + '">' + auditorium.number + '</a>' + "</td>" +
                                                    //  "<td>" + '<form action="/admin/auditoriumReport/' + auditorium.number + '"><button class="glyphicon glyphicon-save-file" type="submit"></button></form>' + "</td>" +
                                                '<td width="230px">' + auditorium.assistantName + "</td>" +
                                                    //'<td >' + "" + "</td>" +
                                                '   <td class="change-col">' + '<input type="image" src="../../../resources/img/edit.jpg" class="assistId" data-toggle="modal"' + 'data-id="' + auditorium.number + '"  data-target="#myModal" width="15px" height="15px" style="margin-left: 5px; margin-top: 0px;float:left;">' + "</td>" +
                                                "<td>" + '<form action="/admin/auditoriums/delete/' + auditorium.id + '"><button class="icon-btn btn btn-primary btn-block" type="submit"><span class="glyphicon glyphicon-remove icon" aria-hidden="true"></span></button></form>' + "</td>" +
                                                "</tr>";
                                    } else {
                                        trHTML += "<tr>" +
                                                '<td width="200px">' + '<a href="/admin/auditoriums/' + auditorium.number + '">' + auditorium.number + '</a>' + "</td>" +
                                                    //   "<td>" + '<form action="/admin/auditoriumReport/' + auditorium.number + '"><button class="glyphicon glyphicon-save-file" type="submit"></button></form>' + "</td>" +
                                                '<td width="230px">' + auditorium.assistantName + "</td>" +
                                                '   <td class="change-col">' + '<input type="image" src="../../../resources/img/edit.jpg" class="assistId" data-toggle="modal"' + 'data-id="' + auditorium.number + '"  data-target="#myModal" width="15px" height="15px" style="margin-left: 5px; margin-top: 0px;float:left;">' + "</td>" +
                                                    //      "<td>" + '<form action="/admin/assistantReport/' + auditorium.userId + '"><button class="glyphicon glyphicon-save-file" type="submit"></button></form>' + "</td>" +
                                                "<td>" + '<form action="/admin/auditoriums/delete/' + auditorium.id + '"><button class="icon-btn btn btn-primary btn-block" type="submit"><span class="glyphicon glyphicon-remove icon" aria-hidden="true"></span></button></form>' + "</td>" +
                                                "</tr>";
                                    }
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
            url: '/admin/getAuditoriums',
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
                $.each(sorted, function (i, auditorium) {
                    if (auditorium.userId == 0) {
                        trHTML += "<tr>" +
                        '<td width="200px">' + '<a href="/admin/auditoriums/' + auditorium.number + '">' + auditorium.number + '</a>' + "</td>" +
                      //  "<td>" + '<form action="/admin/auditoriumReport/' + auditorium.number + '"><button class="glyphicon glyphicon-save-file" type="submit"></button></form>' + "</td>" +
                        '<td width="230px">' + auditorium.assistantName + "</td>" +
                        //'<td >' + "" + "</td>" +
                                '   <td class="change-col">' + '<input type="image" src="../../../resources/img/edit.jpg" class="assistId" data-toggle="modal"' + 'data-id="' + auditorium.number + '"  data-target="#myModal" width="15px" height="15px" style="margin-left: 5px; margin-top: 0px;float:left;">' + "</td>" +
                        "<td>" + '<form action="/admin/auditoriums/delete/' + auditorium.id + '"><button class="icon-btn btn btn-primary btn-block" type="submit"><span class="glyphicon glyphicon-remove icon" aria-hidden="true"></span></button></form>' + "</td>" +
                        "</tr>";
                    } else {
                        trHTML += "<tr>" +
                        '<td width="200px">' + '<a href="/admin/auditoriums/' + auditorium.number + '">' + auditorium.number + '</a>' + "</td>" +
                     //   "<td>" + '<form action="/admin/auditoriumReport/' + auditorium.number + '"><button class="glyphicon glyphicon-save-file" type="submit"></button></form>' + "</td>" +
                        '<td width="230px">' + auditorium.assistantName + "</td>" +
                                '   <td class="change-col">' + '<input type="image" src="../../../resources/img/edit.jpg" class="assistId" data-toggle="modal"' + 'data-id="' + auditorium.number  + '"  data-target="#myModal" width="15px" height="15px" style="margin-left: 5px; margin-top: 0px;float:left;">' + "</td>" +
                  //      "<td>" + '<form action="/admin/assistantReport/' + auditorium.userId + '"><button class="glyphicon glyphicon-save-file" type="submit"></button></form>' + "</td>" +
                        "<td>" + '<form action="/admin/auditoriums/delete/' + auditorium.id + '"><button class="icon-btn btn btn-primary btn-block" type="submit"><span class="glyphicon glyphicon-remove icon" aria-hidden="true"></span></button></form>' + "</td>" +
                        "</tr>";
                    }
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
            <div class="navbar-header">
                <a href="/"><img id="adm_logo" alt="brand" src="../../../resources/img/logo.png"></a>
            </div>
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a class="dropdown-toggle menu-element" data-toggle="dropdown" href="#"><spring:message
                                code="admin.reports"/><b
                                class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a class="menu-element-li" href="/admin/report_auditorium"><spring:message
                                    code="admin.Auditorium_Stats"/></a></li>
                            <li><a class="menu-element-li" href="/admin/report_assist"><spring:message
                                    code="admin.Assist_Stats"/></a>
                            </li>
                        </ul>
                    </li>
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
        <div id="tableContainer" class="tableContainer">
            <table id="records_table" class="tbl table table_auditorium table-striped"
                   style="max-width: 100%; width: 430px; ">
                <thead class="fixedHeader">
                <tr>
                    <th width="187px" style="vertical-align: middle;"><spring:message
                            code="admin.auditoriums.number"/><img class="icon-sort"
                                                                  src="../../../resources/img/sort15.png" width="8px"
                                                                  height="14px"></th>
                    <th width="230px"><spring:message code="admin.auditoriums.assistantName"/> <img class="icon-sort"
                                                                                                    src="../../../resources/img/sort15.png"
                                                                                                    width="8px"
                                                                                                    height="14px"></th>
                    <th width="50px" class="no-sort"></th>
                </tr>
                </thead>
                <tbody class="scrollContent">
                </tbody>
            </table>
            <center><a data-toggle="modal" data-target="#addAuditorium"
                       class="btn btn-primary button-style"><spring:message
                    code="admin.addAuditorium"/></a></center>
        </div>
    </div>
    <div id="footer">
        <div class="thick"></div>
        <div class="thin"></div>
        <div><p class="footertext"><spring:message code="login.footer"/></p></div>
        <div id="localization">
            <a href="?lang=en" class="language"><spring:message code="language.en"/></a>
            <a href="?lang=ua" class="language"><spring:message code="language.ua"/></a>
        </div>
    </div>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width:300px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <center><h4 class="modal-title" id="myModalLabel1"><spring:message code="admin.set.assistants"/></h4></center>
                </div>
                <div class="modal-body">
                    <select  id="assistant">
                        <option value="0">it's me</option>
                    </select>
                </div>
                <div class="modal-footer">
                    <center>
                        <button type="button" id="setAssist" type="submit" class="btn btn-default"
                                data-dismiss="modal">Ok
                        </button>
                    </center>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="addAuditorium" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" style="width:300px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <center><h4 class="modal-title" id="myModalLabel"><spring:message code="admin.AddAuditorium"/></h4>
                    </center>
                </div>
                <div class="modal-body">
                    <center><input type="email" class="form-control form-style form-auditorium" placeholder=""
                                   style="text-align: center;"></center>
                </div>
                <div class="modal-footer">
                    <center>
                        <button type="button" id="test" class="btn btn-default" data-dismiss="modal">
                            <spring:message code="admin.AddAuditorium"/>
                        </button>
                    </center>
                </div>
            </div>
        </div>
    </div>

</div>
</body>
</html>
