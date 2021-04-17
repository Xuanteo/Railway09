package com.vti.frontend;

import java.time.LocalDate;


import com.vti.entity.Account;
import com.vti.entity.Answer;
import com.vti.entity.CategoryQuestion;
import com.vti.entity.Department;
import com.vti.entity.Exam;
import com.vti.entity.Group;
import com.vti.entity.Position;
import com.vti.entity.Position.PositionName;
import com.vti.entity.Question;
import com.vti.entity.TypeQuestion;
import com.vti.entity.TypeQuestion.TypeName;

public class DemoProgram {
	public static void main(String[] args) {
		System.out.println("Hello VTI!!!");

		// create Department
		Department dep1 = new Department();
		dep1.id = 1;
		dep1.name = "Marketing";

		Department dep2 = new Department();
		dep2.id = 2;
		dep2.name = "Sale";

		Department dep3 = new Department();
		dep3.id = 3;
		dep3.name = "Accounting";

		// create Position
		Position pos1 = new Position();
		pos1.id = 1;
		pos1.name = PositionName.DEV;

		Position pos2 = new Position();
		pos2.id = 2;
		pos2.name = PositionName.SCRUM_MASTER;

		Position pos3 = new Position();
		pos3.id = 3;
		pos3.name = PositionName.TEST;

		// create Account
		Account acc1 = new Account();
		acc1.id = 1;
		acc1.email = "email1@gmail.com";
		acc1.userName = "email1";
		acc1.fullName = "fullname1";
		acc1.dep = dep1;
		acc1.pos = pos1;
		acc1.createDate = LocalDate.of(2020, 04, 16);
			
		Account acc2 = new Account();
		acc2.id = 2;
		acc2.email = "email2@gmail.com";
		acc2.userName = "email2";
		acc2.fullName = "fullname2";
		acc2.dep = dep2;
		acc2.pos = pos2;
		acc2.createDate = LocalDate.of(2020, 04, 15);

		Account acc3 = new Account();
		acc3.id = 3;
		acc3.email = "email2@gmail.com";
		acc3.userName = "email2";
		acc3.fullName = "fullname2";
		acc3.dep = dep3;
		acc3.pos = pos3;
		acc3.createDate = LocalDate.of(2020, 04, 15);

		// create Group
		Group group1 = new Group();
		group1.id = 1;
		group1.name = "Group1";
		group1.creator = acc1;
		group1.createDate = LocalDate.of(2020, 04, 16);
		group1.accounts = new Account[] { acc1, acc2 };

		Group group2 = new Group();
		group2.id = 2;
		group2.name = "Group2";
		group2.creator = acc2;
		group2.createDate = LocalDate.of(2020, 04, 16);
		group2.accounts = new Account[] { acc1, acc3 };

		Group group3 = new Group();
		group3.id = 3;
		group3.name = "Group2";
		group3.creator = acc3;
		group3.createDate = LocalDate.of(2020, 04, 16);
		group3.accounts = new Account[] { acc1, acc3 };

		// create TypeQuestion
		TypeQuestion typeQuestion1 = new TypeQuestion();
		typeQuestion1.id = 1;
		typeQuestion1.name = TypeName.Essay;
		TypeQuestion typeQuestion2 = new TypeQuestion();
		typeQuestion2.id = 2;
		typeQuestion2.name = TypeName.Essay;		
		TypeQuestion typeQuestion3 = new TypeQuestion();
		typeQuestion3.id = 3;
		typeQuestion3.name = TypeName.Multiple_Choice;
		
		// create CategoryQuestion
		CategoryQuestion categoryQuestion1 = new CategoryQuestion();
		categoryQuestion1.id = 1;
		categoryQuestion1.name = "Java";
		CategoryQuestion categoryQuestion2 = new CategoryQuestion();
		categoryQuestion2.id = 2;
		categoryQuestion2.name = "SQL";
		CategoryQuestion categoryQuestion3 = new CategoryQuestion();
		categoryQuestion3.id = 3;
		categoryQuestion3.name = "ASP.NET";
		
		// create Question
		Question question1 = new Question();
		question1.id= 1;
		question1.content ="Question VTI 01";
		question1.categoryQuestion = categoryQuestion1;
		question1.typeQuestion = typeQuestion1;
		question1.creator = acc1;
		question1.createDate = LocalDate.of(2021, 04, 16);
		
		Question question2 = new Question();
		question2.id= 2;
		question2.content ="Question VTI 02";
		question2.categoryQuestion = categoryQuestion2;
		question2.typeQuestion = typeQuestion2;
		question2.creator = acc2;
		question2.createDate = LocalDate.of(2021, 04, 16);
		
		Question question3 = new Question();
		question3.id= 3;
		question3.content ="Question VTI 03";
		question3.categoryQuestion = categoryQuestion3;
		question3.typeQuestion = typeQuestion3;
		question3.creator = acc3;
		question3.createDate = LocalDate.of(2021, 04, 16);
		
		// create Answer
		Answer answer1 = new Answer();
		answer1.id =1;
		answer1.content = "Answers VTI 01";
		answer1.question = question1;
		answer1.isCorrect = Boolean.FALSE;
		Answer answer2 = new Answer();
		answer2.id =2;
		answer2.content = "Answers VTI 02";
		answer2.question = question2;
		answer2.isCorrect = Boolean.TRUE;
		Answer answer3 = new Answer();
		answer3.id =3;
		answer3.content = "Answers VTI 03";
		answer3.question = question3;
		answer3.isCorrect = Boolean.FALSE;
		
		// create Exam
		Exam exam1 = new Exam();
		exam1.id =1;
		exam1.code = "VTIQ001";
		exam1.title = "Đề thi C#";
		exam1.categoryQuestion = categoryQuestion1;
		exam1.duration = 60;
		exam1.creator = acc1;
		exam1.createDate = LocalDate.of(2021, 04, 16);
		exam1.Questions = new Question[] {question2, question3 };
				
		Exam exam2 = new Exam();
		exam2.id =2;
		exam2.code = "VTIQ002";
		exam2.title = "Đề thi Java";
		exam2.categoryQuestion = categoryQuestion2;
		exam2.duration = 90;
		exam2.creator = acc2;
		exam2.createDate = LocalDate.of(2021, 04, 16);
		exam2.Questions = new Question[] {question1, question3 };
		
		Exam exam3 = new Exam();
		exam3.id =3;
		exam3.code = "VTIQ003";
		exam3.title = "Đề thi Postman";
		exam3.categoryQuestion = categoryQuestion3;
		exam3.duration = 90;
		exam3.creator = acc3;
		exam3.createDate = LocalDate.of(2021, 04, 16);
		exam3.Questions = new Question[] {question1, question2 };
		
		// Print
		
		// print department		
		System.out.println("Phòng Số 1:");
		System.out.println("ID:" + dep1.id);
		System.out.println("Name:" + dep1.name);
		
		//print account
		System.out.println("Nhân Viên 1:");
		System.out.println("ID:" + acc1.id);
		System.out.println("tên nhân viên:" + acc1.fullName);
		System.out.println("Email:" + acc1.email);
		System.out.println("Phòng ban:" + acc1.dep.name);
		System.out.println("Chức Vụ:" + acc1.pos.name);
		System.out.println("Ngày vào:" + acc1.createDate);
		
		// print position
		System.out.println("Chức Vụ:");
		System.out.println("ID:" + pos1.id);
		System.out.println("Chức Vụ:" + pos1.name);
		
		// print group
		System.out.println("Nhóm:");
		System.out.println("ID:" + group1.id);
		
		// print TypeQuestion
		System.out.println("Loại câu hỏi");
		System.out.println("ID:" + typeQuestion1.id);
		System.out.println("Name:" + typeQuestion1.name);
		
		// print  CategoryQuestion
		System.out.println("Chủ đề câu hỏi");
		System.out.println("ID:" + categoryQuestion1.id);
		System.out.println("Name" + categoryQuestion1.name);
		
		// print Question
		System.out.println("Câu hỏi");
		System.out.println("ID:" + question1.id);
		System.out.println("Nội Dung:" + question1.content);
		System.out.println("Chủ đề câu hỏi:" + categoryQuestion1.name);
		System.out.println("Loại câu hỏi:" + typeQuestion1.name);
		System.out.println("Người tạo:" + acc1.id);
		System.out.println("Ngày tạo:" + question1.createDate);
		
		// print Answer
		System.out.println("Câu trả lời:");
		System.out.println("ID:" + answer1.id);
		System.out.println("Nội Dung:" + answer1.content);
		System.out.println("ID câu hỏi:" + question1.id);
		System.out.println("Câu trả lời" + answer1.isCorrect);

		// print Exam
		System.out.println("Bài Thi:");
		System.out.println("ID:" + exam1.id);
		System.out.println("Mã đề thi:" + exam1.code);
		System.out.println("Tiêu đề đề thi:" + exam1.title);
		System.out.println("Chủ đề thi" + categoryQuestion1.id);
		System.out.println("Thời gian thi:" + exam1.duration);
		System.out.println("ID người tạo:" + acc1.id);
		System.out.println("Ngày tạo đề thi:" + exam1.createDate);
		
		
		// Question 1:
		if (acc2.dep == null) {
			System.out.println("Nhân viên chưa có phòng ban");

		} else {
			System.out.println("Thì phòng ban của nhân viên này là:" + acc2.dep.name);

		}
		
		// Question 2:
		if (acc2.groups == null) {
			System.out.println("Nhan Vien Nay Chua Group");
		} else if (acc2.groups.length == 1 || acc2.groups.length == 2) {
			System.out.println("Group của nhân viên này là Java Fresher, C# Fresher");
		} else if (acc2.groups.length == 3) {
			System.out.println("Nhân viên này là người quan trọng, tham gia nhiều group");
		}else if (acc2.groups.length >= 4) {
			System.out.println("Nhân viên này là người hóng chuyện, tham gia tất cả các group");
		}
		
		//
		
		
}
	}
