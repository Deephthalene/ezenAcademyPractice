<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <style>
        .title{
            text-align: center;
            margin-top: 50px;
            margin-bottom: 30px;
        }
        label.error{
            color: red;
            display: none;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp"></jsp:include>
    <form action="/member/signup" id="form" class="container-fluid" method="post">
        <h1 class="title">회원가입</h1>
        <div class="form-group">
            <input type="text" class="form-control" id="id" name="id" placeholder="아이디" > 
            <label id="id-error" class="error" for="id"></label>
          </div>
          <div class="form-group">
            <input type="password" class="form-control" id="pw" name="pw" placeholder="비밀번호" > 
            <label id="pw-error" class="error" for="pw"></label>
          </div>
          <div class="form-group">
            <input type="text" class="form-control" id="age" name="age" placeholder="나이" > 
            <label id="age-error" class="error" for="age"></label>
          </div>
          <div class="form-group">
            <input type="text" class="form-control" id="name" name="name" placeholder="이름" > 
            <label id="name-error" class="error" for="name"></label>
          </div>
          <div class="form-group">
            <input type="text" class="form-control" id="email" name="email" placeholder="e-mail" > 
            <label id="email-error" class="error" for="email"></label>
          </div>
          <div class="form-group">
            <input type="text" class="form-control" id="home" name="home" placeholder="address"  > 
            <label id="home-error" class="error" for="home"></label>
          </div>          
          <button class="btn btn-outline-success col-12">회원가입</button>
    </form>
    <jsp:include page="../layout/footer.jsp"></jsp:include>
    
    <script type="text/javascript">
    const msg = '<c:out value="${msg}"/>';
    if(msg==='0'){
    	console.log(msg);
    	alert("이미 가입된 회원입니다.");
    }
    </script>
</body>
</html>