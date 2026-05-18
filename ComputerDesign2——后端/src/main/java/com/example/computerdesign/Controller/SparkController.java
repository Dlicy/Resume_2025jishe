package com.example.computerdesign.Controller;

import com.example.computerdesign.Response;
import com.example.computerdesign.Service.SparkServicelmpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class SparkController {

    @Autowired
    private SparkServicelmpl sparkServicelmpl;

    @PostMapping("/ask")
    public Response ask(@RequestBody String question) throws Exception {
        question = question.replace("\"", "").trim();
        Map<String, Object> responseBody = new HashMap<>();
        responseBody.put("iflyAnswer", sparkServicelmpl.askQuestion(question));
        responseBody.put("result", "AI回复成功！");
        return Response.newSuccess(responseBody);
    }
}
