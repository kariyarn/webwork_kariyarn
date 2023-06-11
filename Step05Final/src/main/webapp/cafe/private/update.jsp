<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	int num = Integer.parseInt(request.getParameter("num"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	CafeDto dto = new CafeDto();
	dto.setNum(num);
	dto.setTitle(title);
	dto.setContent(content);
	
	boolean isSuccess = CafeDao.getInstance().update(dto);
	
	if(isSuccess){
		String cPath = request.getContextPath();
		response.sendRedirect(cPath+"/cafe/list.jsp");
	}else{
		String cPath = request.getContextPath();
		response.sendRedirect(cPath+"/cafe/private/updateform.jsp?num="+num);
	}

%>