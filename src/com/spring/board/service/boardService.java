package com.spring.board.service;

import java.util.List;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.MemberVo;
import com.spring.board.vo.PageVo;

public interface boardService {

	public String selectTest() throws Exception;

	public List<BoardVo> SelectBoardList(BoardVo bv) throws Exception;

	public BoardVo selectBoard(String boardType, int boardNum) throws Exception;

	public int selectBoardCnt() throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;
	
	public int update(BoardVo bv);
	
	public int delete(BoardVo bv);
	
	public List<BoardVo> search(Object o) throws Exception;
	
	public List<CodeVo> option(CodeVo cv);
	
	public String idCheck(Object o);
	
	public int memberInsert(MemberVo mv);
	
	public MemberVo memberLogin(MemberVo mv);

}
