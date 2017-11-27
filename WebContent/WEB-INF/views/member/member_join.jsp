<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 가입</title>
</head>
<body>

<form class="join-form">
	<table align="center">
		<tr>
			<td align="right">
			<input id="join" type="button" value="가입">
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1"> 
					<tr>
						<td width="120" align="center">
						ID
						</td>
						<td width="300">
						<input id="userId" name="userId" type="text" size="50" value="" style="width: 200px;">
						<input id="idcheck" type="button" value="중복확인"> 
						<input type="hidden" id="idHidden" value="0"/>
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						PASSWORD
						</td>
						<td width="300">
						<input id="userPw" name="userPw" type="password" size="50" value="" style="width: 80px;"> 
						<span id="passCheckMsg" style="color: red;"></span>
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						PASSWORDCHECK
						</td>
						<td width="300">
						<input id="userPwCheck" name="userPwCheck" type="password" size="50" value="" style="width: 80px;">
						<span id="passCheckMsg2" style="color: red;"></span>
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						NAME
						</td>
						<td width="300">
						<input id="name" name="name" type="text" size="50" value="" style="width: 200px;"> 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						PHONE
						</td>
						<td width="300">
						<input type="text" id="phone1" name="phone1" class="phone" style="width: 40px;" maxlength="3" onkeypress="onlyNumber();" /> -
						<input type="text" id="phone2" name="phone2" class="phone" style="width: 40px;" maxlength="4" onkeypress="onlyNumber();" /> -
						<input type="text" id="phone3" name="phone3" class="phone" style="width: 40px;" maxlength="4" onkeypress="onlyNumber();" />
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						ZIPCODE
						</td>
						<td width="300">
						<input id="addr1" name="addr1" type="text" size="50" value="" style="width: 200px;"> 
						</td>
					</tr>
					<tr>
					<tr>
						<td width="120" align="center">
						ADDRESS
						</td>
						<td width="300">
						<input id="addr2" name="addr2" type="text" size="50" value="" style="width: 200px;"> 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						COMPANY
						</td>
						<td width="300">
						<input id="company" name="company" type="text" size="50" value="" style="width: 200px;"> 
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
	</table>
</form>	
<script>

function onlyNumber() {
    if ((event.keyCode < 48) || (event.keyCode > 57))
        event.returnValue = false;
}

function CheckForm() {
    if ($('.phone').val()=="") {
        alert("휴대폰 번호를 입력하세요");
        return false;
    }
    if ($("txtMobile2").val().length != 4) {
        alert("4자리로 입력하세요");
        return false;
    }
    if ($("txtMobile3").val().length != 4) {
        alert("4자리로 입력하세요");
        return false;
    }
}

$('#idcheck').click(() => {
	var userId = $('#userId').val();
		$.ajax({
			url : "/board/idCheck.do",
		    dataType: "json",
		    method: "GET",
		    data : ({'userId':userId}),
		    success: d => {
		    	if (d.result === 'fail') {
		    		alert('사용 가능한 아이디 입니다');
		    		$('#idHidden').val('1');
		    	}
		    	else {
		    		alert('중복된 아이디 입니다');
		    		return false;
		    	}
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("실패");
		    }
		})
});

$('#userPw').keyup(()=>{
    var regex=/^(?=.*[a-zA-Z])(?=.*[!@#$%^&*+=-])(?=.*[0-9]).{8,12}/;
    var pass1=$('#userPw').val();
    
    if(regex.test(pass1)){
       $('#passCheckMsg').text('사용가능한 비밀번호입니다');
    }else{
       $('#passCheckMsg').text('영문,특문,숫자를 모두 포함시켜주세요'); 
    };
 });
 
 $('#userPwCheck').keyup(()=>{
    var pass1=$('#userPw').val();
    var pass2=$('#userPwCheck').val();
    if(pass2==pass1){
       $('#passCheckMsg2').text('비밀번호가 일치합니다');
    }else{
       $('#passCheckMsg2').text('비밀번호가 다릅니다');
    }
 });

$('#join').click(()=> {
	if ($('#userId').val()=='') {
		alert('아이디를 입력해주세요');
		$('#userId').focus();
		return false;
	}
	if ($('#userPw').val()=='') {
		alert('비밀번호를 입력해주세요');
		$('#userpw').focus();
		return false;
	}
	if ($('#idHidden').val()!=='1') {
		alert('아이디 중복확인을 해주세요');
		return false;
	}
	if ($('#name').val()=='') {
		alert('이름을 입력해주세요');
		$('#name').focus();
		return false;
	}
	if ($('#userPw').val()!==$('#userPwCheck').val()) {
		alert('비밀번호가 다릅니다');
		return false;
	}
	var joinForm = $('.join-form :input');
	var joinInfo = joinForm.serialize();
	alert(joinInfo);
	$.ajax({
		url : "/board/join.do",
	    dataType: "json",
	    method: "POST",
	    data : joinInfo,
	    success: d => {
	    	alert('가입 완료');
	    	location.href = "/board/boardList.do?pageNo=1";
	    },
	    error: function (jqXHR, textStatus, errorThrown)
	    {
	    	alert("실패");
	    }
	})
})

</script>
</body>
</html>