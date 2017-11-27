package com.spring.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.catalina.Session;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.MemberVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;

import jdk.nashorn.internal.ir.RuntimeNode.Request;

@SessionAttributes("member")
@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,BoardVo bv) throws Exception{
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		
		int page = 1;
		int totalCnt = 0;
		
		if(bv.getPageNo() == 0){
			bv.setPageNo(page);;
		}
		
		boardList = boardService.SelectBoardList(bv);
		totalCnt = boardService.selectBoardCnt();
		
		int totalPage = totalCnt % 10 == 0?totalCnt/10:totalCnt/10+1;
		int startPage = 1;
		int endPage = totalCnt/10+1;
		
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", bv.getPageNo());
		return "board/boardList";
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception{
		return "board/boardWrite";
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/idCheck.do", method = RequestMethod.GET)
	public Map<?, ?> idCheck(Locale locale, Model model, MemberVo mv) throws Exception{
		Map<String, String> map = new HashMap<>();
		String result = boardService.idCheck(mv);
		if (result==null) {
			result = "fail";
		}
		map.put("result", result);
		return map;
	}
	
	@RequestMapping(value = "/board/page/{dir}/{page}.do", method = RequestMethod.GET)
	public String move(Locale locale, Model model,@PathVariable String page,@PathVariable String dir) throws Exception{
		return dir+"/"+page;
	}
	@ResponseBody
	@RequestMapping(value = "/board/option.do", method = RequestMethod.GET)
	public Map<?, ?> option(Locale locale, Model model, CodeVo cv) throws Exception{
		Map<String, Object> map = new HashMap<>();
		List<CodeVo> codeList = boardService.option(cv);
		map.put("option", codeList);
		return map;
	}
	
	@RequestMapping(value = "/board/{boardNum}/{boardType}/boardUpdate.do", method = RequestMethod.GET)
	public String boardUpdate(Locale locale, Model model,@PathVariable String boardType, @PathVariable String boardNum) throws Exception{
		model.addAttribute("board", boardService.selectBoard(boardType, Integer.parseInt(boardNum)));
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		return "board/boardUpdate";
	}
	
	@RequestMapping(value = "/board/boardUpdateAction.do", method = RequestMethod.POST)
	public @ResponseBody Map<?,?> boardUpdateAction(Locale locale, Model model, BoardVo bv) throws Exception{
		Map<String,Object> map = new HashMap<>();
		int a = boardService.update(bv);
		map.put("success", a);
		return map;
	}
	
	@RequestMapping(value = "/board/{boardNum}/{boardType}/boardDeleteAction.do", method = RequestMethod.GET)
	public String boardDelete(Locale locale, Model model, @PathVariable String boardNum, @PathVariable String boardType) throws Exception{
		BoardVo bv = new BoardVo();
		bv.setBoardNum(Integer.parseInt(boardNum));
		bv.setBoardType(boardType);
		boardService.delete(bv);
		return "redirect:/board/boardList.do";
	}
	@ResponseBody
	@RequestMapping(value = "/board/join.do", method = RequestMethod.POST)
	public Map<?, ?> join(Locale locale, Model model, MemberVo mv) throws Exception{
		Map<String, Object> map = new HashMap<>();
		int a = boardService.memberInsert(mv);
		map.put("result", a);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/login.do", method = RequestMethod.POST)
	public Map<?, ?> login(Locale locale, Model model, MemberVo mv, HttpSession session) throws Exception{
		Map<String, Object> map = new HashMap<>();
		MemberVo member = boardService.memberLogin(mv);
		if (member == null) {
			map.put("msg", "fail");
		}else {
			map.put("msg", "success");
			map.put("member", member);
			session.setAttribute("member", member);
			model.addAttribute("member", member);
		}
		return map;
	}
	
	@RequestMapping(value = "/board/logout.do", method = RequestMethod.GET)
	public String logout(Locale locale, Model model, HttpSession session) throws Exception{
		session.invalidate();
		return "redirect:/board/boardList.do";
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/{cate}/{id}/boardWriteAction.do", method = RequestMethod.POST)
	public String boardWriteAction(Locale locale,BoardVo boardVo, @PathVariable String cate, @PathVariable String id) throws Exception{
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		boardVo.setBoardType(cate);
		boardVo.setCreator(id);
		int resultCnt = boardService.boardInsert(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/boardSearch.do", method = RequestMethod.GET)
	public Map<?, ?> boardSearch(Locale locale, Model model,BoardVo bv, PageVo pageVo) throws Exception{
		System.out.println("검색조건은"+bv.getSearch());
		Map<String,Object> map = new HashMap<>();
		List<BoardVo> searchList = new ArrayList<BoardVo>();
		List<String> searchInfo = new ArrayList<>();
		if (bv.getSearch() != null) {
			String[] arr = bv.getSearch().split(",");
			for (int i=0;i<arr.length;i++) {
				searchInfo.add(arr[i]);
			}
		}
		
		int page = 1;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		bv.setSearchInfo(searchInfo);
		bv.setPageNo(page);
		searchList = boardService.search(bv);
		System.out.println("서치 카운트는" + searchList.size());
		map.put("boardList", searchList);
		map.put("totalCnt", searchList.size());
		map.put("pageNo", page);
		return map;
	}
}
