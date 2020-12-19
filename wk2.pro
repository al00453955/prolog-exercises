/* File: wk2.pro
 * Solution to the prolog worksheet 2
 * August 6th, 2003 
 * Gabriel Tellez, 
 * StudentID: 0314123 @ AUT
 */

by('Gabriel Tellez').

/*===============================================
		   Exercise 2.1
===============================================*/

warn_me :-
	warning(X),
        print('Warning'),
        nl,
        print(X),
        nl.

warning('Let them pass') :-
	test('they are a family'),
        test('they are returning from holidays').

warning('Check their baggage!') :-
	test('they carrying more than 2 bags').

warning('Check their baggage!') :-
	'they could have illegal products'.

warning('Arrest them!') :-
	'they could be fugitives'.

'they could be fugitives' :-
	test('they look suspicious'), 
        test('they are trying to hide or run').                                

'they could have illegal products' :-
	test('they seem to avoid police'), 
        test('they are trying to leave their baggage').                                

test(Clause) :- Clause.

test(Clause) :- 
	print('Is true that '), 
	print(Clause),
        nl,
        read('y'),
        asserta(Clause).        
        
/*===============================================
		   Exercise 2.2
===============================================*/

/************************************************
	          cutlast(L1,L2)
************************************************/

/*cutlast(L1,L2) which is true if L2 is L1 with the last element removed*/
                                
cutlast([X],[]).

cutlast([H1|T1],[H1|T2]) :-
        cutlast(T1,T2).

/************************************************
	          trim(L1,N,L2)
************************************************/

/*trim(L1,N,L2)	which is true if L2 contains just the first N elements of L1*/                 

trim(L1,N,L2):-
	trim(L1,N,0,L2).        

trim(L1,N,C,[]):-
	C == N.
                
trim([H1|T1], N, C, [H1|T2]) :-
	C1 is C + 1,
        trim(T1,N,C1,T2).   	
                         
/************************************************
	          evens(L1,L2)
************************************************/

/*evens(L1,L2) which is true if L2 contains just those elements in L1 which 
are even in the same order */

evens([],[]).

evens([H1|T1], [H1|T2]) :-
        Y is H1 mod 2,
	Y == 0,
        evens(T1,T2).

evens([H1|T1], L) :-
        U is H1 mod 2,
	U == 1,
        evens(T1,L).     
        
/************************************************
	          beg_small(L1,L2)
************************************************/

/*Write a predicate beg_small(L1,L2) which is true if L2 has the smallest 
number in L1 as its head, and all the other numbers in the same order*/

beg_small(L1, L2) :- 
	least(L1,G), 
        delete1(G,L1,Answer), 
        append([G],Answer,L2),!.

/************************************************ 
    Auxiliar procedures of beg_small(L1,L2)
************************************************/

least([S],S).
least([H|T],S) :- least(T,S1), smaller(H,S1,S).

smaller(A,B,A) :- A=<B.
smaller(A,B,B) :- B<A.

delete1(X,[X|Tail], Tail).
delete1(X,[Head|Tail],[Head|New_Tail]) :- delete1(X,Tail,New_Tail).  

append([], L2, L2). 
append([H1|T1], L2, [H1|L3]) :- append(T1,L2,L3).