<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	int num = Integer.parseInt(request.getParameter("num"));
	String writer = request.getParameter("writer");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	CafeDto dto = new CafeDto();
	dto.setWriter(writer);
	dto.setNum(num);
	dto.setTitle(title);
	dto.setContent(content);
	
	String id = (String)session.getAttribute("id");
	if(!dto.getWriter().equals(id)){
		response.sendError(HttpServletResponse.SC_FORBIDDEN, "작성자가 일치하지 않습니다.");
		return;
	}
	
	boolean isSuccess = CafeDao.getInstance().update(dto);
	
	if(isSuccess){
		String cPath = request.getContextPath();
		response.sendRedirect(cPath+"/cafe/list.jsp");
	}else{
		String cPath = request.getContextPath();
		response.sendRedirect(cPath+"/cafe/private/updateform.jsp?num="+num);
	}

%>