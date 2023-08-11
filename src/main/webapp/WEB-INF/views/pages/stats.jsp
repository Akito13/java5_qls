<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
  #book-link:hover {
    color: var(--main-text-color)!important;
  }
</style>
<div class="container py-5">
  <div class="mb-3 d-flex justify-content-evenly">
    <div class="card" style="width: 18rem; background-image: url('/imgs/stats-1.avif'); background-size: cover; height: 12rem;">
      <div class="card-body">
        <h5 class="card-title text-white">Doanh thu tháng này</h5>
        <p class="card-text text-white">
          <fmt:formatNumber type="currency" value="${dt.monthlyProfit}" pattern="#,###đ" />
        </p>
      </div>
    </div>
    <div class="card" style="width: 18rem; background-image: url('/imgs/stats-2.avif'); background-size: cover; height: 12rem;">
      <div class="card-body">
        <h5 class="card-title text-white">Doanh thu trong năm</h5>
        <p class="card-text text-white">
          <fmt:formatNumber type="currency" value="${dt.annualProfit}" pattern="#,###đ" />
        </p>
      </div>
    </div>
  </div>
  <div class="mt-5 container">
    <form class="d-flex justify-content-end" method="get">
      <div class="me-3">
        <select onchange="this.form.submit();" class="form-select" name="sort" id="sort">
          <option label="Theo số lượng" value="sl" ${sort.equals("sl")?"selected":""}>Theo số lượng</option>
          <option label="Theo doanh thu" value="dt" ${sort.equals("dt")?"selected":""}>Theo doanh thu</option>
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
  <div>
    <div class="overflow-hidden border border-1 container p-0 rounded-3 my-5" style="border-color: var(--main-text-color)!important;">
      <div class="text-white mb-0 py-2 d-flex" style="background-color: var(--main-text-color)!important;">
        <div class="fw-semibold fs-6 mb-0 w-10 ps-3">Sản phẩm</div>
        <div class="fw-semibold fs-6 flex-grow-1 align-self-center"></div>
        <div class="fw-semibold fs-6 text-center w-10 align-self-center">Số lượng</div>
        <div class="fw-semibold fs-6 text-center w-25 align-self-center">Doanh thu</div>
      </div>
      <div>
        <c:forEach var="book" items="${reports}" varStatus="status">
          <div class="d-flex text-black my-3">
            <div class="w-25 d-flex">
              <div class="text-center align-self-center" style="width: 80px; height: 80px;">
                <img class="img-fluid" style="height: 100%;" src="/imgs/${book.img}" alt="Ảnh sách">
              </div>
              <div class="align-self-center" style="max-width: 240px;">
                <a id="book-link" href="${pageContext.servletContext.contextPath}/books/${book.maSach}" class="text-decoration-none text-black">
                  <span class="d-block w-100 custom-truncator" style="word-break: break-all" id="book-${book.maSach}">${book.tenSach}</span>
                </a>
              </div>
            </div>
            <div class="flex-grow-1 align-self-center"></div>
            <div class="text-center w-10 align-self-center">${book.soLuongBan}</div>
            <div class="text-center w-25 align-self-center"><fmt:formatNumber type="currency" value="${book.tongDoanhThu}" pattern="#,###đ" /></div>
          </div>
          <c:if test="${not status.last}">
            <div class="border-top border-1 mt-3" style="border-color: var(--main-text-color)!important;"></div>
          </c:if>
        </c:forEach>
      </div>
    </div>
  </div>
</div>