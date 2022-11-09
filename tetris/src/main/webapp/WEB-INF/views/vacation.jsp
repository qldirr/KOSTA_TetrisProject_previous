<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="includes/header.jsp"%>


<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script src="/resources/vender/jquery/jquery-3.6.1.min.js"></script>
<script src="/resources/vender/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/resources/js/index.js"></script>
<!-- Bootstrap CSS -->
<link href="/resources/vender/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="/resources/css/index.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<!-- 휴가관련페이지 -->
<title>TETRIS Groupware</title>
<script>
	$(document).ready(
			function() {

				//출퇴근버튼 활성화
				var currentDate = new Date();
				var currentHours = addZeros(currentDate.getHours(), 2);
				var currentMinute = addZeros(currentDate.getMinutes(), 2);
				var currentSeconds = addZeros(currentDate.getSeconds(), 2);
				var now_date = currentDate.getFullYear() + "-"
						+ (currentDate.getMonth() + 1) + "-"
						+ currentDate.getDate() + " " + currentHours + ":"
						+ currentMinute + ":" + currentSeconds;

				//출근클릭
				$('#startD').click(function() {
					if (confirm('출근하시겠습니까?')) {
						alert('출근하셨습니다');
						//startTime.innerHTML = now_date;
						var e_id = getParam('e_id');
						e_id = e_id.slice(3, -3);
						console.log(e_id);
						$.ajax({
							url : 'insertAction.do',
							type : 'POST',
							contentType : 'application/json',
							data : JSON.stringify({
								e_id : e_id,
							}),
							success : function(result) {
								alert("출근성공");
								
							},
							error : function(result) {
								alert("출근실패 (관리자에게 문의해주세요)");
							}
						}); //$.ajax 
					}
				});
				
				var today = $('#timecheck').val();
				
				var lateCheck = '09:00:00';
				var checkTime = today;//출근시간확인
				
				if(checkTime > lateCheck){
					$('#startTime2').css("color", "red");
				}
				
				//퇴근클릭
				$("#endD").on("click", function() {
					if (confirm('퇴근하시겠습니까?')) {
						alert('퇴근하셨습니다');
						//endTime.innerHTML = now_date;
						var e_id = getParam('e_id');
						e_id = e_id.slice(3, -3);
						console.log(e_id);

						$.ajax({
							url : 'endAction.do',
							type : 'POST',
							contentType : 'application/json',
							data : JSON.stringify({
								e_id : e_id
							}),
							success : function(result) {
								alert("퇴근성공");
							},
							error : function(result) {
								alert("퇴근실패 (관리자에게 문의해주세요)");
							}
						}); //$.ajax 
					}
				});

				$("#outD").on("click", function() {
					if (confirm('외근하시겠습니까?')) {
						alert('안녕히다녀오세요');
					}
				});
			});
	
	function getParameterByName(name) {
		name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex
				.exec(location.search);
		return results == null ? "" : decodeURIComponent(results[1].replace(
				/\+/g, " "));
	}

	function getParam(sname) {
		var params = location.search.substr(location.search.indexOf("?") + 1);
		var sval = "";
		params = params.split("&");
		for (var i = 0; i < params.length; i++) {
			temp = params[i].split("=");
			if ([ temp[0] ] == sname) {
				sval = temp[1];
			}
		}
		return sval;
	}

	function printClock() {
		var clock = document.getElementById("clock"); // 출력할 장소 선택
		var currentDate = new Date(); // 현재시간
		var calendar = currentDate.getFullYear() + "-"
				+ (currentDate.getMonth() + 1) + "-" + currentDate.getDate() // 현재 날짜
		var currentHours = addZeros(currentDate.getHours(), 2);
		var currentMinute = addZeros(currentDate.getMinutes(), 2);
		var currentSeconds = addZeros(currentDate.getSeconds(), 2);
		clock.innerHTML = currentHours + ":" + currentMinute + ":"
				+ currentSeconds; //날짜를 출력해 줌
		//날짜 출력
		var date = document.getElementById("date");
		date.innerHTML = currentDate.getFullYear() + "년 "
				+ (currentDate.getMonth() + 1) + "월 " + currentDate.getDate()
				+ "일";
		setTimeout("printClock()", 1000); // 1초마다 printClock() 함수 호출
	}

	function addZeros(num, digit) { // 자릿수 맞춰주기
		var zero = '';
		num = num.toString();
		if (num.length < digit) {
			for (i = 0; i < digit - num.length; i++) {
				zero += '0';
			}
		}
		return zero + num;
	}
</script>
</head>

<body onload="printClock()">
	<div style="width: 100%; height: 1000;">

		<!-- content -->
		<div class="container-fluid">
			<div class="col-xl-10 col-lg-9 ">

				<div class="row">

					<!-- 좌측바부분 -->
					<div>
						<div>
							<div>
								<h3>근태관리 페이지</h3>
								<h5>어서오세요 ${hrVO.e_name }님</h5>
								<input type="text" id="datePicker">
								<ul>
									<li>근태입력</li>
									<li><a href="">일별 부서 근태기록조회</a></li>
									<li><a href="">월별 개인 근태기록조회</a></li>
									<li><a href="">휴가현황</a></li>
								</ul>
							</div>
						</div>

						<!-- 현재시간/출석시간/퇴근시간 -->
						<div>
							<!--  -->
							<div id="date"></div>
							<div
								style="width: 200px; height: 80px; line-height: 80px; color: #666; font-size: 40px; text-align: center;"
								id="clock"></div>
							<!-- 출근시간 -->
							<dl>
								<dt>출근시간</dt>
								<dd id="startTime">
									<fmt:formatDate value="${hrVO.hr_date }"
										pattern="yyyy-MM-dd HH:mm:ss" />
								</dd>
							</dl>
							<!-- 퇴근시간 -->
							<dl>
								<dt>퇴근시간</dt>
								<dd id="endTime">
									<fmt:formatDate value="${hrVO.hr_leave }"
										pattern="yyyy-MM-dd HH:mm:ss" />
								</dd>
							</dl>
							<!-- 누적근무시간 -->
							<dl>
								<dt>누적근무시간</dt>
								<dd id=""></dd>
							</dl>
							<!-- 출퇴근버튼 -->
							<div>
								<button id="startD">출근하기</button>
								<button id="endD">퇴근하기</button>
								<button id="outD">외근</button>
							</div>
						</div>
					</div>
					<!-- 좌측바부분의 끝 -->

					<!-- 상단부분 -->
					<div></div>

					<!-- 정보출력부분 -->
					<div>

						<!-- 테이블 -->
						<div>
							<h5>${hrVO.d_name } 근태목록</h5>
							<table class="table table-striped"
								style="text-align: center; border: 1px solid #dddddd">
								<thead>
									<tr>
										<th style="background-color: #eeeeee; text-align: center;">일자</th>
										<th style="background-color: #eeeeee; text-align: center;">사원번호</th>
										<th style="background-color: #eeeeee; text-align: center;">이름</th>
										<th style="background-color: #eeeeee; text-align: center;">부서</th>
										<th style="background-color: #eeeeee; text-align: center;">출근시간</th>
										<th style="background-color: #eeeeee; text-align: center;">퇴근시간</th>
										<th style="background-color: #eeeeee; text-align: center;">근무상태</th>
										<th style="background-color: #eeeeee; text-align: center;">비고</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><fmt:formatDate value="${hrVO.hr_date }"
												pattern="yyyy-MM-dd" /></td>
										<td><c:out value="" />${hrVO.e_num }</td>
										<td><c:out value="" />${hrVO.e_name }</td>
										<td><c:out value="" />${hrVO.d_name}</td>
										<!-- 출근시간 -->
										<td id="startTime2"><fmt:formatDate
												value="${hrVO.hr_date }" pattern="HH:mm:ss" />
										</td>
										<!-- 퇴근시간 -->
										<td><fmt:formatDate value="${hrVO.hr_leave }"
												pattern="HH:mm:ss" /></td>
										<td><c:out value="${hrVO.hr_status }" /></td>
										<td><c:out value="${hrVO.hr_note }" /></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<input type="hidden" id="timecheck" value="<fmt:formatDate
												value="${hrVO.hr_date }" pattern="HH:mm:ss" />">
					<!-- 정보출력부분의 끝 -->

				</div>
			</div>
		</div>

	</div>


	<!-- Optional JavaScript; choose one of the two! -->

	<!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
	<script src="/resources/vender/jquery/jquery-3.6.1.min.js"></script>
	<script src="/resources/vender/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/js/index.js"></script>

	<%@ include file="includes/footer.jsp"%>
</body>

</html>
