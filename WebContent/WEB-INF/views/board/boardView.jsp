<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>
<body>
<div style="text-align: center;">
	<select id="fixbox">
		<option value="${boardType }"></option>
	</select>
</div>
<table align="center">
	<tr>
		<td>
			<table border ="1">
				<tr>
					<td width="120" align="center">
					Title
					</td>
					<td id="board_title" width="400">
					${board.boardTitle}
					</td>
				</tr>
				<tr>
					<td height="300" align="center">
					Comment
					</td>
					<td id="board_comment">
					${board.boardComment}
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
			<a id="delete" href="/board/${board.boardNum }/${board.boardType }/boardDeleteAction.do">delete</a>
		</td>
		<td align="right">
			<a href="/board/${board.boardNum }/${board.boardType }/boardUpdate.do">update</a>
		</td>
		<td align="right">
			<a href="/board/boardList.do">List</a>
		</td>
	</tr>
</table>
<script>
	if ($('#fixbox>option').val() === 'a01') {
		$('#fixbox>option').text('일반');
	}
	if ($('#fixbox>option').val() === 'a02') {
		$('#fixbox>option').text('Q&A');
	}
	if ($('#fixbox>option').val() === 'a03') {
		$('#fixbox>option').text('익명');
	}
	if ($('#fixbox>option').val() === 'a04') {
		$('#fixbox>option').text('자유');
	}
</script>
</body>
</html>