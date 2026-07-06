package com.autolog.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @GetMapping("/MyAssets")
    public String myAssets() {
        return "MyAssets";
    }

    @GetMapping("/WealthManagement")
    public String wealthManagement() {
        return "WealthManagement";
    }

    @GetMapping("/Pension")
    public String pension() {
        return "Pension";
    }

    @GetMapping("/Trading")
    public String trading() {
        return "Trading";
    }

    @GetMapping("/Investment")
    public String investment() {
        return "Investment";
    }

    /* 데모 사이트 — mock JSON (_메뉴명01.jsp) */
    @GetMapping("/_MyAssets01")
    public String mockMyAssets01() {
        return "_MyAssets01";
    }

    @GetMapping("/_WealthManagement01")
    public String mockWealthManagement01() {
        return "_WealthManagement01";
    }

    @GetMapping("/_Pension01")
    public String mockPension01() {
        return "_Pension01";
    }

    @GetMapping("/_Trading01")
    public String mockTrading01() {
        return "_Trading01";
    }

    @GetMapping("/_Investment01")
    public String mockInvestment01() {
        return "_Investment01";
    }

    /* 데모 코드 — DB 쿼리 샘플 (메뉴명01.jsp) */
    @GetMapping("/MyAssets01")
    public String myAssets01() {
        return "MyAssets01";
    }

    @GetMapping("/WealthManagement01")
    public String wealthManagement01() {
        return "WealthManagement01";
    }

    @GetMapping("/Pension01")
    public String pension01() {
        return "Pension01";
    }

    @GetMapping("/Trading01")
    public String trading01() {
        return "Trading01";
    }

    @GetMapping("/Investment01")
    public String investment01() {
        return "Investment01";
    }
}
