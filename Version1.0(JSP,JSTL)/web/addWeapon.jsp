<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%--
    Document   : addWeapon
    Created on : 27.11.2011, 14:29:13
    Author     : Alexei Yasko
--%>

<%-- Setup encodind of request --%>
<fmt:requestEncoding value="utf-8" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add weapon</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <%-- If this page sended request --%>
        <c:if test="${fn:contains(param.addWeapon, 'Добавить')}" >

            <%-- Catch exceptions --%>
            <c:catch var="result">
                <%-- Insert information in data base --%>
                <sql:update var="count" dataSource="jdbc/Weapon">
                    INSERT INTO Weapons VALUES (?, ? , ?, ?, ?, ?)
                    <sql:param value="${param.typeWeapon}"/>
                    <sql:param value="${param.nameWeapon}"/>
                    <sql:param value="${param.weightWeapon}"/>
                    <sql:param value="${param.lengthWeapon}"/>
                    <sql:param value="${param.caliberWeapon}"/>
                    <sql:param value="${param.speadWeapon}"/>
                </sql:update>
            </c:catch>

            <%-- If exeption wasn't catched --%>
            <c:if test="${result == null}">
                <%-- If data base was updated than display message about it --%>
                <c:if test="${count == 1}">
                    <center><h1>Оружие было добавлено.</h1></center>
                </c:if>
                <%-- If data base wasn't updated than display message about it --%>
                <c:if test="${count != 1}">
                    <center><h1>Оружие не было добавлено.</h1></center>
                </c:if>
            </c:if>

            <%-- If exeption was catched --%>
            <c:if test="${result != null}">
                <center><h1>Оружие не было добавлено.</h1></center>
            </c:if>
       </c:if>

            <center>
            <form action="addWeapon.jsp" method="POST">
            <table border="0">
                <thead>
                    <tr>
                        <th colspan="2">Введите данные для добавления оружия в справочник</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Название:</td>
                        <td><input type="text" class="input_text" name="nameWeapon" value="" size="100" /></td>
                    </tr>
                    <tr>
                        <td>Тип:</td>
                        <td><input type="text" class="input_text" name="typeWeapon" value="" size="100" /></td>
                    </tr>
                    <tr>
                        <td>Вес:</td>
                        <td><input type="text" class="input_text" name="weightWeapon" value="" size="100" /></td>
                    </tr>
                    <tr>
                        <td>Длина:</td>
                        <td><input type="text" class="input_text" name="lengthWeapon" value="" size="100" /></td>
                    </tr>
                    <tr>
                        <td>Калибр:</td>
                        <td><input type="text" class="input_text" name="caliberWeapon" value="" size="100"/></td>
                    </tr>
                    <tr>
                        <td>Скорость пули:</td>
                        <td><input type="text" class="input_text" name="speadWeapon" value="" size="100"/></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" value="Добавить" name="addWeapon" /></td>
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
