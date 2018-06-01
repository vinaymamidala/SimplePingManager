package com.model;

public class Response {

    private boolean error;
    private String message;
    private PingAnalyticResponse pingAnalyticResponse;

    public Response(){
        error = false;
    }


    public boolean isError() {
        return error;
    }

    public void setError(boolean error) {
        this.error = error;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public PingAnalyticResponse getPingAnalyticResponse() {
        return pingAnalyticResponse;
    }

    public void setPingAnalyticResponse(PingAnalyticResponse pingAnalyticResponse) {
        this.pingAnalyticResponse = pingAnalyticResponse;
    }
}
