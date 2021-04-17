package com.vti.entity;

import java.time.LocalDate;

public class Question {
	public int id;
	public String content;
	public CategoryQuestion categoryQuestion;
	public TypeQuestion typeQuestion;
	public Account creator;
	public LocalDate createDate;
	public Exam[] exams;

}
