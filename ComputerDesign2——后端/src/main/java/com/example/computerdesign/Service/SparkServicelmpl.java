package com.example.computerdesign.Service;

import com.example.computerdesign.Utils.BigModelNew;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.WebSocket;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class SparkServicelmpl {

    @Value("${spark.apiKey}")
    private String apiKey;

    @Value("${spark.apiSecret}")
    private String apiSecret;

    @Value("${spark.appid}")
    private String appid;

    @Value("${spark.hostUrl}")
    private String hostUrl;

    @Value("${spark.domain}")
    private String domain;

    public String askQuestion(String question) throws Exception {
        BigModelNew.totalAnswer = "";

        BigModelNew bigModel = new BigModelNew("user123", false);
        bigModel.NewQuestion = question;

        String authUrl = BigModelNew.getAuthUrl(hostUrl, apiKey, apiSecret);
        OkHttpClient client = new OkHttpClient.Builder().build();
        String url = authUrl.toString().replace("http://", "ws://").replace("https://", "wss://");
        Request request = new Request.Builder().url(url).build();

        WebSocket webSocket = client.newWebSocket(request, bigModel);

        while (!bigModel.wsCloseFlag) {
            Thread.sleep(200);
        }

        return BigModelNew.totalAnswer;
    }
}
