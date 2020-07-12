<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>          
<!DOCTYPE html>
<!-- 회원가입 step2 by 귀정 -->
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - Step2</title>
<link rel="stylesheet" type="text/css" href="resources/css/common/common.css">
<link rel="stylesheet" type="text/css" href="resources/css/users/join.css">
<script type="text/javascript" src="resources/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="resources/js/users/join2.js"></script>
</head>
<body>
	<div class="joinWrap">
	<p id="logop">LOVE ME IN</p>
	<div id="step">
		<div id="line"></div>
		<div class="radiusdiv">
			<div class="radius"></div>
			<p class="rcon">STEP.1</p>
			<p class="rconK">SMS인증</p>
		</div>
		<div class="radiusdiv">
			<div id="chkRadius" class="radius"></div>
			<p class="rcon">STEP.2</p>
			<p class="rconK">계정설정</p>
		</div>
		<div class="radiusdiv">
			<div class="radius"></div>
			<p class="rcon">STEP.3</p>
			<p class="rconK">기본정보</p>
		</div>
		<div class="radiusdiv">
			<div class="radius"></div>
			<p class="rcon">STEP.4</p>
			<p class="rconK">추가정보</p>
		</div>
		<div class="radiusdiv">
			<div class="radius"></div>
			<p class="rcon">STEP.5</p>
			<p class="rconK">이상형설정</p>
		</div>
	</div>
		<form method="post" id="step2Form" action="gojoinStep2ok.do" onsubmit="return subBtnFunc();">
			<input type="text" placeholder="이메일을 입력하세요" id="u_email" name="u_email">
			<button id="chkemail" type="button" onclick="mailChkScript();">중복확인</button>
			<img src='resources/images/users/x.png' id="xEamilicon" class='joinicon'>
			<div id="checkMailMsgDiv"></div>
			<input type="text" type="button" placeholder="닉네임을 입력하세요" id="u_name" name="u_name">
			<button id="chkname" type="button" onclick="nameChkScript();">중복확인</button>
			<img src='resources/images/users/x.png' id="xNameicon" class='joinicon'>
			<div id="checkNameMsgDiv"></div>
			<input type="password" id="u_pw" name="u_pw" placeholder="비밀번호(특수문자,영문,숫자 포함 8~16자)">
			<input type="password" id="chkpw" placeholder="비밀번호중복확인">
			<img src='resources/images/users/x.png' id="xPwdicon" class='joinicon'>
			<p class="pw_con"></p>
			<input type="text" id="u_intro" name="u_intro" placeholder="간단한 인사말을 입력하세요." autocomplete="off">
			<img src='resources/images/users/o.png' id="xIntroicon" class='ok'>
			<p id="introLengthChk">인사말은 최대 30자까지 가능합니다.(0/30)</p>
			<input type="hidden" name="u_phone" value="${requestScope.u_phone}">
			<input type="submit" value="다음단계" id="subBtn">
		</form>	
	</div>
	<c:import url="../common/footer.jsp"/>
</body>
</html>