package sof3021.ca4.nhom1.asm.qls.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import sof3021.ca4.nhom1.asm.qls.model.OrderDetails;
import sof3021.ca4.nhom1.asm.qls.model.Report;

import java.util.List;

@Repository
public interface OrderDetailsRepository extends JpaRepository<OrderDetails, Integer> {
    @Query("SELECT od FROM OrderDetails od WHERE od.order.maDH = " +
            "(SELECT o.maDH FROM Order o WHERE o.user.maKH = ?1 AND o.maDH = ?2)")
    List<OrderDetails> findAllByUserAndOrder(Integer userId, Integer orderId);
    @Query(value = "SELECT\n" +
            "(\n" +
            "SELECT sum(dhct.tongtien) FROM donhangchitiet dhct\n" +
            "INNER JOIN donhang d on d.madh = dhct.madh\n" +
            "WHERE date_part('month', d.ngayxuat) = 8\n" +
            ") as monthlyProfit,\n" +
            "(\n" +
            "SELECT sum(dhct2.tongtien) FROM donhangchitiet dhct2\n" +
            "INNER JOIN donhang d2 on d2.madh = dhct2.madh\n" +
            "WHERE date_part('year', d2.ngayxuat) = 2023\n" +
            ")as annualProfit", nativeQuery = true)
    Report.Profit getMonthlyAndAnuallyProfit(Integer currentMonth, Integer currentYear);
}
