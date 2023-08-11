<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    #book-link:hover {
        color: var(--main-text-color)!important;
    }
</style>
<c:choose>
  <c:when test="${not empty sessionScope.get(cartId).orders}">
    <h3 class="text-danger text-center mb-3">${error}</h3>
    <div class="overflow-hidden border border-1 container p-0 rounded-3 my-5" style="border-color: var(--main-text-color)!important;">
        <div class="text-white mb-0 py-2 d-flex" style="background-color: var(--main-text-color)!important;">
            <div class="fw-semibold fs-6 mb-0 w-10 ps-3">Sản phẩm</div>
            <div class="fw-semibold fs-6 flex-grow-1 align-self-center"></div>
            <div class="fw-semibold fs-6 text-center w-10 align-self-center">Số lượng</div>
            <div class="fw-semibold fs-6 text-center w-10 align-self-center">Đơn giá</div>
            <div class="fw-semibold fs-6 text-center w-25 align-self-center">Tổng tiền</div>
            <div class="fw-semibold fs-6 text-center w-10 align-self-center">Thao tác</div>
        </div>
        <div id="removable">
            <c:forEach var="book" items="${sessionScope.get(cartId).orders}" varStatus="status">
                <div class="d-flex text-black my-3">
                    <div class="w-25 d-flex">
                        <div class="text-center align-self-center" style="width: 80px; height: 80px;">
                            <img class="img-fluid" style="height: 100%;" src="${pageContext.servletContext.contextPath}/images/${book.value.img}" alt="Ảnh sách">
                        </div>
                        <div class="align-self-center" style="max-width: 240px;">
                            <a id="book-link" href="${pageContext.servletContext.contextPath}/books/${book.value.maSach}" class="text-decoration-none text-black">
                                <span class="d-block w-100 custom-truncator" style="word-break: break-all" id="book-${book.value.maSach}">${book.value.tenSach}</span>
                            </a>
                        </div>
                    </div>
                    <div class="flex-grow-1 align-self-center"></div>
                    <div class="text-center w-10 align-self-center">${book.value.soLuongMua}</div>
                    <div class="text-center w-10 align-self-center">
                        <fmt:formatNumber type="currency" value="${book.value.gia}" pattern="#,###đ" />
                    </div>
                    <div class="text-center w-25 align-self-center main-text-color">
                        <fmt:formatNumber type="currency" value="${book.value.soLuongMua*book.value.gia}" pattern="#,###đ" />
                    </div>
                    <div class="w-10 text-center align-self-center">
                        <button id="brbtn-${book.value.maSach}" type="button" data-bs-toggle="modal" data-bs-target="#confirmModal" class="btn btn-danger ">Xóa</button>
                    </div>
                </div>
                <c:if test="${not status.last}">
                    <div class="border-top border-1 mt-3" style="border-color: var(--main-text-color)!important;"></div>
                </c:if>
            </c:forEach>
        </div>
        <jsp:include page="../modals/confirm-modal.jsp">
            <jsp:param name="modalTitle" value="Xóa sách khỏi giỏ"/>
        </jsp:include>
<%--        <table class="table table-dark table-striped table-responsive-lg mb-0 mt-5">--%>
<%--            <thead>--%>
<%--            <tr class="text-center">--%>
<%--                <th scope="col">#</th>--%>
<%--                <th scope="col">Tên sách</th>--%>
<%--                <th scope="col">Số lượng</th>--%>
<%--                <th scope="col">Giá</th>--%>
<%--                <th scope="col">Thành tiền</th>--%>
<%--                <th scope="col"></th>--%>
<%--            </tr>--%>
<%--            </thead>--%>
<%--            <tbody id="removable">--%>
<%--            <c:forEach var="book" items="${sessionScope.get(cartId).orders}" varStatus="status">--%>
<%--                <tr>--%>
<%--                    <td class="text-center">${status.count}</td>--%>
<%--                    <td class="w-50">--%>
<%--                        <span class="d-block w-100" style="word-break: break-all" id="book-${book.value.maSach}">${book.value.tenSach}</span>--%>
<%--                    </td>--%>
<%--                    <td class="text-center w-10">${book.value.soLuongMua}</td>--%>
<%--                    <td class="text-center w-10">--%>
<%--                        <fmt:formatNumber type="currency" value="${book.value.gia}" pattern="#,###đ" />--%>
<%--                    </td>--%>
<%--                    <td class="text-center">--%>
<%--                            &lt;%&ndash;                <fmt:setLocale value="vn_VI"/>&ndash;%&gt;--%>
<%--                        <fmt:formatNumber type="currency" value="${book.value.soLuongMua*book.value.gia}" pattern="#,###đ" />--%>
<%--                    </td>--%>
<%--                    <td class="w-10 text-center">--%>
<%--                        <button id="brbtn-${book.value.maSach}" type="button" data-bs-toggle="modal" data-bs-target="#confirmModal" class="btn btn-danger">Xóa</button>--%>
<%--                    </td>--%>
<%--                </tr>--%>
<%--            </c:forEach>--%>
<%--            <jsp:include page="../modals/confirm-modal.jsp">--%>
<%--                <jsp:param name="modalTitle" value="Remove book from cart"/>--%>
<%--            </jsp:include>--%>
<%--            <tr>--%>
<%--                <td colspan="4" class="text-center fw-semibold">Tổng tiền</td>--%>
<%--                <td class="fs-5 text-warning text-center fw-bold">--%>
<%--                    <fmt:formatNumber type="currency" value="${sessionScope.totalAmount}" pattern="#,###đ" />--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--            </tbody>--%>
<%--        </table>--%>
<%--        <div class="container-lg d-flex justify-content-end bg-transparent py-2">--%>
<%--            <a href="/cart/clear" class="btn btn-danger">Xóa tất cả</a>--%>
<%--        </div>--%>
    </div>
    <div class="overflow-hidden border border-1 container p-0 rounded-3 mb-5" style="border-color: var(--main-text-color)!important;">
        <h5 class="text-white mb-0 py-2 ps-3" style="background-color: var(--main-text-color)!important;">Thông tin nhận hàng</h5>
        <%--@elvariable id="order" type="sof3021.ca4.nhom1.asm.qls.model.Order"--%>
        <form:form cssClass="row g-4 p-4" modelAttribute="order" method="post" id="orderInfo" action="/cart/checkout">
            <div class="mb-3 col-6">
                <form:label path="tenNguoiNhan" for="tenNguoiNhan" cssClass="form-label">Tên người nhận</form:label>
                <form:input path="tenNguoiNhan" type="text" cssClass="form-control" id="tenNguoiNhan" />
            </div>
            <div class="mb-3 col-6">
                <form:label path="sdt" for="sdt" cssClass="form-label">Số điện thoại</form:label>
                <form:input path="sdt" type="text" cssClass="form-control" id="sdt" />
            </div>
            <div class="mb-3 col-6">
                <label for="ngayDat" class="form-label">Ngày đặt</label>
                <input name="ngayDat" type="text" class="form-control" id="ngayDat" readonly value="${ngayDat}"/>
            </div>
            <div class="mb-3 col-6">
                <form:label path="diaChiNhan" for="diaChiNhan" cssClass="form-label">Địa chỉ</form:label>
                <form:input path="diaChiNhan" type="text" cssClass="form-control" id="diaChiNhan" />
            </div>
        </form:form>
        <div class="container-lg d-flex py-2 border-top border-1 " style="border-color: var(--main-text-color)!important;">
            <div class="w-75 fw-semibold fs-5 text-end align-self-center main-text-color">Tổng thanh toán:</div>
            <div class="text-start align-self-center main-text-color flex-grow-1 ps-2">
                <span class="fs-4 fw-semibold"><fmt:formatNumber type="currency" value="${sessionScope.totalAmount}" pattern="#,###" /></span>đ
            </div>
            <div class="w-10 text-end pe-3">
                <button class="btn btn-success ms-3" form="orderInfo">Đặt hàng</button>
            </div>
        </div>
    </div>
  </c:when>
  <c:otherwise>
      <jsp:include page="../common/book-not-found.jsp">
          <jsp:param name="reason" value="Giỏ hàng trống"/>
          <jsp:param name="btnText" value="Tìm sách bạn muốn!"/>
      </jsp:include>
  </c:otherwise>
</c:choose>

