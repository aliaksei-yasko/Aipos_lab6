<%@page import="alex.classes.Performer"%>
<%@page import="alex.classes.Weapon"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%--
    Document   : response
    Created on : 26.11.2011, 21:08:54
    Author     : Alexei Yasko
--%>

<%-- Setup encoding request --%>
<fmt:requestEncoding value="utf-8"/>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isThreadSafe="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Изменение оружия</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <%-- Declarate variables --%>
    <%!
        private Weapon weapon = null;
    %>

    <%-- Service method --%>
    <%
        try{
            /* Create performer objet with data source referense */
            Performer performer = new Performer("jdbc/Weapon");
            /* If this page sended update request */
            if (request.getParameter("updateWeapon") != null){
                /* Create weapon object from came request parameters */
                Weapon updateWeapon = new Weapon();
                updateWeapon.setName(request.getParameter("nameWeapon"));
                updateWeapon.setType(request.getParameter("typeWeapon"));
                updateWeapon.setWeight(Double.parseDouble(request.getParameter("weightWeapon")));
                updateWeapon.setLength(Double.parseDouble(request.getParameter("lengthWeapon")));
                updateWeapon.setCaliber(Double.parseDouble(request.getParameter("caliberWeapon")));
                updateWeapon.setSpeadOfTheBullet(Double.parseDouble(request.getParameter("speadWeapon")));
                /* Perfom update operation whith created weapon object */
                boolean result = performer.updateWeapon(updateWeapon);
                /* Display information about operation */
                if(!result){
                    out.println("<center><h1>Оружие не было обновлено.</h1></center>");
                } else {
                    out.println("<center><h1>Оружие было обновлено.</h1></center>");
                }
            }

            /* Get weapon object by weapon's name */
            weapon = performer.getWeaponByName(request.getParameter("nameWeapon"));
        } catch (Exception ex) {
            out.println("<center><h1>Ошибка при работе с базой.</h1></center>");
            ex.printStackTrace();
        }

        /* If we didn't get weapon object */
        if (weapon == null) {
                out.println("<center><h1>Оружие не найдено в базе.</h1></center>");
                return;
        }
    %>

    <body>
        <center>
            <form action="changeWeapon.jsp" method="POST">
            <table border="0">
                <thead>
                    <tr>
                        <th colspan="2">Изменение информации об оружии: <%= weapon.getName() %></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Название:</td>
                        <td><input type="text" class="input_text" name="nameWeapon" value="<%= weapon.getName() %>" size="100" /></td>
                    </tr>
                    <tr>
                        <td>Тип:</td>
                        <td><input type="text" class="input_text" name="typeWeapon" value="<%= weapon.getType() %>" size="100" /></td>
                    </tr>
                    <tr>
                        <td>Вес:</td>
                        <td><input type="text" class="input_text" name="weightWeapon" value="<%= weapon.getWeight() %>" size="100" /></td>
                    </tr>
                    <tr>
                        <td>Длина:</td>
                        <td><input type="text" class="input_text" name="lengthWeapon" value="<%= weapon.getLength() %>" size="100" /></td>
                    </tr>
                    <tr>
                        <td>Калибр:</td>
                        <td><input type="text" class="input_text" name="caliberWeapon" value="<%= weapon.getCaliber() %>" size="100"/></td>
                    </tr>
                    <tr>
                        <td>Скорость пули:</td>
                        <td><input type="text" class="input_text" name="speadWeapon" value="<%= weapon.getSpeadOfTheBullet() %>" size="100"/></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" value="Изменить" name="updateWeapon" /></td>
                    </tr>
                </tbody>
            </table>
            </form>
            <form name="onIndex" action="index.jsp" method="POST">
                <table border="0">
                    <thead>
                        <tr>
                            <th><center><input type="submit" value="На главную" name="onMain" /></center></th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </form>
        </center>
    </body>
</html>
