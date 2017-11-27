<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
</head>
<body>

<form class="login-form">
	<table align="center">
		<tr>
			<td align="right">
			<input id="login" type="button" value="로그인">
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
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						PASSWORD
						</td>
						<td width="300">
						<input id="userPw" name="userPw" type="text" size="50" value="" style="width: 200px;"> 
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
	$('#login').click(()=> {
		if ($('#userId').val()=='') {
			alert('아이디를 입력해주세요');
			$('#userId').focus();
			return false;
		}
		if ($('#userPw').val()=='') {
			alert('비밀번호를 입력해주세요');
			$('#userPw').focus();
			return false;
		}
		var login = $('.login-form :input');
		var loginInfo = login.serialize();
		
		$.ajax({
			url : "/board/login.do",
		    dataType: "json",
		    method: "POST",
		    data : loginInfo,
		    success: d => {
		    	if (d.msg == 'success') {
		    		alert('로그인 성공');
		    		sessionStorage.setItem('userId',d.member.userId);
		    		sessionStorage.setItem('name',d.member.name);
		    		location.href = "/board/boardList.do?page=1";
		    	}
		    	else {
		    		alert('아이디를 확인해주세요');
		    		$('#userId').focus();
		    		return false;
		    	}
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