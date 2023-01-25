<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<jsp:include page="../layout/header.jsp"></jsp:include>
<body>
	<div class="container">
	  <h2>Hoverable Table</h2>
	  <p>The .table-hover class adds a hover effect (grey background color) on table rows:</p>            
	 <!-- search -->
	  <div class="col-sm-12 col-md-6">
	<form action="/board/list" method="get">
		<div class="input-group mb-3">
		<!-- 값을 별도 저장 -->
		<c:set value="${pgn.pgvo.type }" var="typed"/>
  			<select class="form-select" name="type">
    			<option ${typed == null ? 'selected':'' }>Choose...</option>
    			<option value="t" ${typed eq 't' ? 'selected':'' }>Title</option>
    			<option value="c" ${typed eq 'c' ? 'selected':'' }>Content</option>
    			<option value="w" ${typed eq 'w' ? 'selected':'' }>Writer</option>
  			</select>
  			
  			<input class="form-control" type="text" name="keyword" placeholder="Search" value="${pgn.pgvo.keyword }">
  			<input type="hidden" name="pageNo" value="1">
  			<input type="hidden" name="qty" value="${pgn.pgvo.qty }">
  			<button type="submit" class="btn btn-success position-relative">
  			Search
  			<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
    		${pgn.totalCount }
    		<span class="visually-hidden">unread messages</span></span>
  			</button>
		</div>
	</form>
	</div>
	<!-- table line -->
	  <table class="table table-hover" >
	    <thead>
	      <tr>
	        <th width="10%">번호</th>
	        <th width="40%">제목</th>
	        <th width="20%">작성자</th>
	        <th width="20%">작성일</th>
	        <th width="10%">조회수</th>
	       </tr>
	    </thead>
	    <tbody>
	      <c:forEach items="${list}" var="board">
		      <tr>
		        <td>${board.bno}</td>
		        <td><a href="/board/detail?bno=${board.bno }">${board.title}</a></td>
		        <td>${board.writer}</td>
		        <td>${board.registerDate}</td>
		        <td>${board.read_count}</td>
		      </tr>
	      </c:forEach>
	    </tbody>
	  </table>
	  
	 <!-- paging line -->
	  <ul class="pagination justify-content-center">
		<c:if test="${pgn.prev }">
	    <li class="page-item">
	      <a href="/board/list?pageNo=${pgn.startPage - 1 }&qty=${pgn.pgvo.qty}&type=${pgn.pgvo.type}&keyword="${pgn.pgvo.keyword }" class="page-link">Prev</a>
	    </li>
	    </c:if>
	    <c:forEach begin="${pgn.startPage }" end="${pgn.endPage }" var="i">
	    <li class="page-item ${pgn.pgvo.pageNo == i ? 'active':''}" aria-current="page">
	      <a class="page-link" href="/board/list?pageNo=${i }&qty=${pgn.pgvo.qty}&type=${pgn.pgvo.type}&keyword="${pgn.pgvo.keyword }">${i }</a>
	    </li>
	    </c:forEach>
	    <c:if test="${pgn.next }">
	    <li class="page-item">
	      <a class="page-link" href="/board/list?pageNo=${pgn.endPage + 1 }&qty=${pgn.pgvo.qty}&type=${pgn.pgvo.type}&keyword="${pgn.pgvo.keyword }">Next</a>
	    </li>
	    </c:if>
	  </ul>
	  <a href="/board/register">
		<button type="button" class="btn btn-outline-info">글쓰기</button>
		</a>
	</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>