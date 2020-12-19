/* File: jug.pro
 * Solution to the prolog worksheet 3
 * Exercise 2
 * Based on the skeleton provided by Phil Robbins 
 * August 12th, 2003 
 * Gabriel Tellez, 
 * StudentID: 0314123 @ AUT
 */

/* The jug problem.  
   Phil Robbins 21-2-2003
   X holds 4 litres, Y holds 3 litres.  
   This solution does a depth first search.

   COMPLETE
*/

/* ---------------------------------------------------------------------------------- */

by('Gabriel Tellez').

/* solve(/4)
   Accepts the start and required values for the jug contents. 
   Tries to find a solution.
   (This is complete)
*/
solve(XStart, YStart, XFinish, YFinish) :-
    build_solution(state(XStart, YStart), state(XFinish, YFinish), [state(XStart, YStart)],Solution),
    print_solution(Solution).

/* Where there is no solution it says so.'*/
solve(_, _, _, _) :- print('No solution.').

/* ---------------------------------------------------------------------------------- */

/* print_solution(/1)
   Displays the solution one step at a time. 
   You need to write this. 
   The solution will be in a list such as [state(0,0), state(4,0)].  From this you 
   need to display 0,0 -> 4,0 etc.
   Do not allow backtracking after the last item has been printed.
*/

print_solution([]).

print_solution([state(X,Y)|T]):-
	print(' -> ',X,',',Y),
        print_solution(T).  

/* ---------------------------------------------------------------------------------- */

/* build_solution(/4)
   Attempts to build a solution. Takes current state and goal state, interim solution and
   final solution.
   (1 clause to add)
*/
/* What is the terminating condition?*/

	/******************************************************
	THE TERMINATING CONDITION IS WHEN THE CURRENT STATE
        IS THE GOAL STATE AND THE GOAL STATE IS IN THE SOLUTION
	*******************************************************/

build_solution(state(X, Y), state(X, Y), SoFar, SoFar) :-
	not_in_solution(state(X, Y),SoFar).

/* Try an operation to find a new state.  If the new state is not in the interim solution,
   add it and try to find a solution from the new state.
*/
build_solution(state(XStart, YStart), state(XGoal, YGoal), SoFar, Solution) :-
    operation(state(XStart, YStart), state(X2, Y2)),
    not(not_in_solution(state(X2, Y2), SoFar)),
    append(SoFar, [state(X2, Y2)], Rest), 
    build_solution(state(X2, Y2), state(XGoal, YGoal), Rest, Solution).

/* ---------------------------------------------------------------------------------- */

/* not_in_solution(/2)
   Looks for a given state in the solution list.
   Argument 1 is a state, argument 2 a list of tried states.
   This succeeds if the given state is NOT in the list.
   You write the code.*/
   
	/******************************************************
	I JUST ADDED A "not" BEFORE THE "not_in_solution" 
   	ABOVE IN THE "build_solution" METHOD TO GET A STATE THAT
   	IS NOT ON THE LIST 
   	********************************************************/

not_in_solution(X,[X|_]).

not_in_solution(X,[_|T]) :-
	not_in_solution(X,T).

/* ---------------------------------------------------------------------------------- */

/* 0perations(/2)
   Takes an input state and produces a new state by applying one of the legal operations to it.
   Incomplete.
*/
 
 	/******************************************************
	JUST NOTICE THAT I ADDED A "validate" METHOD BECAUSE 
        SOMETIMES THE PROHRAM JUST CONTINUE AND CONTINUE TRYING
        WITH BIGGER NUMBERS THAN 4 AND 3, SO WITH THIS VALIDATION
        I STOP THE EXECUTION OF THOSE OPERATIONS IF THE INSTANTIATION
        IS BIGGER THAN 4 FOR X OR 3 FOR Y
   	********************************************************/
        
/* 	Fill jug X from the tap.  
	OK if jug X is not already full. */
 
operation(state(X, Y), state(4, Y)) :-
    X < 4,
    validate(X,Y).

/* 	Fill jug Y from the tap.  
	OK if jug Y is not already full. */ 

operation(state(X, Y), state(X, 3)) :-
    Y < 3,
    validate(X,Y).

/* 	Empty jug X to sink.  
	OK if jug X is not already empty. */
    
operation(state(X, Y), state(0, Y)) :-
    X > 0,
    validate(X,Y).

/* 	Empty jug Y to sink.  
	OK if jug Y is not already empty. */    

operation(state(X, Y), state(X, 0)) :-
    Y > 0,
    validate(X,Y).

/* 	Fill X from Y. 
	Fill jug Y from the tap. 
        OK if jug Y is not already full. 
        OK if jug X has enough water to complete this.*/
        
operation(state(X, Y), state(Xend, 3)) :-
    Y < 3,
    G is 3 - Y,
    X >= G,
    Xend is X - G,
    validate(X,Y),
    validate(Xend,Y).    
    
/* 	Fill Y from X. 
	Fill jug X from the tap. 
        OK if jug X is not already full. 
        OK if jug Y has enough water to complete this.*/
    
operation(state(X, Y), state(4, Yend)) :-
    X < 4,
    G is 4 - X,
    Y >= G,
    Yend is Y - G,
    validate(X,Y),
    validate(X,Yend).

/* 	Empty X to Y. 
	Empty jug X to sink. 
        OK if jug X is not already empty. 
        OK if jug Y has enough space to accept the water from X.*/

operation(state(X, Y), state(0, Yend)) :-
    X > 0,
    Yend is Y + X,
    validate(X,Y),
    validate(X,Yend).

/* 	Empty Y to X. 
	Empty jug Y to sink. 
        OK if jug Y is not already empty. 
        OK if jug X has enough space to accept the water from Y.*/    
    
operation(state(X, Y), state(Xend, 0)) :-
    Y > 0,
    Xend is Y + X,
    validate(X,Y),
    validate(Xend,Y).
  
/*Auxiliar Procedures*/  

validate(X,Y):-
	X < 5,
        Y < 4.      
          
append(L1,L2,L3) :- 
	L1=[], 
	L3=L2.

append(L1,L2,L3) :- 	
	L1=[H1|T1], 
	append(T1,L2,T3), 
	L3=[H1|T3].  