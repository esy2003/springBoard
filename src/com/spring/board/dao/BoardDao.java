package com.spring.board.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.MemberVo;
import com.spring.board.vo.PageVo;

@Repository
public interface BoardDao {
	
	public String selectTest() throws Exception;

	public List<BoardVo> selectBoardList(BoardVo bv) throws Exception;

	public BoardVo selectBoard(BoardVo boardVo) throws Exception;

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
