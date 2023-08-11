<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:choose>
    <c:when test="${not empty orders}">
        <h3 class="text-danger text-center mb-3">${error}</h3>
        <div class="mt-5 container">
            <form class="d-flex justify-content-end" method="get">
                <div class="me-3">
                    <select onchange="this.form.submit();" class="form-select" name="sort" id="sort">
                        <option label="Theo tên" value="n" ${sort.equals("n")?"selected":""}>Theo tên</option>
                        <option label="Theo số điện thoại" value="p" ${sort.equals("p")?"selected":""}>Theo số điện thoại</option>
                        <option label="Theo ngày đặt" value="d" ${sort.equals("d")?"selected":""}>Theo ngày đặt</option>
                        <option label="Mặc định" value="default" ${sort.equals("default")?"selected":""}>Mặc định</option>
                    </select>
                </div>
                <div>
                    <select onchange="this.form.submit();" class="form-select" name="order" id="order">
                        <option label="Cao đến thấp" value="h" ${order.equals("h")?"selected":""}>Cao đến thấp</option>
                        <option label="Thấp đến cao" value="l" ${order.equals("l")?"selected":""}>Thấp đến cao</option>
                    </select>
                </div>
            </form>
        </div>
        <div class="overflow-hidden border border-1 container p-0 rounded-3 my-5" style="border-color: var(--main-text-color)!important;">
            <h5 class="text-white mb-0 py-2 ps-3" style="background-color: var(--main-text-color)!important;">Đơn đã đặt</h5>
            <table class="table table-striped table-responsive-lg container-lg mb-0">
                <thead>
                <tr class="text-center main-text-color">
                    <th scope="col">#</th>
                    <th scope="col">Mã đơn hàng</th>
                    <th scope="col">Tên người nhận</th>
                    <th scope="col">Số điện thoại</th>
                    <th scope="col">Ngày đặt</th>
                    <th scope="col">Địa chỉ</th>
                    <th scope="col"></th>
                </tr>
                </thead>
                <tbody id="removable">
                <jsp:useBean id="orders" scope="request" type="java.util.List<sof3021.ca4.nhom1.asm.qls.model.Order>"/>
                <c:forEach var="order" items="${orders}" varStatus="status">
                    <tr>
                        <td class="text-center">${status.count}</td>
                        <td class="text-center">${order.maDH}</td>
                        <td class="text-center">${order.tenNguoiNhan}</td>
                        <td class="text-center">${order.sdt}</td>
                        <td class="text-center">
                            <fmt:formatDate value="${order.ngayXuat}" pattern="dd-MM-yyyy"/>
                        </td>
                        <td class="text-center">${order.diaChiNhan}</td>
                        <td>
                            <a href="/account/order/${order.maDH}" class="btn btn-light">
                                <i class="bi bi-search fs-5" style="-webkit-text-stroke: 1px var(--main-text-color);"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <nav aria-label="Page navigation" class="mt-5">
            <c:if test="${not empty order}">
                <c:set var="o" value="&order=${order}"/>
            </c:if>
            <c:if test="${not empty sort}">
                <c:set var="s" value="&sort=${sort}"/>
            </c:if>
            <ul class="pagination justify-content-center">
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/account/orders?page=${page.number-1 < 0 ? 0 : page.number-1}${o}${s}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <c:forEach begin="0" end="${page.totalPages-1 < 0 ? 0:page.totalPages-1}" var="curPage">
                    <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/account/orders?page=${curPage}${o}${s}">${curPage+1}</a></li>
                </c:forEach>
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/account/orders?page=${page.number+1 >= page.totalPages ? page.totalPages-1 : page.number+1}${o}${s}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
    </c:when>
    <c:otherwise>
        <jsp:include page="../common/book-not-found.jsp">
            <jsp:param name="reason" value="Bạn chưa có đơn hàng nào"/>
            <jsp:param name="btnText" value="Đặt ngay nào!"/>
        </jsp:include>
    </c:otherwise>
</c:choose>

