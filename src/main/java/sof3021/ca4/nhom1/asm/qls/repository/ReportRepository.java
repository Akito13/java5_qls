package sof3021.ca4.nhom1.asm.qls.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.hibernate.Session;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import sof3021.ca4.nhom1.asm.qls.model.Report;

import java.util.List;

@Repository
public class ReportRepository {
//    @PersistenceContext
//    private EntityManager entityManager;
//
//    public Page<Report> getBookStats(Pageable pageable) {
//        int pageNumber = pageable.getPageNumber();
//        int pageSize = pageable.getPageSize();
//        pageable.
//        var reportList = entityManager.unwrap(Session.class)
//                .createQuery("select Report(o.book.maSach, o.book.tenSach, o.book.img,sum(o.soLuong), sum(o.tongTien)) from OrderDetails o group by o.book.maSach", Report.class)
//                .setFirstResult(pageNumber * pageSize)
//                .setMaxResults(pageSize)
//                .getResultList();
////        List<Report> results = query.getResultList();
//        long totalCount = reportList.size() < pageable.getPageSize()
//                ? pageable.getPageSize()
//                :
//        return new Page<Report>()
//    };

}
