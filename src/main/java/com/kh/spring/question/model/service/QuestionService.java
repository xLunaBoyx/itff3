package com.kh.spring.question.model.service;

import java.util.List;
import java.util.Map;

import com.kh.spring.question.model.vo.Question;
import com.kh.spring.sharing.model.vo.Attachment;

public interface QuestionService {

	int insertQuestion(Question question);

	List<Question> selectQuestionList(Map<String, Object> param);

	int countTotalContent(String id);

	Question selectQuestionCollection(int no);

	Attachment selectOneAttachment(int no);

	int updateQuestion(Question question);

	int deleteQuestionAttachment(int attachNo1);

}