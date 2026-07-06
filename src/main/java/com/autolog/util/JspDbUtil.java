package com.autolog.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public final class JspDbUtil {

    private JspDbUtil() {
    }

    public static Connection getConnection() throws SQLException {
        try {
            Properties prop = new Properties();
            InputStream in = JspDbUtil.class.getClassLoader().getResourceAsStream("application.properties");
            if (in != null) {
                prop.load(in);
                in.close();
            }

            String url = prop.getProperty("spring.datasource.url");
            String user = prop.getProperty("spring.datasource.username");
            String pass = prop.getProperty("spring.datasource.password");
            String driver = prop.getProperty("spring.datasource.driver-class-name");

            if (url == null || user == null) {
                throw new SQLException("datasource not configured in application.properties");
            }

            Class.forName(driver);
            return DriverManager.getConnection(url, user, pass);
        } catch (SQLException e) {
            throw e;
        } catch (Exception e) {
            throw new SQLException("DB connection failed: " + e.getMessage(), e);
        }
    }

    public static String esc(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "");
    }
}
