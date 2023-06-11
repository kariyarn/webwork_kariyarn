<%@page import="java.util.List"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	final int PAGE_ROW_COUNT = 5;
	final int PAGE_DISPLAY_COUNT = 5;
	
	int pageNum = 1;
	
	String strPageNum = request.getParameter("pageNum");
	if(strPageNum != null){
		//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
		pageNum=Integer.parseInt(strPageNum);
	}		

	//보여줄 페이지의 시작 ROWNUM
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	//보여줄 페이지의 끝 ROWNUM
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	
	//하단 시작 페이지 번호 
	int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	//하단 끝 페이지 번호
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
	//전체 글의 갯수
	int totalRow=CafeDao.getInstance().getCount();
	//전체 페이지의 갯수 구하기
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
	if(endPageNum > totalPageCount){
		endPageNum=totalPageCount; //보정해 준다. 
	}
	
	CafeDto dto = new CafeDto();
	dto.setStartNum(startRowNum);
	dto.setEndNum(endRowNum);

	List<CafeDto> list = CafeDao.getInstance().getList(dto);
	String id = (String)session.getAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/list.jsp</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" />
</head>
<body>
<div class="container">
	<h1>게시글 목록 입니다</h1>
	<a href="private/insertform.jsp">새글 작성</a>
	<table class="table">
		<thead>
			<tr>
				<th>글번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>조회수</th>
				<th>등록일</th>
			</tr>
		</thead>
		<tbody>
			<%for(CafeDto tmp : list){ %>
				<tr>
				 	<td><%=tmp.getNum() %></td>
				 	<td><%=tmp.getWriter()%></td>
				 	<td>
				 		<a href="view.jsp?num=<%=tmp.getNum() %>"><%=tmp.getTitle()%></a>
				 	</td>
				 	<td><%=tmp.getViewCount()%></td>
				 	<td><%=tmp.getRegdate()%></td>
				</tr>
			<%} %>
		</tbody>
	</table>
			<ul class="pagination">
			<%--
				startPageNum 이 1 이 아닌 경우에만 Prev 링크를 제공한다. 
			--%>
			<%if(startPageNum != 1){ %>
				<li class="page-item">
					<a class="page-link" href="list.jsp?pageNum=<%=startPageNum-1 %>">Prev</a>
				</li>
			<%} %>
			<%for(int i=startPageNum; i<=endPageNum; i++){ %>
				<li class="page-item <%= i==pageNum ? "active":"" %>">
					<a class="page-link" href="list.jsp?pageNum=<%=i %>"><%=i %></a>
				</li>
			<%} %>
			<%--
				마지막 페이지 번호가 전체 페이지의 갯수보다 작으면 Next 링크를 제공한다. 
			--%>
			<%if(endPageNum < totalPageCount){ %>
				<li class="page-item">
					<a class="page-link" href="list.jsp?pageNum=<%=endPageNum+1 %>">Next</a>
				</li>
			<%} %>
		</ul>
</div>
</body>
</html>