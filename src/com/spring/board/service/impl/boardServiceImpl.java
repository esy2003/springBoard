package com.spring.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.BoardDao;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.MemberVo;
import com.spring.board.vo.PageVo;

@Service
public class boardServiceImpl implements boardService{
	
	@Autowired
	BoardDao boardDao;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectTest();
	}
	
	@Override
	public List<BoardVo> SelectBoardList(BoardVo bv) throws Exception {
		// TODO Auto-generated method stub
		
		return boardDao.selectBoardList(bv);
	}
	
	@Override
	public int selectBoardCnt() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectBoardCnt();
	}
	
	@Override
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception {
		// TODO Auto-generated method stub
		BoardVo boardVo = new BoardVo();
		
		boardVo.setBoardType(boardType);
		boardVo.setBoardNum(boardNum);
		
		return boardDao.selectBoard(boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardInsert(boardVo);
	}

	@Override
	public int update(BoardVo bv) {
		return boardDao.update(bv);
	}

	@Override
	public int delete(BoardVo bv) {
		return boardDao.delete(bv);
	}

	@Override
	public List<BoardVo> search(Object o) throws Exception {
		return boardDao.search(o);
	}

	@Override
	public List<CodeVo> option(CodeVo cv) {
		return boardDao.option(cv);
	}

	@Override
	public String idCheck(Object o) {
		return boardDao.idCheck(o);
	}

	@Override
	public int memberInsert(MemberVo mv) {
		return boardDao.memberInsert(mv);
	}

	@Override
	public MemberVo memberLogin(MemberVo mv) {
		return boardDao.memberLogin(mv);
	}
	
}
