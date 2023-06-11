<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  int num = Integer.parseInt(request.getParameter("num"));
	CafeDto dto = CafeDao.getInstance().getData(num);
	boolean count = CafeDao.getInstance().viewCount(num);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" />
</head>
<body>
	<div class="container">
		<h1>뷰&수정&삭제 페이지입니다.</h1>
	
			<div>
				<label for="num" class="form-label">글 번호</label>
				<input class="form-control" type="text" name="num" id="num" value="<%=dto.getNum()%>" readonly/>
			</div>
			<div>
				<label for="count" class="form-label">조회수</label>
				<input class="form-control" type="text" name="count" id="count" value="<%=dto.getViewCount()%>" readonly/>
			</div>
			<div>
				<label for="writer" class="form-label">작성자</label>
				<input class="form-control" type="text" name="writer" id="writer" value="<%=dto.getWriter() %>" readonly/>
			</div>
			<div>
				<label for="title" class="form-label">제목</label>
				<input class="form-control" type="text" name="title" id="title" value="<%=dto.getTitle() %>" readonly/>
			</div>
			<div>
				<label for="content" class="form-label">내용</label>
				<textarea class="form-control" name="content" id="content"  rows="10" readonly><%=dto.getContent() %></textarea>
			</div>
		<button type="button" onclick="location.href='${pageContext.request.contextPath }/cafe/list.jsp'">목록으로</button>
		<button type="button" onclick="location.href='updateform.jsp?num=<%=num%>'">수정</button>
		<button type="button" onclick="location.href='delete.jsp?num=<%=num%>'">삭제</button>
	</div>
</body>
</html>