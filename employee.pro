/* File: employee.pro
 * Solution to the prolog worksheet 3
 * Exercise 1 
 * August 12th, 2003 
 * Gabriel Tellez, 
 * StudentID: 0314123 @ AUT
*/

by('Gabriel Tellez').

/*
1. 	Type the "car" example into a Prolog program; try some queries 
to make sure you understand what is happening.  Also, try adding a "colour" 
field to the structure. */

has(joe, car(ford,red,3,5000)).
has(joe, car(opel,blue,2,6000)).
has(mick, car(toyota,white,5,1000)).
has(mick, car(ford,pink,2,2000)).

/*2.	Data on each employee of a company consists of the following: employee's 
name, department in which s/he works, her/his position in the department 
(secretary, head, accountant etc.), number of years of service, basic salary, 
and the name of their immediate boss.  The company director is his/her own boss! 

Write a Prolog database containing the employees' information (make up 5 or 6 entries) - 
this should be a list of facts containing "employee-details" structures.  Now, based on 
this, make up some rules to answer the following: 
(the name of the rule, along with its arity is given in each case)*/

employee(phil,all,director,10,10000,phil).

employee(ryan,marketing,head,5,6000,phil).
employee(julia,marketing,secretary,8,4000,ryan).
employee(charles,marketing,accountant,4,3000,ryan).
employee(joe,marketing,advisor,4,3000,ryan).
employee(michael,marketing,advisor,4,3000,joe).
employee(nick,marketing,designer,4,3000,joe).

employee(gabriel,research,head,4,7000,yon).

employee(mary,research,head,4,7000,phil).
employee(cindy,research,secretary,8,4000,mary).                                  
employee(john,research,developer,2,5000,mary).
employee(luke,research,researcher,2,5000,mary).
employee(julian,research,researcher,2,5000,luke).
employee(peter,research,researcher,2,5000,luke). 

/*department/2: Find the department in which some particular person works*/ 

department(Person, Dep):-
	employee(Person,Dep,_,_,_,_).

/*manager/2: Given a person's name, find out who's the manager of the department 
in which they work*/ 

manager(Person, Manage):-
	employee(Person,_,_,_,_,Manage).

/*valid_employee/1: Your list of facts should ideally form a tree; that is, 
if we get a person's boss, and then their boss' boss and so on, we should 
end up with the company director. Write a predicate which, when given a 
person's name, will check if this is so.*/


valid_employee(Person):-
	valid_employee(Person,X).
        
valid_employee(Person,X):- 
	manager(Person,X),
	X == Person,!.        

valid_employee(Person,Manager):-
        manager(Person,Manager),
        valid_employee(Manager,Y). 

/*basic_salary/2: Get a person's basic salary*/

basic_salary(Person,Salary):-
	employee(Person,_,_,_,Salary,_). 

/*real_salary/2: Get a person's real salary, by adding the information that: 
All employees with over 5 years service get a bonus of $5,000 
No employee (even after bonuses) can earn more than his/her boss - use the "min" 
predicate here, and make sure to have a special case for the director... 
*/

real_salary(Person,Real_salary):-
	employee(Person,_,_,Years,Salary,_),
	Years > 5,
	Real_salary is Salary + 5000.