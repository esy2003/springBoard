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
	
	$j(document).ready(function(){
	});
	
</script>
<body>
<div id="memberIn" style="text-align: center;">
	<a href="/board/page/member/member_join.do">회원가입   </a>
	
	<a href="/board/page/member/member_login.do">   로그인</a>
</div>
<div id="memberOut" style="text-align: center;">
	<span id="memberName"></span>
	<a href="/board/logout.do">   로그아웃</a>
</div>
<table  align="center">
	<tr>
		<td id="count" align="right">
			total : ${totalCnt}
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
				<c:forEach items="${boardList}" var="list">
					<tr>
						<td align="center">
							${list.boardTypeName}
						</td>
						<td>
							${list.boardNum}
						</td>
						<td>
							<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
						</td>
					</tr>	
				</c:forEach>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href="/board/boardWrite.do">글쓰기</a>
		</td>
	</tr>
</table>	
<div id="paging" style="text-align: center;">
<nav aria-label="Page navigation example">
  <ul class="pagination">
    <c:forEach varStatus="i" begin="${startPage }" end="${endPage }" step="1">
      	<c:choose>
			<c:when test="${i.index eq startPage}">
				<li class="page-item"><a class="page-link" href="#" onclick="goPage(${i.index})">${i.index}</a></li>
			</c:when>
			<c:otherwise>
				<li class="page-item"><a class="page-link" onclick="goPage(${i.index})">${i.index}</a></li>
			</c:otherwise>
		</c:choose>
      </c:forEach>
  </ul>
</nav>
</div>

<div id="checkbox" style="text-align: center;">
	<input id="all" type="checkbox" name="chk_info" value="all" onclick="checkAll()">전체
</div>

	<script>
	var boardUI = {
		search : () => { return '<div id="memberIn" style="text-align: center;">'
			+	'<a href="/board/page/member/member_join.do">회원가입   </a>'
			+	'<a href="/board/page/member/member_login.do">   로그인</a>'
			+'</div>'
			+'<div id="memberOut" style="text-align: center;">'
			+	'<span id="memberName"></span>'
			+	'<a href="/board/logout.do">   로그아웃</a>'
			+'</div>'
			+'<table align="center">'
			+'	<tr>'
			+'		<td id="countSearch" align="right">'
			+'			'
			+'		</td>'
			+'	</tr>'
			+'	<tr>'
			+'		<td>'
			+'			<table id="searchTable" border = "1">'
			+'			</table>'
			+'		</td>'
			+'	</tr>'
			+'	<tr>'
			+'		<td align="right">'
			+'			<a href ="/board/boardWrite.do">글쓰기</a>'
			+'		</td>'
			+'	</tr>'
			+'</table>	'
			+'<div id="paging" style="text-align: center;">'
			+'<nav aria-label="Page navigation example">'
			+  '<ul class="pagination">'
			+    '<li class="page-item"><a class="page-link" href="#">1</a></li>'
			+  '</ul>'
			+'</nav>'
			+'</div>'
			+'<div id="checkbox" style="text-align: center;">'
			+'<input id="all" type="checkbox" name="chk_info" value="all" onclick="checkAll()">전체'
			+'</div>'
			
		}
	};
	var compUI={
			span : x=>{
					return $('<span/>',
					{	
						text:x
					}); 
				},
			tr : ()=> {
					return $('<tr/>');
				},
			td : x=> {
					return $('<td/>',
					{
						text:x
					});
				},
			th : x => {
					return $('<th/>',
					{
						text:x
					});
				},
			input : () => {
					return $('<input/>');
				}
			};
	
	function checkAll() {
		if ($('#all').is(':checked')) {
			$('#checkbox>input').attr('checked',true);
		}
		else {
			$('#checkbox>input').attr('checked',false);
		}
	}
	
 	if (sessionStorage.getItem('userId')===null || sessionStorage.getItem('userId') === '') {
		$('#memberIn').show();
		$('#memberOut').hide();
	}
	else {
		$('#memberIn').hide();
		$('#memberOut').show();
		$('#memberName').text('${member.name}'+'님 반갑습니다.');
	}
	var codeId = '';
	var codeLength = 0;
	$.ajax({
		url : "/board/option.do",
	    dataType: "json",
	    method: "GET",
	    success: d => {
			for (var i=0;i<d.option.length;i++) {
				$('#checkbox').append(compUI.input()
							  .attr('id',d.option[i].codeId)
							  .attr('type','checkbox'));	
			}
	    
	    	codeLength = d.option.length * 2 + 2;
	    	for (var i=2;i<d.option.length+2;i++) {
	    		$('#checkbox>input:nth-child('+i+')').val(d.option[i-2].codeId);
	    	}
	    	for (var i=1;i<d.option.length+1;i++) {
	    		$('#checkbox>input:nth-child('+i*2+')').after(compUI.span(d.option[i-1].codeName));
	    	}

	    	$('#checkbox').append(compUI.input()
					  .attr('id','search_btn')
					  .attr('type','button')
					  .attr('value','검색')
					  .attr('onclick','boardSearch()'));
	    },
	    error: function (jqXHR, textStatus, errorThrown)
	    {
	    	alert("실패");
	    }
	})
	
	var search = '';
		function boardSearch() {
			
			var codeId = '';
			
			for (var i=1;i<codeLength;i++) {
				if ($('#checkbox>input:nth-child('+i+')').prop('checked')) {
					//alert(i+'번째 체크돼있다' + ', 밸류는 : ' +$('#checkbox>input:nth-child('+i+')').val());
					if (search === '' && $('#checkbox>input:nth-child('+i+')').val() !== 'all') {
						search = $('#checkbox>input:nth-child('+i+')').val();
					}else if (search !== '' && $('#checkbox>input:nth-child('+i+')').val() !== 'all') {
						search = search + ',' + $('#checkbox>input:nth-child('+i+')').val();
					}
				}
			}
			if (search == '') {
				for (var i=0;i<codeLength;i++) {
					search += $('#checkbox>input:nth-child('+i+')').val() + ',';
				}
			}
			$.ajax({
				url : "/board/boardSearch.do",
			    dataType: "JSON",
			    method: "GET",
			    data : ({
			    	'search':search
			    }),
			    success: d =>
			    {
					alert("검색완료");
					$('body>table').remove();
					$('body>div').remove();
					$('body').append(boardUI.search());
					$('#countSearch').text("검색된 개수 : "+d.totalCnt);
					$('#searchTable').append(compUI.tr());
					$('#searchTable>tr').append(compUI.th('Type').css({'width':'80','align':'center'}));
					$('#searchTable>tr').append(compUI.th('Number').css({'width':'40','align':'center'}));
					$('#searchTable>tr').append(compUI.th('Title').css({'width':'300','align':'center'}));
					for (var i=0;i<d.totalCnt;i++) {
						$('#searchTable').append(compUI.tr());
					}
					for (var i=2;i<d.totalCnt+2.;i++) {
						$('#searchTable>tr:nth-child('+i+')').append(compUI.td(d.boardList[i-2].boardTypeName));
						$('#searchTable>tr:nth-child('+i+')').append(compUI.td(d.boardList[i-2].boardNum));
						$('#searchTable>tr:nth-child('+i+')').append(compUI.td(d.boardList[i-2].boardTitle).css({'cursor':'pointer'}).attr('onclick','goDetail('+'\''+d.boardList[i-2].boardType+'\''+','+d.boardList[i-2].boardNum+')'));
					}
				 	if (sessionStorage.getItem('userId')===null || sessionStorage.getItem('userId') === '') {
						$('#memberIn').show();
						$('#memberOut').hide();
					}
					else {
						$('#memberIn').hide();
						$('#memberOut').show();
						$('#memberName').text('${member.name}'+'님 반갑습니다.');
					}
					
					var codeId = '';
					var codeLength = 0;
					$.ajax({
						url : "/board/option.do",
					    dataType: "json",
					    method: "GET",
					    success: d => {
							for (var i=0;i<d.option.length;i++) {
								$('#checkbox').append(compUI.input()
											  .attr('id',d.option[i].codeId)
											  .attr('type','checkbox'));	
							}
					    
					    	codeLength = d.option.length * 2 + 2;
					    	for (var i=2;i<d.option.length+2;i++) {
					    		$('#checkbox>input:nth-child('+i+')').val(d.option[i-2].codeId);
					    	}
					    	for (var i=1;i<d.option.length+1;i++) {
					    		$('#checkbox>input:nth-child('+i*2+')').after(compUI.span(d.option[i-1].codeName));
					    	}

					    	$('#checkbox').append(compUI.input()
									  .attr('id','search_btn')
									  .attr('type','button')
									  .attr('value','검색')
									  .attr('onclick','boardSearch()'));	
					    },
					    error: function (jqXHR, textStatus, errorThrown)
					    {
					    	alert("실패");
					    }
					})
			    },
			    error:function(request,status,error){
			    	//+"message:"+request.responseText+"\n"
			         alert("code:"+request.status+"\n"+"error:"+error);
			    }
			})
			search = '';
		}
		$('#memberOut>a').click(()=> {
			sessionStorage.setItem('userId','');
			sessionStorage.setItem('name','');
		});
		
		function goPage(x) {
			location.href = "/board/boardList.do?pageNo="+x;
		}
		function goDetail (x,y) {
			location.href="/board/"+x+"/"+y+"/boardView.do?pageNo=1";
		}
		
	</script>
</body>
</html>