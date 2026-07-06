<%
	/**
	 * 로그 수집 서버
	 *
	 * | DATE | NAME | DESC |
	 * |------|------|------|
	 * | 2025.06.27 | 윤창기 | 최초생성 |
	 */
%>
<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.nio.file.*"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="coreframe.util.json.*"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	response.setCharacterEncoding("utf-8");

	//payload 받기
	BufferedReader reader = new BufferedReader(new InputStreamReader(request.getInputStream(), "utf-8"));
	StringBuilder sb = new StringBuilder();
	String line;
	while ((line = reader.readLine()) != null) {
		sb.append(line);
	}
	reader.close();

	//JSON 데이터 추출
	//JSONObject jsonObject = new JSONObject(sb.toString());
	//String message = jsonObject.getString("message");
	//String path = jsonObject.getString("path");

	//로그 저장
	if (sb.toString() != null && !sb.toString().trim().isEmpty()) {
		// 로그 저장  
		if (sb.toString() != null && !sb.toString().trim().isEmpty()) {
			try {
				// 1. 현재 JSP의 물리적 경로를 기준으로 logs 폴더 경로 설정  
				String currentJspPath = application.getRealPath(request.getServletPath());
				Path logsDirPath = Paths.get(currentJspPath).getParent().resolve("logs");

				// 2. logs 폴더가 없으면 생성 (계층 구조 포함)  
				if (Files.notExists(logsDirPath)) {
					Files.createDirectories(logsDirPath);
				}

				// 3. 파일명 생성 (YYYYMMDD.log)  
				String dateFileName = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd")) + ".log";
				Path logFilePath = logsDirPath.resolve(dateFileName);

				// 4. 로그 내용 구성 (시간 추가 + 줄바꿈)  
				String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
				String logEntry = "[" + timestamp + "] " + sb.toString() + System.lineSeparator();

				// 5. 파일 쓰기 (파일이 없으면 생성, 있으면 끝에 추가)  
				Files.write(
					logFilePath,
					logEntry.getBytes(StandardCharsets.UTF_8),
					StandardOpenOption.CREATE,
					StandardOpenOption.APPEND);
System.err.println("logFilePath: " + logFilePath);
			} catch (IOException e) {
				// 에러 발생 시 서버 콘솔에 기록 (실무에서는 별도 로그 처리 권장)  
				e.printStackTrace();
			}
		}

	}
%>