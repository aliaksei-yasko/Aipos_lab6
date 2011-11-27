<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- 
    Document   : index
    Created on : 26.11.2011, 20:47:17
    Author     : Admin
--%>

<%-- Select weapon names from data base --%>
<sql:query var="result" dataSource="jdbc/Weapon">
SELECT nameweapon FROM Weapons
</sql:query>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web-weapon directory</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <center><h1>Добро пожаловать!</h1></center>
        <center>
            <table border="0">
                <thead>
                    <tr>
                        <th>Справочник по различным видам оружия</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <form action="viewWeapon.jsp" method="POST">
                                <strong>Выберите оружие для просмотра:</strong>
                                <select name="nameWeapon">
                                    <%-- Add all names to drop-down list --%>
                                    <c:forEach var="row" items="${result.rows}">
                                        <option value="${row.nameweapon}">${row.nameweapon}</option>
                                    </c:forEach>
                                </select><br>
                                <input type="submit" value="Просмотреть" name="view" />
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <form action="changeWeapon.jsp" method="POST">
                                <strong>Выберите оружие которое желаете изменить:</strong>
                                <select name="nameWeapon">
                                    <%-- Add all names to drop-down list --%>
                                    <c:forEach var="row" items="${result.rows}">
                                        <option value="${row.nameweapon}">${row.nameweapon}</option>
                                    </c:forEach>
                                </select><br>
                                <input type="submit" value="Изменить" name="change" />
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <form action="deleteWeapon.jsp" method="POST">
                                <strong>Выберите оружие которое желаете удалить:</strong>
                                <select name="nameWeapon">
                                    <%-- Add all names to drop-down list --%>
                                    <c:forEach var="row" items="${result.rows}">
                                        <option value="${row.nameweapon}">${row.nameweapon}</option>
                                    </c:forEach>
                                </select><br>
                                <input type="submit" value="Удалить" name="delete" />
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_end">
                            <form action="addWeapon.jsp" method="POST">
                                <strong>Для добавления нового оружия нажмите кнопку:</strong><br>
                                <input type="submit" value="Добавить" name="add" />
                            </form>
                        </td>
                    </tr>
                </tbody>
            </table>
        </center>

    </body>
</html>
