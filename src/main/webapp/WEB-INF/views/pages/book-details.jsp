<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:choose>
    <c:when test="${not empty book}">
        <article class="row row-cols-lg-2 row-cols-1 px-lg-3 px-4 mt-5
                        mx-auto pb-5" style="width: 90%">
            <aside class="col col-lg-5">
                <div class="w-75 float-lg-end mx-auto text-center text-lg-start" style="height: 420px;">
                    <img src="/images/${book.img}" alt="Book thumbnail" class="h-100 img-fluid">
                </div>
            </aside>
            <main class="col col-lg-7 main-text-color py-3 px-0">
                <h2 class="text-center text-lg-start text-white" id="book-${book.maSach}">${book.tenSach}</h2>
                <p class="text-black fw-semibold" style="font-size: 1.2rem!important;">Tác giả: ${book.tacGia}</p>
                <p class="text-black fw-semibold" style="font-size: 1.2rem!important;">Ngày xuất bản: ${book.nxb}</p>
                <p class="fs-3 mt-3">
                    Giá: <span class="fw-semibold"><fmt:formatNumber type="currency" value="${book.gia}" pattern="#,###đ"/></span>
                    <span class="fs-6 fw-normal">(Còn lại: ${book.soLuong})</span>
                </p>
                <form action="/cart/add/${book.maSach}" method="get">
                    <div class="d-flex w-50 justify-content-start align-items-center">
                        <label class="fs-5 " for="qt">Số lượng: </label>
                        <input class="form-control w-25 ms-3" id="qt" pattern="[0-9]*" type="text" name="quantity" inputmode="numeric" placeholder="1">
                        <input type="hidden" name="from" value="${from}">
                        <button type="submit" class="btn btn-success ms-3">Thêm vào giỏ</button>
                    </div>
                </form>
                <c:if test="${not empty sessionScope.user && sessionScope.user.admin}">
                    <div class="d-flex admin mt-5" id="removable">
                        <a href="/admin/book/update/${book.maSach}" class="btn btn-primary me-3">Cập nhật sách</a>
                        <button id="brbtn-${book.maSach}" type="button" data-bs-toggle="modal" data-bs-target="#confirmModal" class="btn btn-danger">Xóa sách</button>
                        <jsp:include page="../modals/confirm-modal.jsp">
                            <jsp:param name="modalTitle" value="Deleting book..."/>
                        </jsp:include>
                    </div>
                </c:if>
            </main>
        </article>
        <div class="mb-5 px-lg-5 px-4 mx-auto d-flex flex-column align-items-start" style="width: 90%; padding-left: 5.5rem!important;">
            <h5 class="fw-semibold main-text-color mb-3 border-1 border-bottom pb-3" style="width: 90%; border-color: var(--main-text-color)!important;">Tóm tắt nội dung</h5>
            <p class="ps-5 text-lg-start w-75">${book.chiTiet}</p>
        </div>
        <div class="mb-5 px-lg-5 px-4 mx-auto d-flex flex-column align-items-start" style="width: 90%; padding-left: 5.5rem!important;">
            <h3 class="fw-semibold main-text-color mb-3 pb-3" style="width: 90%">Sách liên quan</h3>
            <div id="carouselExampleFade" class="carousel slide w-100">
                <div class="carousel-inner">
                    <c:forEach begin="0" end="${books.size()-1}" var="item" items="${books}" varStatus="loop" step="3">
                        <div class="carousel-item ${loop.count == 1 ? "active" : ''}">
                            <div class="d-flex justify-content-center">
                                <jsp:include page="../common/book.jsp" >
                                    <jsp:param name="maSach" value="${item.maSach}"/>
                                    <jsp:param name="img" value="${item.img}"/>
                                    <jsp:param name="tenSach" value="${item.tenSach}"/>
                                    <jsp:param name="nxb" value="${item.nxb}"/>
                                    <jsp:param name="soLuong" value="${item.soLuong}"/>
                                    <jsp:param name="gia" value="${item.gia}"/>
                                </jsp:include>
                                <c:if test="${loop.index <= books.size()-2}">
                                    <jsp:include page="../common/book.jsp" >
                                        <jsp:param name="maSach" value="${books[loop.index+1].maSach}"/>
                                        <jsp:param name="img" value="${books[loop.index+1].img}"/>
                                        <jsp:param name="tenSach" value="${books[loop.index+1].tenSach}"/>
                                        <jsp:param name="nxb" value="${books[loop.index+1].nxb}"/>
                                        <jsp:param name="soLuong" value="${books[loop.index+1].soLuong}"/>
                                        <jsp:param name="gia" value="${books[loop.index+1].gia}"/>
                                    </jsp:include>
                                </c:if>
                                <c:if test="${loop.index <= books.size()-3}">
                                    <jsp:include page="../common/book.jsp" >
                                        <jsp:param name="maSach" value="${books[loop.index+2].maSach}"/>
                                        <jsp:param name="img" value="${books[loop.index+2].img}"/>
                                        <jsp:param name="tenSach" value="${books[loop.index+2].tenSach}"/>
                                        <jsp:param name="nxb" value="${books[loop.index+2].nxb}"/>
                                        <jsp:param name="soLuong" value="${books[loop.index+2].soLuong}"/>
                                        <jsp:param name="gia" value="${books[loop.index+2].gia}"/>
                                    </jsp:include>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <button class="carousel-control-prev text-danger" type="button" style="left: -5%" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next text-danger" type="button" style="right: -5%" data-bs-target="#carouselExampleFade" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <jsp:include page="../common/book-not-found.jsp">
            <jsp:param name="reason" value="Không tìm thấy sách"/>
            <jsp:param name="btnText" value="Tìm sách bạn muốn!"/>
        </jsp:include>
    </c:otherwise>
</c:choose>

