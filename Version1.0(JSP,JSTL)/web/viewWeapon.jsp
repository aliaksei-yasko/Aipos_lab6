<%@page import="alex.classes.Weapon"%>
<%@page import="alex.classes.Performer"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%--
    Document   : response
    Created on : 26.11.2011, 21:08:54
    Author     : Alexei Yasko
--%>

<%-- Setup request encoding --%>
<fmt:requestEncoding value="utf-8"/>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Просмотр справочника</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <%-- Declarate variables --%>
        <%!
            private Weapon weapon = null;
        %>

        <%-- Service method --%>
        <%
            try{
                /* Create performer objet with data source referense */
                Performer performer = new Performer("jdbc/Weapon");
                /* Getting weapon object */
                weapon = performer.getWeaponByName(request.getParameter("nameWeapon"));
            } catch (Exception ex) {
                out.println("<center><h1>Ошибка при работе с базой.</h1></center>");
                ex.printStackTrace();
            }
            /* If we didn't get information about weapon */
            if (weapon == null) {
                    out.println("<center><h1>Оружие не найдено в базе.</h1></center>");
                    return;
            }
        %>
        
        <center>
            <table border="0">
                <thead>
                    <tr>
                        <th colspan="2">Weapons  <%= weapon.getName() %></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>Название: </strong></td>
                        <td><span style="font-size:smaller; font-style:italic;"><%= weapon.getName() %></span></td>
                    </tr>
                    <tr>
                        <td><strong>Тип: </strong></td>
                        <td>
                            <%= weapon.getType() %>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Вес: </strong></td>
                        <td>
                            <%= weapon.getWeight() %>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Длина: </strong></td>
                        <td>
                            <%= weapon.getLength() %>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Калибр: </strong></td>
                        <td>
                            <%= weapon.getCaliber() %>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Скорость пули: </strong></td>
                        <td>
                            <%= weapon.getSpeadOfTheBullet() %>
                        </td>
                    </tr>
                    <tr>
                        <form name="onIndex" action="index.jsp" method="POST">
                            <td colspan="2" class="td_end">
                                <center><input type="submit" value="На главную" name="onMain" /></center>
                            </td>
                        </form>
                    </tr>
                </tbody>
            </table>
        </center>
    </body>
</html>



