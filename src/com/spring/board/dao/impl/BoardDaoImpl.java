package com.spring.board.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.BoardDao;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.MemberVo;
import com.spring.board.vo.PageVo;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		
		String a = sqlSession.selectOne("board.boardList");
		
		return a;
	}
	/**
	 * 
	 * */
	@Override
	public List<BoardVo> selectBoardList(BoardVo bv) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.boardList",bv);
	}
	
	@Override
	public int selectBoardCnt() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardTotal");
	}
	
	@Override
	public BoardVo selectBoard(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardView", boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		return sqlSession.insert("board.boardInsert", boardVo);
	}
	@Override
	public int update(BoardVo bv) {
		
		return sqlSession.update("board.update", bv);
	}
	@Override
	public int delete(BoardVo bv) {
		
		return sqlSession.delete("board.delete", bv);
	}
	@Override
	public List<BoardVo> search(Object o) throws Exception {
		return sqlSession.selectList("board.boardList", o);
	}
	@Override
	public List<CodeVo> option(CodeVo cv) {
		return sqlSession.selectList("board.option", cv);
	}
	@Override
	public String idCheck(Object o) {
		return sqlSession.selectOne("board.idCheck", o);
	}
	@Override
	public int memberInsert(MemberVo mv) {
		return sqlSession.insert("board.memberInsert", mv);
		
	}
	@Override
	public MemberVo memberLogin(MemberVo mv) {
		return sqlSession.selectOne("board.memberLogin", mv);
	}

}
