package sof3021.ca4.nhom1.asm.qls.controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import sof3021.ca4.nhom1.asm.qls.model.Book;
import sof3021.ca4.nhom1.asm.qls.model.Category;
import sof3021.ca4.nhom1.asm.qls.model.Order;
import sof3021.ca4.nhom1.asm.qls.model.Report;
import sof3021.ca4.nhom1.asm.qls.repository.BookRepository;
import sof3021.ca4.nhom1.asm.qls.repository.CategoryRepository;
import sof3021.ca4.nhom1.asm.qls.repository.OrderDetailsRepository;
import sof3021.ca4.nhom1.asm.qls.repository.ReportRepository;

import java.io.File;
import java.nio.file.Files;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ServletContext app;
    @Autowired
    private BookRepository bookRepo;
    @Autowired
    private CategoryRepository cateRepo;
    @Autowired
    private OrderDetailsRepository odRepo;

    @GetMapping("/book/remove/{id}")
    public String delete(Model model, @PathVariable Optional<Integer> id){
        id.ifPresent(integer -> bookRepo.deleteById(integer));
//        model.addAttribute("view", "pages/show-room.jsp");
        return "redirect:/books/"+id.get();
    }

    @GetMapping("/book/update/{id}")
    public String update(@PathVariable Optional<Integer> id,
                         RedirectAttributes params) {
        if(id.isEmpty())
            return "redirect:/books/";

        Optional<Book> result = bookRepo.findById(id.get());
        if(result.isEmpty())
            return "redirect:/books/";

        params.addFlashAttribute("book", result.get());
        params.addFlashAttribute("action", "edit");
        return "redirect:/admin/book/edit";
    }

    @GetMapping("/book/edit")
    public String getEdit(Model model) {
        Book book = (Book) model.getAttribute("book");
        if(book == null)
            return "redirect:/books/";

        String message = (String) model.getAttribute("message");
        if(message != null)
            model.addAttribute("message", message);

        String error = (String) model.getAttribute("error");
        if(error != null)
            model.addAttribute("error", error);
        String action = (String) model.getAttribute("action");
        if(action != null && action.equals("create")) action = "edit";
        if(action == null) action = "create";
        model.addAttribute("book", book);
        model.addAttribute("action", action);
        model.addAttribute("view", "pages/admin.jsp");
        return "index";
    }

    @PostMapping("/book/edit")
    public String edit(@Valid @ModelAttribute("book") Book book,
                       BindingResult result,
                       @RequestParam("hiddenImgInput") MultipartFile file,
                       RedirectAttributes params,
                       HttpServletRequest req) {
        if(!file.isEmpty()) {
            try {
                String fileName = StringUtils.cleanPath(file.getOriginalFilename());
                File folder = new File(app.getRealPath("/images/"));
                if(!Files.exists(folder.toPath())){
                    Files.createDirectories(folder.toPath());
                }
                File data = new File(folder, fileName);
                file.transferTo(data);
            } catch (Exception e) {
                e.printStackTrace();
                result.rejectValue("img", "book.img.error", "Failed to upload image");
            }
        }
        String action = req.getParameter("action");
        if(result.hasErrors()){
            params.addFlashAttribute("error", "Could not complete task");
            action = null;
        } else {
            params.addFlashAttribute("message",   (action.equals("create") ? "Created":"Edited")
                    + " successfully");
            bookRepo.save(book);
        }
        params.addFlashAttribute("org.springframework.validation.BindingResult.book",result );
        params.addFlashAttribute("book", book);
        params.addFlashAttribute("action", action);
        return "redirect:/admin/book/edit";
    }

    @GetMapping("/book/create")
    public String create(RedirectAttributes params,
                         @ModelAttribute("book") Book book) {
        params.addFlashAttribute("book", book);
        return "redirect:/admin/book/edit";
    }

    @GetMapping("/stats")
    public String getStats(Model model,
                           @RequestParam("sort") Optional<String> sortBy,
                           @RequestParam("order") Optional<String> orderBy){
        String sb = sortBy.orElse("sl");
        String ob = orderBy.orElse("h");
        List<Report> reports = bookRepo.getBookStats();
        Date currentTime = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(currentTime);
        Report.Profit doanhThu = odRepo.getMonthlyAndAnuallyProfit(calendar.get(Calendar.MONTH)+1, calendar.get(Calendar.YEAR));
        reports.sort((o1, o2) -> {
            if(sb.equals("sl")) return o1.getSoLuongBan().compareTo(o2.getSoLuongBan()) * (ob.equals("h") ? -1 : 1);
            else return (int) (o1.getTongDoanhThu() - o2.getTongDoanhThu()) * (ob.equals("h") ? -1 : 1);
        });
        model.addAttribute("order", ob);
        model.addAttribute("sort", sb);
        model.addAttribute("reports", reports);
        model.addAttribute("dt", doanhThu);
        model.addAttribute("view", "pages/stats.jsp");
        return "index";
    }

    private Sort createSort(Sort sort, String orderBy, String sortBy){
        switch (sortBy) {
            case "dt" -> sort = Sort.by(orderBy.equals("h") ? Sort.Direction.DESC : Sort.Direction.ASC, "tongDoanhThu");
            default -> sort = Sort.by(orderBy.equals("h") ? Sort.Direction.DESC : Sort.Direction.ASC, "soLuongBan");
        }
        return sort;
    }

    @ModelAttribute("categories")
    public List<Category> getCategories(){
        return cateRepo.findAll();
    }
}
