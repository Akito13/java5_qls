<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page pageEncoding="UTF-8" %>
<div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 container-fluid mx-auto">
  <c:forEach items="${books}" var="book" varStatus="status">
    <c:if test="${status.count <= 6}">
      <div class="col mb-3">
        <jsp:include page="../common/book.jsp" >
          <jsp:param name="maSach" value="${book.maSach}"/>
          <jsp:param name="img" value="${book.img}"/>
          <jsp:param name="tenSach" value="${book.tenSach}"/>
          <jsp:param name="nxb" value="${book.nxb}"/>
          <jsp:param name="soLuong" value="${book.soLuong}"/>
          <jsp:param name="gia" value="${book.gia}"/>
        </jsp:include>
      </div>
    </c:if>
  </c:forEach>
</div>
