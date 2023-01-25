<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="/">Logo</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/member/signup">회원가입</a>
        </li>
        <c:if test="${ses.id == null }">
	        <li class="nav-item">
	          <a class="nav-link" href="/member/login">로그인</a>
	        </li>
        </c:if>
        <c:if test="${ses.id != null }">
        	<li class="nav-item">
	          <a class="nav-link" href="/member/logout">로그아웃</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="/board/register">REG</a>
	        </li>
        </c:if>
	        <li class="nav-item">
	          <a class="nav-link" href="/board/list">게시판</a>
	        </li>
        <c:if test="${ses.id != null }">
	         <li class="nav-item">
	          <a class="nav-link" href="#">${ses.id } welcome!</a>
	        </li>
        </c:if>
      </ul>
    </div>
  </div>
</nav>

