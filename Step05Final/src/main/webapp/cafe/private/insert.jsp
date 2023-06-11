<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String)session.getAttribute("id");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	CafeDto dto = new CafeDto();
	dto.setWriter(id);
	dto.setTitle(title);
	dto.setContent(content);
	
	boolean isSuccess = CafeDao.getInstance().insert(dto);
		
	String cPath = request.getContextPath();
	response.sendRedirect(cPath+"/cafe/list.jsp");

%>