<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
</head>
<body>
<jsp:include page="../layout/header.jsp"></jsp:include>
<h1>Login Page</h1>
 
	
	<form action="/member/login" method="post">
	    <div class="form-group">
	      <label for="usr">ID:</label>
	      <input type="text" class="form-control" id="usr" name="id">
	    </div>
	    <div class="form-group">
	      <label for="pwd">PassWord:</label>
	      <input type="password" class="form-control" id="pwd" name="pw">
	    </div>
    	<button type="submit" class="btn btn-primary col-12">login</button>
  	</form>
  
 <jsp:include page="../layout/footer.jsp"></jsp:include>
 
 <script type="text/javascript">
 const msg = '<c:out value="${msg}"/>';
 console.log(msg);
 if(msg==="0"){
	 alert("로그인 실패!!!");
 }
 </script>
</body>
</html>