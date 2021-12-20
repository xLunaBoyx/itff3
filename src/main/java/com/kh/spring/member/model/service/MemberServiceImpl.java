package com.kh.spring.member.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.member.model.dao.MemberDao;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.sharing.model.vo.Board;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	
	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}


	@Override
	public Member selectOneMember(String id) {
		return memberDao.selectOneMember(id);
	}


	@Override
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}


	@Override
	public List<Member> selectMemberList(String gender) {
		return memberDao.selectMemberList(gender);
	}


	@Override
	public List<Member> selectMemberList() {
		return memberDao.selectMemberList();
	}


	@Override
	public List<Member> selectMemberList(Map<String, Object> param) {
		return memberDao.selectMemberList(param);
	}


	@Override
	public Member selectOneEmail(String email) {
		return memberDao.selectOneEmail(email);
	}


	@Override
	public Member selectOneNickname(String nickname) {
		return memberDao.selectOneNickname(nickname);
	}


	@Override
	public List<Board> selectBoardListByMemberId(int offset, int limit, String id) {
		return memberDao.selectBoardListByMemberId(offset, limit, id);
	}


	@Override
	public int selectBoardTotalCount() {
		return memberDao.selectBoardTotalCount();
	}
	
	
	
}
