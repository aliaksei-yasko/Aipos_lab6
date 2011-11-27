<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%--
    Document   : response
    Created on : 26.11.2011, 21:08:54
    Author     : Admin
--%>

<fmt:requestEncoding value="utf-8"/>
<sql:setDataSource dataSource="jdbc/Weapon" /> 

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isThreadSafe="false" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Просмотр справочника</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <%!
        private String nameWeapon = "";
        private String typeWeapon = "";
        private String weightWeapon = "";
        private String lengthWeapon = "";
        private String caliberWeapon = "";
        private String speadWeapon = "";
    %>

    <%
        Context    initContext = null;
        Context    envContext = null;
        DataSource dataSource = null;
        Connection connection = null;
        PreparedStatement  statement = null;
        ResultSet result = null;
        try{
            initContext = new InitialContext();
            envContext = (Context) initContext.lookup("java:comp/env");
            dataSource = (DataSource)envContext.lookup("jdbc/Weapon");
            connection = dataSource.getConnection();

            String query = "select * from weapons where weapons.nameweapon = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, (String)request.getParameter("nameWeapon"));
            result = statement.executeQuery();
            if(!result.next()){
                out.println("<h1><strong>Такого оружия не существует в справочнике.</strong></h1>");
            } else {
                nameWeapon = result.getString("nameweapon");
                typeWeapon = result.getString("typeweapon");
                weightWeapon = result.getString("weightweapon");
                lengthWeapon = result.getString("lengthweapon");
                caliberWeapon = result.getString("caliberweapon");
                speadWeapon = result.getString("speadweapon");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            connection.close();
            statement.close();
        }
     %>
    <body>
        <table border="0">
            <thead>
                <tr>
                    <th colspan="2">Weapon <%= request.getParameter("nameWeapon")%></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>Название: </strong></td>
                    <td><span style="font-size:smaller; font-style:italic;"><%=nameWeapon %></span></td>
                </tr>
                <tr>
                    <td><strong>Тип:</strong></td>
                    <td>
                        <%=typeWeapon %>
                    </td>
                </tr>
                <tr>
                    <td><strong>Вес: </strong></td>
                    <td>
                        <%=weightWeapon %>
                    </td>
                </tr>
                <tr>
                    <td><strong>Длина: </strong></td>
                    <td>
                        <%=lengthWeapon %>
                    </td>
                </tr>
                <tr>
                    <td><strong>Калибр: </strong></td>
                    <td>
                        <%=caliberWeapon %>
                    </td>
                </tr>
                <tr>
                    <td><strong>Скорость пули: </strong></td>
                    <td>
                        <%=speadWeapon %>
                    </td>
                </tr>
        </tbody>
    </table>
    </body>
</html>
