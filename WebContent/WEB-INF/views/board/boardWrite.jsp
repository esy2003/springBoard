<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		
		$j("#submit").on("click",function(e){
			e.preventDefault();
			if ($('.selectbox option:selected').val() == '') {
				alert('카테고리를 먼저 선택해주세요');
				return false;
			}
			if ($('#boardTitle').val() == '' || $('#boardComment').val() == '') {
				alert('제목이나 글 내용을 입력해주세요');
				return false;
			}
			var $frm = $j('.boardWrite :input');
			var param = $frm.serialize();
			$j.ajax({
			    url : "/board/"+$('.selectbox option:selected').val()+"/"+sessionStorage.getItem('userId')+"/boardWriteAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
					alert("작성완료");
					
					alert("메세지:"+data.success);
					
					location.href = "/board/boardList.do?pageNo=1";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});
		});
	});
	

</script>
<body>
<form class="boardWrite">
<div style="text-align: center;">
	<select class="selectbox">

	</select>
</div>
	<table align="center">
		<tr>
			<td align="right">
			<input id="submit" type="button" value="작성">
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
						<input id="boardTitle" name="boardTitle" type="text" size="50" value="${board.boardTitle}"> 
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea id="boardComment" name="boardComment"  rows="20" cols="55">${board.boardComment}</textarea>
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
<script>
var compUI={
		option : ()=>{
				return $('<option/>'); 
			}
		};
	$.ajax({
		url : "/board/option.do",
	    dataType: "json",
	    type: "GET",
	    success: d =>
	    {
			alert('성공');
			for (var i=0;i<d.option.length;i++) {
				$('.selectbox').append(compUI.option());				
			}
			for(var i=0;i<d.option.length;i++) {
				$('.selectbox>option:nth-child('+(i+1)+')').val(d.option[i].codeId);
				$('.selectbox>option:nth-child('+(i+1)+')').text(d.option[i].codeName);
				
			}
	    },
	    error: function (jqXHR, textStatus, errorThrown)
	    {
	    	alert("실패");
	    }
	})
</script>
</body>
</html>