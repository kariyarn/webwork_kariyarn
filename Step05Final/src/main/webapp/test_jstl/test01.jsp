<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>/test_jstl/test01.jsp</title>
</head>
<body>
	<h1>JSTL반복문</h1>
	<c:forEach var="i" begin="1" end="10">
	<!-- 몇번째 안녕인지 알고 싶다면 EL로 확인할 수 있다. -->
		<p>안녕 <strong>${i }</strong></p>
	</c:forEach>
</body>
</html>