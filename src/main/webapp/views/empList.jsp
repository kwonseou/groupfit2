<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원리스트</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
<link rel="stylesheet"
	href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<link rel="stylesheet" href="dist/css/adminlte.min.css">
</head>
<style>
/* 	table, th, td{
		border : 1px solid black;
		border-collapse: collapse;
		padding : 5px 10px;
	} */
div[class="btn1"]{
	margin-left: 1108px;
}

form[class="search"]{
	margin-left: 377px;
}

h1.headline{
	margin-left: 640px;
	margin-top: 20px;
}

div[class="table"]{
	margin-left: 376px;
}
</style>
<body>
	<jsp:include page="GroupFit_gnb.jsp"></jsp:include>

	<div class="content-wrapper" style="margin-top: 57.08px">
			<h1 class="headline">직원 리스트</h1>
			
		<fieldset>
			<form action="empList.do" class="search">
				<select name="opt">
					<option value="name">이름</option>
					<option value="b_name">지점</option>
					<option value="position">직급</option>
				</select>
				<input type="text" name="keyword" value="" placeholder="검색어를 입력하세요"/>
				<button>검색</button>
			</form>
		</fieldset>
		
		<div class="btn1">
			<c:if test="${sessionScope.loginEmp.position == '지점장' || sessionScope.loginEmp.position == '대표'}">
			<button class="btn btn-primary" onclick="location.href='empJoin.go'">직원 등록</button>
			<button class="btn btn-primary" onclick="hide()">직원 삭제</button>
			</c:if>
			<c:if test="${sessionScope.loginEmp.position eq '대표'}">
				<button class="btn btn-primary" onclick="location.href='empRepList.do'">지점별</button>
				<button class="btn btn-primary" onclick="location.href='empLeaveList.go'">휴직직원</button>
			</c:if>
		</div>
		<div class="table">
			<table>
				<thead>
					<tr>
						<th>삭제</th>
						<th>사번</th>
						<th>이름</th>
						<th>지점</th>
						<th>직급</th>
						<th>재직상태</th>
						<th>입사일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="emp">
						<tr>
							<td><input type="checkbox" name="chk" value="${emp.emp_no}"/></td>
							<td>${emp.emp_no}</td>
							<td><a href="empDetail.go?detailid=${emp.emp_no}">${emp.name}</a></td>
							<td>${emp.b_name}</td>
							<td>${emp.position}</td>
							<td>${emp.status}</td>
							<td>${emp.join_year}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
<script>
function hide() {
	   var hideList = new Array();
	   $("input[name=chk]:checked").each(function() {
	      hideList.push($(this).val());
	   });
	   $.ajax({
	      type: 'post',
	      url: 'hide.ajax',
	      data: {
	         'hideList' : hideList
	      },
	      dataType: 'text',
	      success: function(data){
	    	  $('form').submit();
	      },
	      error: function(e){
	         console.log(e);
	      }
	   });
	}


</script>
</html>