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
	  <h3>게시글 상세</h3>
		
		    <div class="form-group">
		      <label for="bno">번호</label>
		      <input type="text" class="form-control" id="bno" name="bno" readonly value="${board.bno}">
		    </div>
		    <div class="form-group">
		      <label for="title">제목</label>
		      <input type="text" class="form-control" id="title" name="title" readonly value="${board.title}">
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
		      <label for="content">조회수</label>
		      <textarea class="form-control" id="content" name="read_count" readonly>${board.read_count}</textarea>
		    </div>
		    <div class="form-group">
		      <label for="content">내용</label>
		      <textarea class="form-control" id="content" name="content" readonly>${board.content}</textarea>
		    </div>

			
		    <!-- file 표현라인 -->
		 	<div class="form-group">
	      		<ul class="list-group list-group-flush">
	      			<!-- c:if 파일이 없으면 첨부 File이 없습니다. 출력 -->
	      			
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
	      				</li>
	      			</c:forEach>
	      		</ul>
	    	</div>
		<c:if test="${board == null}">
		<h2> 존재하지 않은 게시물입니다. </h2>
		</c:if>
		<a href="/board/list">
		<button type="button" class="btn btn-outline-info">목록</button>
		</a>
		<a href="/board/register">
		<button type="button" class="btn btn-outline-info">글쓰기</button>
		</a>
		<!-- 로그인 id와 작성자 id가 같지 않으면 수정, 삭제버튼 안보이게... -->
		<c:if test="${ses != null && ses.id == board.writer}">
			<a href="/board/modify?bno=${board.bno}">
			<button type="button" class="btn btn-outline-info">수정</button>
			</a>
			<a href="/board/remove?bno=${board.bno}">
			<button type="button" class="btn btn-outline-info">삭제</button>
			</a>
		</c:if>
	</div>
	<!-- comment line -->
	<div class="container">
		<div class="input-group my-3">
			<span class="input-group-text" id="cmtWriter">${board.writer }</span>
			<input type="text" class="form-control" id="cmtText" placeholder="Test Add Comment ">
			<button class="btn btn-success" id="cmtPostBtn" type="button">Post</button>
		</div>
		<ul class="list-group list-group-flush" id="cmtListArea">
		  <li class="list-group-item d-flex justify-content-between align-items-start">
		    <div class="ms-2 me-auto">
		      <div class="fw-bold">Writer</div>
		      Content for Comment
		    </div>
		    <span class="badge bg-dark rounded-pill">modAt</span>
		  </li>
		</ul>
	</div>
	<script type="text/javascript">
	const bnoVal = '<c:out value="${board.bno }" />';
	console.log(bnoVal);
	</script>
	<script type="text/javascript" src="/resources/js/boardComment.js"></script>
	<script type="text/javascript">
	getCommentList(bnoVal);
	</script>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>