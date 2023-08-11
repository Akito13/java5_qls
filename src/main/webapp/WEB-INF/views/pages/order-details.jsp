<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:choose>
    <c:when test="${not empty errors}">
        <div class="w-100 text-center pt-3">
            <div>
                <img src="${pageContext.request.contextPath}/images/notfound.jpg" alt="Book not found image." style="width: 300px;"/>
            </div>
            <h3 class="fw-bold fs-2 mx-auto rounded-pill w-50" style="color: #73BBC9">${errors}</h3>
            <a href="${pageContext.servletContext.contextPath}/books" class="btn btn-outline-secondary mt-3">Tìm sách bạn mong muốn!</a>
        </div>
    </c:when>
    <c:otherwise><jsp:useBean id="order" scope="request" type="sof3021.ca4.nhom1.asm.qls.model.Order"/>

        <div class="overflow-hidden border border-1 container p-0 rounded-3 my-5 w-50" style="border-color: var(--main-text-color)!important;">
            <h5 class="text-white mb-0 py-2 ps-3" style="background-color: var(--main-text-color)!important;">Đơn hàng</h5>
            <div class="container-lg mb-0 row p-4">
                <div class="col-12 col-md-6 mb-2">
                    <label for="maDH">Mã đơn hàng</label>
                    <input class="form-control" id="maDH" value="${order.maDH}"} type="text" readonly disabled>
                </div>
                <div class="col-12 col-md-6 mb-2">
                    <label for="ngayXuat">Ngày đặt hàng</label>
                    <input class="form-control" id="ngayXuat" value="${order.ngayXuat.toString()}" type="text" readonly disabled>
                </div>
                <div class="col-12 col-md-6 mb-2">
                    <label for="tenKH">Người đặt hàng</label>
                    <input class="form-control" id="tenKH" value="${order.user.tenKH}" type="text" readonly disabled>
                </div>
                <div class="col-12 col-md-6 mb-2">
                    <label for="nguoiDat">Người nhận hàng</label>
                    <input class="form-control" id="nguoiDat" value="${order.tenNguoiNhan}" type="text" readonly disabled>
                </div>
            </div>
        </div>
        <div class="overflow-hidden border border-1 container p-0 rounded-3 my-5" style="border-color: var(--main-text-color)!important;">
            <h5 class="text-white mb-0 py-2 ps-3" style="background-color: var(--main-text-color)!important;">Sách đã đặt</h5>
            <table class="table table-striped table-responsive-lg container-lg mb-0">
                <thead>
                <tr class="text-center main-text-color">
                    <th scope="col">#</th>
                    <th scope="col">Tên sách</th>
                    <th scope="col">Số lượng</th>
                    <th scope="col">Thành tiền</th>
                </tr>
                </thead>
                <tbody id="removable">
                <jsp:useBean id="details" scope="request" type="java.util.List<sof3021.ca4.nhom1.asm.qls.model.OrderDetails>"/>
                <c:forEach var="detail" items="${details}" varStatus="status">
                    <tr>
                        <td class="text-center">${status.count}</td>
                        <td class="text-center">${detail.book.tenSach}</td>
                        <td class="text-center">${detail.soLuong}</td>
                        <td class="text-center">
                            <fmt:formatNumber type="currency" pattern="#,###đ" value="${detail.tongTien}" />
                        </td>
                    </tr>
                </c:forEach>
                <tr class="fw-semibold">
                    <td colspan="3" class="text-center">Tổng tiền</td>
                    <td class="text-center">
                        <fmt:formatNumber value="${totalAmount}" type="currency" pattern="#,###đ"/>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </c:otherwise>
</c:choose>

