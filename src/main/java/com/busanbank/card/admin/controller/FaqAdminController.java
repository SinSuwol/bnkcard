package com.busanbank.card.admin.controller;

import com.busanbank.card.faq.dao.FaqDao;
import com.busanbank.card.faq.dto.FaqDto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@Controller
@RequestMapping("/admin/faq")
public class FaqAdminController {

    @Autowired
    private FaqDao faqDao;

    @GetMapping("/list")
    public String getAllFaqs(Model model) {
        List<FaqDto> list = faqDao.getAllFaqs();
        model.addAttribute("faqList", list);
        return "admin/faq/list";
    }

    @GetMapping("/insertForm")
    public String insertForm() {
        return "admin/faq/insertForm";
    }

    @PostMapping("/add")
    public String addFaq(FaqDto dto) {
        faqDao.insertFaq(dto);
        sendFaqsToFastApi(faqDao.getAllFaqs());
        reloadFastApiModel();   // ✅ 리로드 추가
        return "redirect:/admin/faq/list";
    }



    @GetMapping("/editForm")
    public String editForm(@RequestParam("faqNo") int faqNo, Model model) {
        FaqDto dto = faqDao.getFaqById(faqNo);
        model.addAttribute("faq", dto);
        return "admin/faq/editForm";
    }

    @PostMapping("/edit")
    public String editFaq(FaqDto dto) {
        faqDao.updateFaq(dto);
        sendFaqsToFastApi(faqDao.getAllFaqs());
        reloadFastApiModel();
        return "redirect:/admin/faq/list";
    }

    @GetMapping("/delete")
    public String deleteFaq(@RequestParam("faqNo")  int faqNo) {
        faqDao.deleteFaq((long) faqNo);
        sendFaqsToFastApi(faqDao.getAllFaqs());
        reloadFastApiModel();
        return "redirect:/admin/faq/list";
    }

    @PostMapping("/sync-to-ai")
    @ResponseBody
    public String syncFaqToAi() {
        List<FaqDto> faqs = faqDao.getAllFaqs();
        return sendFaqsToFastApi(faqs);
    }

    private String sendFaqsToFastApi(List<FaqDto> faqs) {
        String aiUrl = "http://localhost:8000/update-faq";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<List<FaqDto>> entity = new HttpEntity<>(faqs, headers);

        RestTemplate restTemplate = new RestTemplate();

        try {
            String result = restTemplate.postForObject(aiUrl, entity, String.class);
            System.out.println("FastAPI 응답: " + result);
            return "FastAPI 업데이트 완료: " + result;
        } catch (Exception e) {
            e.printStackTrace();
            return "FastAPI 갱신 실패: " + e.getMessage();
        }
    }
    
    private void reloadFastApiModel() {
        String reloadUrl = "http://localhost:8000/reload-model";

        RestTemplate restTemplate = new RestTemplate();
        try {
            String result = restTemplate.postForObject(reloadUrl, null, String.class);
            System.out.println("FastAPI 모델 리로드 응답: " + result);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
