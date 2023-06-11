<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  int num = Integer.parseInt(request.getParameter("num"));
	CafeDto dto = CafeDao.getInstance().getData(num);
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
		<h1>수정 페이지입니다.</h1>
		<form action="update.jsp" method="post">
			<div>
				<label class="form-label" for="num">글 번호</label>
				<input class="form-control" type="text" name="num" id="num" value="<%=dto.getNum()%>" readonly/>
			</div>
			<div>
				<label class="form-label" for="writer">작성자</label>
				<input class="form-control" type="text" name="writer" id="writer" value="<%=dto.getWriter() %>" readonly/>
			</div>
			<div>
				<label class="form-label" for="title">제목</label>
				<input class="form-control" type="text" name="title" id="title" value="<%=dto.getTitle() %>"/>
			</div>
			<div>
				<label class="form-label" for="content">내용</label>
				<textarea class="form-control" name="content" id="content"  rows="10"><%=dto.getContent() %></textarea>
			</div>
			<button type="submit">수정 확인</button>
			<button type="submit">리셋</button>
		</form>
	</div>
</body>
</html>