<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<table>
    <thead>
    <th>
        Search by category:
        <br/>
    </th>
    </thead>
    <tbody>
    <td>
        <select name="glass" id="glass">
            <option value="empty">Select glass type</option>
            <c:forEach items="${glasses}" var="glass">
                <option value="${glass}">${glass}</option>
            </c:forEach>
        </select>

    </td>
    </tbody>
</table>