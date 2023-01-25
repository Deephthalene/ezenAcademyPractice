
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
	  <h3>게시글 등록</h3>
	  	<form action="/board/register" method="post" enctype="multipart/form-data">
			<div class="form-group">
		      <label for="title">제목</label>
		      <input type="text" class="form-control" id="title" name="title" >
		    </div>
		   
		    <div class="form-group">
		      <label for="writer">작성자</label>
		      <input type="text" class="form-control" id="writer" name="writer" readonly value="${ses.id }">
		    </div>
		    <div class="form-group">
		      <label for="content">내용</label>
		      <textarea class="form-control" id="content" name="content" ></textarea>
		    </div>
		    <div class="col-12 d-grid">
  				<input class="form-control" type="file" style="display: none;"
  				 id="files" name="files" multiple>
  				<button type="button" id="trigger" class="btn btn-outline-primary btn-block d-block">Files Upload</button>
			</div>		
			<div class="col-12" id="fileZone">
				
			</div>
		    
		   	<button type="submit" id="regBtn" class="btn btn-outline-info">등록</button>
	    </form>
		<a href="/board/list">
		<button type="button" class="btn btn-outline-info">목록</button>
		</a>
	</div>

<script src="/resources/js/boardRegister.js"></script>
<jsp:include page="../layout/footer.jsp"></jsp:include>
	
</body>
</html>