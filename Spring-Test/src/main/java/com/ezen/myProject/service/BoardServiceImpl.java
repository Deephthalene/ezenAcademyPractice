package com.ezen.myProject.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.ezen.myProject.domain.BoardDTO;
import com.ezen.myProject.domain.BoardVO;
import com.ezen.myProject.domain.FileVO;
import com.ezen.myProject.domain.PagingVO;
import com.ezen.myProject.domain.UserVO;
import com.ezen.myProject.repository.BoardDAO;
import com.ezen.myProject.repository.FileDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO bdao;
	@Inject
	private FileDAO fdao;

	@Override
	public int register(BoardVO bvo) {
		log.info(">>> board register check2");
		return bdao.insertBoard(bvo);
	}

	@Override
	public List<BoardVO> getList() {
		log.info(">>> board list check2");
		return bdao.selectBoardList();
	}

	@Override
	public BoardVO getDetail(int bno) {
		log.info(">>> board detail check2");
		bdao.readCount(bno);
		return bdao.selectBoardDetail(bno);
	}

	@Override
	public int modify(BoardVO bvo, UserVO user) {
		log.info(">>> board modify check2");
		BoardVO tmpBoard = bdao.selectBoardDetail(bvo.getBno());
		if(user == null || !user.getId().equals(tmpBoard.getWriter())) {
			return 0;
		}
		return bdao.updateBoard(bvo);
	}

	@Override
	public int remove(int bno, UserVO user) {
		log.info(">>> board remove check2");
		BoardVO tmpBoard = bdao.selectBoardDetail(bno);
		if(user == null || !user.getId().equals(tmpBoard.getWriter())) {
			return 0;
		}
		return bdao.deleteBoard(bno);
	}

	@Override
	public List<BoardVO> getList(PagingVO pvo) {
		log.info(">>> board Paging List check2");
		return bdao.selectBoardListPaging(pvo);
	}

	@Override
	public int getTotalCount() {
		log.info(">>> board totalCount check2");
		return bdao.selectTotalCount();
	}

	@Override
	public int getTotalCount(PagingVO pvo) {
		log.info(">>> board search totalCount check2");
		return bdao.searchTotalCount(pvo);
	}

	@Override
	public int register(BoardDTO bdto) {
		int isOk = bdao.insertBoard(bdto.getBvo());  //기존 게시글에 대한 내용을 db에 저장 bdao
		if(bdto.getFList() == null) {
			isOk*=1;
		}else
		if(isOk > 0 && bdto.getFList().size()>0) {
			// 가장 큰 bno 가져오기
			int bno = bdao.selectOneBno(); // 방금 넣은 bvo 객체가 db에 저장된 후
			for(FileVO fvo : bdto.getFList()) {
				fvo.setBno(bno);
				log.info(">>> insert file : "+fvo.toString());
				isOk *= fdao.insertFile(fvo);
			}
		}
		return isOk;
	}

	@Override
	public BoardDTO getDetailFile(int bno) {
		bdao.readCount(bno); //detail 선택시 조회수 올리기
		BoardDTO bdto = new BoardDTO(bdao.selectBoardDetail(bno), fdao.selectFileList(bno));
		return bdto;
	}

	@Override
	public int modify(BoardDTO boardDTO, UserVO user) {
		log.info(">>> board modify check2");
		//글쓴이와, id가 일치하는지 비교
		BoardVO tmpBoard = bdao.selectBoardDetail(boardDTO.getBvo().getBno());
		if(user == null || !user.getId().equals(tmpBoard.getWriter())) {
			return 0;
		}
		//수정
		int isUp = bdao.updateBoard(boardDTO.getBvo()); //bvo 내용 update
		if(boardDTO.getFList() == null) {
			isUp*=1;
		}else
		if(isUp > 0 && boardDTO.getFList().size()>0) {
			int bno = boardDTO.getBvo().getBno();
			for(FileVO fvo : boardDTO.getFList()) {
				fvo.setBno(bno);
				isUp*=fdao.insertFile(fvo);  //추가한 파일을 추가 
				// 삭제 기능은 별도로 만들 예정
			}
		}
		
		return isUp;
	}

	@Override
	public int removeFile(String uuid) {
		int isUp = fdao.deleteFile(uuid);
		return isUp;
	}
	
}
