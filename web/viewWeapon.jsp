<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- 
    Document   : response
    Created on : 26.11.2011, 21:08:54
    Author     : Admin
--%>

<fmt:requestEncoding value="utf-8"/>

<sql:query var="result" dataSource="jdbc/Weapon">
    SELECT * FROM Weapons WHERE Weapons.nameweapon = ? <sql:param value="${param.nameWeapon}"/>
</sql:query>

<c:set var="weaponInformation" value="${result.rows[0]}" />

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
        <table border="0">
            <thead>
                <tr>
                    <th colspan="2">Weapons  ${param.nameWeapon}</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>Название: </strong></td>
                    <td><span style="font-size:smaller; font-style:italic;">${weaponInformation.nameweapon}</span></td>
                </tr>
                <tr>
                    <td><strong>Тип: </strong></td>
                    <td>
                        ${weaponInformation.typeweapon}
                    </td>
                </tr>
                <tr>
                    <td><strong>Вес: </strong></td>
                    <td>
                        ${weaponInformation.weightweapon}
                    </td>
                </tr>
                <tr>
                    <td><strong>Длина: </strong></td>
                    <td>
                        ${weaponInformation.lengthweapon}
                    </td>
                </tr>
                <tr>
                    <td><strong>Калибр: </strong></td>
                    <td>
                        ${weaponInformation.caliberweapon}
                    </td>
                </tr>
                <tr>
                    <td><strong>Скорость пули: </strong></td>
                    <td>
                        ${weaponInformation.speadweapon}
                    </td>
                </tr>
        </tbody>
    </table>
    </body>
</html>
