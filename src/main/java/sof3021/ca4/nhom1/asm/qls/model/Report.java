package sof3021.ca4.nhom1.asm.qls.model;

import jakarta.persistence.Entity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
//@AllArgsConstructor
@NoArgsConstructor
public class Report {
    private Integer maSach;
    private String tenSach;
    private String img;
    private Long soLuongBan;
    private Double tongDoanhThu;

    public Report(Integer maSach, String tenSach, String img, Long soLuongBan, Double tongDoanhThu) {
        this.maSach = maSach;
        this.tenSach = tenSach;
        this.img = img;
        this.soLuongBan = soLuongBan;
        this.tongDoanhThu = tongDoanhThu;
    }

    public interface Profit {
        Double getMonthlyProfit();
        Double getAnnualProfit();
    }
}
