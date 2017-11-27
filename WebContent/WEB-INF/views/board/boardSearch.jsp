<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script type="text/javascript">
	
	
</script>
<body>
<table align="center">
				<tr>
					<td id="countSearch" align="right">
						검색 개수 : ${count}
					</td>
				</tr>
				<tr>
					<td>
						<table id="boardTable" border = "1">
							<tr>
								<td width="80" align="center">
									Type
								</td>
								<td width="40" align="center">
									No
								</td>
								<td width="300" align="center">
									Title
								</td>
							</tr>
								<tr>
									<td align="center">
										dd
									</td>
									<td>
										ss
									</td>
									<td>
										<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">aa</a>
									</td>
								</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align="right">
						<a href ="/board/boardWrite.do">글쓰기</a>
					</td>
				</tr>
			</table>	
			<div id="checkbox" style="text-align: center;">
				<input id="all" type="checkbox" name="chk_info" value="all" onclick="checkAll()">전체
				<input id="public" type="checkbox" name="chk_info" value="a01">일반
				<input id="qna" type="checkbox" name="chk_info" value="a02">Q&A
				<input id="private" type="checkbox" name="chk_info" value="a03">익명
				<input id="free" type="checkbox" name="chk_info" value="a04">자유
			</div>
	<script>
	function checkAll() {
		if ($('#all').is(':checked')) {
			$('#checkbox>input').attr('checked',true);
		}
		else {
			$('#checkbox>input').attr('checked',false);
		}
	}
	var search = '';
		$('#search_btn').click(()=> {
			for (var i=1;i<6;i++) {
				if ($('#checkbox>input:nth-child('+i+')').prop('checked')) {
					alert(i+'번째 체크돼있다' + ', 밸류는 : ' +$('#checkbox>input:nth-child('+i+')').val());
					if (search === '' && $('#checkbox>input:nth-child('+i+')').val() !== 'all') {
						search = $('#checkbox>input:nth-child('+i+')').val();
					}else if (search !== '' && $('#checkbox>input:nth-child('+i+')').val() !== 'all') {
						search = search + ',' + $('#checkbox>input:nth-child('+i+')').val();
					}
				}
			}
			
			$.ajax({
				url : "/board/"+search+"/boardSearch.do",
			    dataType: "json",
			    type: "POST",
			    data : ({
			    	'search' : search
			    }),
			    success: function(data, textStatus, jqXHR)
			    {
					alert("검색완료");
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