package com.controller;

import com.logic.PingManager;
import com.model.PingAnalyticRequest;
import com.model.PingAnalyticResponse;
import com.model.Request;
import com.model.Response;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RequestHandler {

    @GetMapping("/")
    String home() {
        return "INFO: Welcome to Ping-manager!";
    }

    @PostMapping("/process")
    Response handleRequest(@RequestBody Request request) {

        Response response = new Response();

        try {

            String input = request.getUrl();

            if (input == null || input.trim().isEmpty())
                throw new NullPointerException("Error: Input found either NULL or empty.");
            else{

                PingAnalyticRequest pingAnalyticRequest = new PingAnalyticRequest();
                pingAnalyticRequest.setUrl(input);

                PingManager pingManager = new PingManager();
                PingAnalyticResponse pingAnalyticResponse = pingManager.pingURL(pingAnalyticRequest);

                response.setMessage("INFO: Request execute successfully.");
                response.setError(false);
                response.setPingAnalyticResponse(pingAnalyticResponse);
            }

        } catch (Exception e){
            response.setError(true);
            response.setMessage(e.getMessage());
            e.printStackTrace();
        }

        return  response;
    }
}
