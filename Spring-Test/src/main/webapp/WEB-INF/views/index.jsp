<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<jsp:include page="./layout/header.jsp"></jsp:include>
<h1>
	Hello world!  
</h1>

<P>  My Spring Projcet </P>

<script>
const isOk = '<c:out value="${isOk}"/>';
console.log(isOk);
if(isOk == 1){
	alert("등록완료~!!");
}
</script>

<jsp:include page="./layout/footer.jsp"></jsp:include>
    