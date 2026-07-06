package com.autolog.controller;



import com.fasterxml.jackson.databind.ObjectMapper;

import org.slf4j.Logger;

import org.slf4j.LoggerFactory;

import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestBody;

import org.springframework.web.bind.annotation.RestController;



import java.nio.charset.StandardCharsets;

import java.nio.file.Files;

import java.nio.file.Path;

import java.nio.file.Paths;

import java.nio.file.StandardOpenOption;

import java.time.LocalDateTime;

import java.time.format.DateTimeFormatter;

import java.util.Collections;

import java.util.Map;



@RestController

public class ClientLogController {



    private static final Logger log = LoggerFactory.getLogger("CLIENT-LOG");

    private static final DateTimeFormatter FILE_DATE = DateTimeFormatter.ofPattern("yyyyMMdd");

    private static final DateTimeFormatter LOG_TIME = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    private static final ObjectMapper MAPPER = new ObjectMapper();



    @PostMapping("/api/client-log")

    public Map<String, String> receiveClientLog(@RequestBody Map<String, Object> payload) {

        try {

            String json = MAPPER.writeValueAsString(payload);

            String type = String.valueOf(payload.getOrDefault("type", ""));

            String message = String.valueOf(payload.getOrDefault("message", ""));

            String path = String.valueOf(payload.getOrDefault("path", ""));

            String userName = String.valueOf(payload.getOrDefault("userName", ""));

            String menuTitle = String.valueOf(payload.getOrDefault("menuTitle", ""));



            if ("exception".equals(type)) {

                log.error("[CLIENT-LOG] type={} path={} user={} menu={} message={}",

                        type, path, userName, menuTitle, message);

                log.error("[CLIENT-LOG] detail={}", json);

            } else {

                log.info("[CLIENT-LOG] type={} path={} user={} menu={} message={}",

                        type, path, userName, menuTitle, message);

            }



            writeToFile(json);

        } catch (Exception e) {

            log.warn("[CLIENT-LOG] receive failed: {}", e.getMessage());

        }

        return Collections.singletonMap("status", "logged");

    }



    private void writeToFile(String json) {

        try {

            Path logsDir = Paths.get(System.getProperty("user.dir"), "logs", "client");

            if (Files.notExists(logsDir)) {

                Files.createDirectories(logsDir);

            }

            String fileName = LocalDateTime.now().format(FILE_DATE) + ".log";

            Path logFile = logsDir.resolve(fileName);

            String line = "[" + LocalDateTime.now().format(LOG_TIME) + "] " + json + System.lineSeparator();

            Files.write(logFile, line.getBytes(StandardCharsets.UTF_8),

                    StandardOpenOption.CREATE, StandardOpenOption.APPEND);

        } catch (Exception e) {

            log.warn("[CLIENT-LOG] file write failed: {}", e.getMessage());

        }

    }

}

