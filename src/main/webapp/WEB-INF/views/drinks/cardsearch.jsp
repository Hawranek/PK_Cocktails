<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--
  Created by IntelliJ IDEA.
  User: damian
  Date: 25.07.2021
  Time: 15:20
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <title>Cocktail List for card: ${card.id}</title>
    <style>
        table, th, td {
            border: 1px solid black;
        }
    </style>
</head>
<body>
<%@include file="../cards/cardnavigation.jsp"%>
<%--97-122 małe litery--%>

<table>
    <form action="/app/drink/incard/search" method="get">
        <table >
            Search by First Letter:
            <tbody>
            <tr>
                <c:forEach var="i" items="${alphabet}">
                    <th>
                        <input type="submit" value="${i}" name="name">
<%--                        <a href="<c:out value="/app/drink/incard/search?name=${i}&cardid="/>">${i}</a>--%>
                    </th>
                </c:forEach>
            </tr>
            </tbody>
        </table>
        <tr>
            <td>
                <%@include file="search/byname.jsp" %>
            </td>
            <td>
                <select name="cardid" id="cardid">
                    <c:forEach var="card" items="${cards}">
                        <option value="${card.id}">${card.name}</option>
                    </c:forEach>
                </select>
            </td>
        </tr>
    <input type="submit">
    </form>
    <form:form modelAttribute="cocktails" action="/app/drink/incard/filter" method="get">
        <td>
            <%@include file="search/byingredient.jsp" %>
        </td>
        <td>
            <%@include file="search/byalcoholic.jsp" %>
        </td>
        <td>
            <%@include file="search/bycategory.jsp" %>
        </td>
        <td>
            <%@include file="search/byglass.jsp" %>
        </td>
        <input type="submit">
    </form:form>
</table>
<%@include file="printlist.jsp" %>

</body>
</html>
