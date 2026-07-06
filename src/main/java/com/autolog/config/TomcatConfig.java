package com.autolog.config;



import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;

import org.springframework.boot.web.server.WebServerFactoryCustomizer;

import org.springframework.context.annotation.Bean;

import org.springframework.context.annotation.Configuration;



import java.io.File;



@Configuration

public class TomcatConfig {



    @Bean

    public WebServerFactoryCustomizer<TomcatServletWebServerFactory> tomcatCustomizer() {

        return factory -> {

            File webapp = resolveWebappDir();

            if (webapp != null) {

                factory.setDocumentRoot(webapp);

            }

            factory.addContextCustomizers(context -> context.setReloadable(true));

        };

    }



    private File resolveWebappDir() {

        File fromUserDir = new File(System.getProperty("user.dir"), "src/main/webapp");

        if (fromUserDir.isDirectory()) {

            return fromUserDir.getAbsoluteFile();

        }

        File relative = new File("src/main/webapp");

        if (relative.isDirectory()) {

            return relative.getAbsoluteFile();

        }

        return null;

    }

}

