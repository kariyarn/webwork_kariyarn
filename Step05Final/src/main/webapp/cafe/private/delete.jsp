<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	CafeDto dto = CafeDao.getInstance().getData(num);
	
	String id = (String)session.getAttribute("id");
	if(!dto.getWriter().equals(id)){
		response.sendError(HttpServletResponse.SC_FORBIDDEN, "작성자가 일치하지 않습니다.");
		return;
	}
	boolean isSuccess = CafeDao.getInstance().delete(num);
	if(isSuccess){
		String cPath = request.getContextPath();
		response.sendRedirect(cPath+"/cafe/list.jsp");
	}else{
		String cPath = request.getContextPath();
		response.sendRedirect(cPath+"/cafe/view.jsp?=num=" + num);
	}
%>