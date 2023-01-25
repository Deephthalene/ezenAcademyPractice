<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container">
	  <h3>게시글 수정</h3>
		<c:if test="${board != null}">
			<form action="/board/modify" method="post" enctype="multipart/form-data">
			    <div class="form-group">
			      <label for="num">번호</label>
			      <input type="text" class="form-control" id="bno" name="bno" readonly value="${board.bno}">
			    </div>
			    <div class="form-group">
			      <label for="title">제목</label>
			      <input type="text" class="form-control" id="title" name="title" value="${board.title}">
			    </div>
			    <div class="form-group">
			      <label for="writer">작성자</label>
			      <input type="text" class="form-control" id="writer" name="writer" readonly value="${board.writer}">
			    </div>
			    <div class="form-group">
			      <label for="registerDate">작성일</label>
			      <input type="text" class="form-control" id="registerDate" name="registerDate" readonly value="${board.registerDate}">
			    </div>
			    <div class="form-group">
			      <label for="content">내용</label>
			      <textarea class="form-control" id="content" name="content">${board.content}</textarea>
			    </div>
			    <div class="col-12 d-grid">
  				
			    
			    <!-- file 표현라인 -->
		 	<div class="form-group">
	      		<ul class="list-group list-group-flush">
	      			<c:forEach items="${fList }" var="fvo">
	      				<!-- 파일이 여러개 일 때 반복적으로 li 추가 -->
	      				<li class="list-group-item d-flex justify-content-between align-items-start">
	      				<c:choose>
      						<c:when test="${fvo.file_type > 0 }">
      							<div>
      								<!--D:~fileUpload/2022/12/28/dog.jpg -->
      								<img src="/upload/${fn:replace(fvo.save_dir,'\\','/')}/${fvo.uuid}_th_${fvo.file_name}">
      							</div>
      						</c:when>
      						<c:otherwise>
      							<div>
      								<!-- 파일모양 아이콘을 넣어서 일반 파일임을 표현하면 됨. -->
      							</div>
      						</c:otherwise>
      					</c:choose>
      						<!-- 파일이름, 등록일, 사이즈 -->
		      				<div class="ms-2 me-auto">
		      				<div class="fw-bold">${fvo.file_name }</div>
		      				${fvo.reg_at }
		    				</div>
		    				<span class="badge bg-secondary rounded-pill">${fvo.file_size } Byte</span>
		    				<button type="button" data-uuid=${fvo.uuid } class="btn btn-sm btn-danger py-0 file-x">X</button>
	      				</li>
	      			</c:forEach>
	      		</ul>
	    	</div>
	    	<!-- 파일 수정에 따른 등록라인 -->
	    	<input class="form-control" type="file" style="display: none;"
  				 id="files" name="files" multiple>
  				<button type="button" id="trigger" class="btn btn-outline-primary btn-block d-block">Files Upload</button>
			</div>		
			<div class="col-12" id="fileZone">
				
			</div>
			    <button type="submit" class="btn btn-outline-info" id="regBtn">수정</button>
		    </form>
		</c:if>
		<c:if test="${board == null}">
		<h2> 존재하지 않은 게시물입니다. </h2>
		</c:if>
		<a href="/board/list">
		<button type="button" class="btn btn-outline-info">목록</button>
		</a>
		<a href="/board/register">
		<button type="button" class="btn btn-outline-info">글쓰기</button>
		</a>
	</div>
	<script src="/resources/js/boardRegister.js"></script>
	<script src="/resources/js/board.modify.js"></script>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>