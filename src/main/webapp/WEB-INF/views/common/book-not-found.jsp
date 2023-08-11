<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 8/11/2023
  Time: 1:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="text-center m-0 position-absolute top-50 start-50 translate-middle w-100">
  <div class="mb-3">
    <img src="/imgs/notfound.webp" alt="Book not found image." style="width: 300px;"/>
  </div>
  <h3 class="fw-bold fs-2 mx-auto rounded-pill w-50 main-text-color">${param.reason}</h3>
  <a href="${pageContext.servletContext.contextPath}/books" class="btn btn-success mt-3">${param.btnText}</a>
</div>
