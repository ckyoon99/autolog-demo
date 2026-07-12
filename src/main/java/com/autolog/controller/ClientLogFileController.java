package com.autolog.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
public class ClientLogFileController {

    @Value("${autolog.client-log.dir:data/client-logs}")
    private String clientLogDir;

    @GetMapping("/logs/{fileName:.+}")
    public ResponseEntity<byte[]> getLogFile(@PathVariable String fileName) {
        if (!fileName.matches("\\d{8}\\.log")) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid log file name".getBytes(StandardCharsets.UTF_8));
        }

        try {
            Path logFile = Paths.get(clientLogDir).toAbsolutePath().normalize().resolve(fileName);
            if (!Files.exists(logFile)) {
                return ResponseEntity.notFound().build();
            }

            byte[] body = Files.readAllBytes(logFile);
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(new MediaType("text", "plain", StandardCharsets.UTF_8));

            return new ResponseEntity<byte[]>(body, headers, HttpStatus.OK);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(("Failed to read log file: " + e.getMessage()).getBytes(StandardCharsets.UTF_8));
        }
    }
}
