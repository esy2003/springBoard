<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>
<body>
<form class="boardWrite">
	<table align="center">
		<tr>
			<td align="right">
			<input id="update_submit" type="button" value="수정">
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1"> 
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input id="update_title" name="boardTitle" type="text" size="50" value="${board.boardTitle }">
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea id="update_comment" name="boardComment"  rows="20" cols="55">${board.boardComment}</textarea>
						</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
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
<script type="text/javascript">

 	$('#update_submit').click(()=> {
 		var comment = $('#update_comment').val();
		var title = $('#update_title').val();
		var x = '${boardType}';
		var y = ${boardNum};
		alert(x + y);
		if (title==="") {
			alert('제목이 비어있습니다.');
			return false;
		}
		if (comment === "") {
			alert('내용이 비어있습니다.');
			return false;
		}
		$.ajax({
			url : "/board/boardUpdateAction.do",
		    dataType: "json",
		    type: "POST",
		    data : ({
		    	'boardType':x,
		    	'boardNum':y,
		    	'boardTitle':title,
		    	'boardComment':comment
		    }),
		    success: function(data, textStatus, jqXHR)
		    {
				alert("수정완료");
				
				alert("메세지:"+data.success);
				
				location.href = "/board/boardList.do?pageNo=1";
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("실패");
		    }
		})
	});

</script>	
</body>
</html>