<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%--
    Document   : response
    Created on : 26.11.2011, 21:08:54
    Author     : Admin
--%>

<%-- Setup encoding request --%>
<fmt:requestEncoding value="utf-8"/>

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
        <title>Изменение оружия</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <%-- Declarate variables --%>
    <%!
        public String nameWeapon = "";
        public String typeWeapon = "";
        public String weightWeapon = "";
        public String lengthWeapon = "";
        public  String caliberWeapon = "";
        public String speadWeapon = "";
    %>

    <%-- Service method --%>
    <%
        Context    initContext = null;
        Context    envContext = null;
        DataSource dataSource = null;
        Connection connection = null;
        PreparedStatement  statement = null;
        ResultSet result = null;
        try{
            /* Get datasource fron context */
            initContext = new InitialContext();
            envContext = (Context) initContext.lookup("java:comp/env");
            dataSource = (DataSource)envContext.lookup("jdbc/Weapon");
            /* Get connection to data base from datasource */
            connection = dataSource.getConnection();

            /* If this page sended request update data base */
            if (request.getParameter("updateWeapon") != null){
                String update = "UPDATE Weapons SET typeweapon = ?, weightweapon = ?, "
                        + "lengthweapon = ?, caliberweapon = ?, speadweapon = ? "
                        + "WHERE nameweapon = ?";
                statement = connection.prepareStatement(update);
                statement.setString(1, request.getParameter("typeWeapon"));
                statement.setDouble(2, Double.parseDouble(request.getParameter("weightWeapon")));
                statement.setDouble(3, Double.parseDouble(request.getParameter("lengthWeapon")));
                statement.setDouble(4, Double.parseDouble(request.getParameter("caliberWeapon")));
                statement.setDouble(5, Double.parseDouble(request.getParameter("speadWeapon")));
                statement.setString(6, request.getParameter("nameWeapon"));
                int check = statement.executeUpdate();
                /* Display information about operation */
                if(check == 0){
                    out.println("<center><h1>Оружие не было обновлено.</h1></center>");
                } else {
                    out.println("<center><h1>Оружие было обновлено.</h1></center>");
                }
            }

            /* Select data from data base about current weapon */
            String query = "select * from weapons where weapons.nameweapon = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, (String)request.getParameter("nameWeapon"));
            result = statement.executeQuery();
            /* If we don't got result anounce about that.
               In other case display result */
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
            out.println("<center><h1>Оружие не было обновлено.</h1></center>");
            ex.printStackTrace();
        } finally {
            connection.close();
            statement.close();
        }
     %>
    <body>     
        <center>
            <form action="changeWeapon.jsp" method="POST">
            <table border="0">
                <thead>
                    <tr>
                        <th colspan="2">Изменение информации об оружии: <%= nameWeapon %></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Название:</td>
                        <td><input type="text" class="input_text" name="nameWeapon" value="<%= nameWeapon %>" size="100" /></td>
                    </tr>
                    <tr>
                        <td>Тип:</td>
                        <td><input type="text" class="input_text" name="typeWeapon" value="<%= typeWeapon %>" size="100" /></td>
                    </tr>
                    <tr>
                        <td>Вес:</td>
                        <td><input type="text" class="input_text" name="weightWeapon" value="<%= weightWeapon %>" size="100" /></td>
                    </tr>
                    <tr>
                        <td>Длина:</td>
                        <td><input type="text" class="input_text" name="lengthWeapon" value="<%= lengthWeapon %>" size="100" /></td>
                    </tr>
                    <tr>
                        <td>Калибр:</td>
                        <td><input type="text" class="input_text" name="caliberWeapon" value="<%= caliberWeapon %>" size="100"/></td>
                    </tr>
                    <tr>
                        <td>Скорость пули:</td>
                        <td><input type="text" class="input_text" name="speadWeapon" value="<%= speadWeapon %>" size="100"/></td>
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
