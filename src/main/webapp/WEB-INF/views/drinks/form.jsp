<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: damian
  Date: 25.07.2021
  Time: 15:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add New Cocktail to card: ${card.name}</title>
    <style>
        table, th, td {
            border: 1px solid black;
        }
    </style>
</head>
<body>
<%--<%@include file="../home/nav.jsp"%>--%>
<%--<table>--%>
<%--    <c:forEach items="${cocktail.drinks}" var="drink">--%>
<%--        <img src="${drink.strDrinkThumb}" width="300" height="300">--%>
<%--        <h1>${drink.strDrink}</h1>--%>

<%--        <thead>--%>
<%--        <th>Category</th>--%>
<%--        <th>Alcoholic</th>--%>
<%--        <th>Glass type</th>--%>
<%--        <th>Instructions</th>--%>
<%--        <th>Ingredients</th>--%>
<%--        <th>Action</th>--%>
<%--        </thead>--%>
<%--        <tbody>--%>
<%--        <tr>--%>
<%--            <td>${drink.strCategory}</td>--%>
<%--            <td>${drink.strAlcoholic}</td>--%>
<%--            <td>${drink.strGlass}</td>--%>
<%--            <td>${drink.strInstructions}</td>--%>
<%--            <td>--%>
<%--                    &lt;%&ndash;            ${drink.getIngredientList()}&ndash;%&gt;--%>
<%--                <c:forEach var="ing" items="${drink.getIngredientList()}">--%>
<%--                    ${ing}<br/>--%>
<%--                </c:forEach>--%>
<%--            </td>--%>
<%--            <td><a href="/app/card/addtocard/${drink.idDrink}">Dodaj do karty</a> </td>--%>
<%--        </tr>--%>
<%--        </tbody>--%>
<%--    </c:forEach>--%>
<%--</table>--%>

<%@include file="../cards/cardnavigation.jsp"%>

<table>
    <form:form modelAttribute="cocktail" method="post" action="/app/drink/form">
        <input type="hidden" name="cardid" id="cardid" value="${card.id}">
        <form:hidden path="id"/>
        <thead>
        <th>Name</th>
        <th>Image</th>
        <th>Category</th>
        <th>Alcoholic</th>
        <th>Glass type</th>
        <th>Instructions</th>
        <th>Ingredients</th>
<%--        <th>Card name</th>--%>
        <th>Action</th>
        </thead>
        <tbody>
        <tr>
            <td><form:input path="name"/></td>
            <td><form:input path="drinkThumb"/></td>
            <td><form:input path="category"/></td>
            <td><form:checkbox path="alcoholic"/></td>
            <td><form:input path="glass"/></td>
            <td><form:input path="instructions"/></td>
            <td><form:input path="ingredientList"/></td>

<%--            <td><select name="cardid" id="cardid">--%>
<%--                <c:forEach items="${cards}" var="card">--%>
<%--                    <option value="${card.id}">${card.name}</option>--%>
<%--                </c:forEach>--%>
<%--            </select></td>--%>
            <td><input type="submit"></td>
        </tr>
        </tbody>
    </form:form>

</table>
</body>
</html>
