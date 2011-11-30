<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%--
    Document   : deleteWeapon
    Created on : 27.11.2011, 16:11:41
    Author     : Alexei Yasko
--%>

<fmt:requestEncoding value="utf-8" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Удалиние оружия</title>
        <link rel="stylesheet" type="text/css" href="style.css" />
    </head>
    <body>
        <form name="onIndex" action="index.jsp" method="POST">
            <center>
            <table border="0">
                <thead>
                    <tr>
                        <th>Удаление ${param.nameWeapon}</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <%-- Chatch exeptions --%>
                            <c:catch var="result">
                                <%-- Delete nessesary weapons --%>
                                <sql:update var="count" dataSource="jdbc/Weapon">
                                    DELETE FROM Weapons WHERE nameWeapon = ?
                                    <sql:param value="${param.nameWeapon}"/>
                                </sql:update>
                            </c:catch>
                            <%-- If we didn't got exception --%>
                            <c:if test="${result == null}">
                                <%-- Check results and display them --%>
                                <c:if test="${count > 0}">
                                    <center><h1>Оружие было удалено.</h1></center>
                                </c:if>
                                <c:if test="${count <= 0}">
                                    <center><h1>Оружие не было удалено.</h1></center>
                                </c:if>
                            </c:if>
                            <%-- If we got exception --%>
                            <c:if test="${result != null}">
                                <center><h1>Оружие не было удалено.</h1></center>
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_end"><center><input type="submit" value="На главную" name="onMain" /></center></td>
                    </tr>
                </tbody>
            </table>
            </center>
        </form>
    </body>
</html>
