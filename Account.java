package com.vti.entity;

import java.time.LocalDate;

public class Account {
	public int id;
	public String email;
	public String userName;
	public String fullName;
	public Department dep;
	public Position pos;
	public LocalDate createDate;
	public Group[] groups;
	
}
