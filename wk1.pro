/* File: wk1.pro
 * Solution to the prolog worksheet 1
 * July 31st, 2003 
 * Gabriel Tellez, 
 * StudentID: 0314123 @ AUT
 */

/*Family Facts*/

man(allan).
man(clive).
man(edward).
man(graham).
man(ian).
man(keith).

woman(brenda).
woman(denise).
woman(freda).
woman(hilda).
woman(janet).

father(allan, denise).
father(allan, edward).
father(clive, graham).
father(edward, janet).
father(ian, keith).

mother(brenda, denise).
mother(brenda, edward).
mother(denise, graham).
mother(freda, janet).
mother(janet, keith).

/*===============================================
		   Exercise 1.1
===============================================*/

/* Parent rule */

parent(Parent,Child) :-
            mother(Parent,Child).

parent(Parent,Child) :-
            father(Parent,Child).

/* Son rule */

son(Parent,Son) :-
            parent(Parent,Son),
            man(Son).

/* Sister rule */

sister(Sister1,Sister2) :-
            mother(Mother, Sister1),
            mother(Mother, Sister2),
            woman(Sister1), 
            woman(Sister2),
            Sister1 \= Sister2.

/* Brother rule – Used for Cousin rule */

brother(Brother1,Brother2) :-
            mother(Mother, Brother1),
            mother(Mother, Brother2), 
            Brother1 \= Brother2.

/* Cousin rule */

cousin(Cousin1,Cousin2) :-
            parent(Parent1,Cousin1),
            parent(Parent2,Cousin2),
            brother(Parent1,Parent2),
            Cousin1 \= Cousin2.

/* Descendant rule */

descendant(Person, Descendant) :-
            parent(Person, Descendant).

descendant(Person, Descendant) :-
            parent(Person, Child),
            descendant(Child, Descendant).

/*===============================================
		   Exercise 1.2
===============================================*/

/*First of all, we have this program:

max(X,Y,X) :- X >= Y , !.
max(X,Y,Y).

If I use max(2,3,2).
PDProlog returns "No"

If I use max(2,3,3).
PDProlog returns "Yes"

But...

If I use max(3,2,2).
PDProlog returns "Yes"

The solution is this one, in which both clauses are explicit:*/

max(X,Y,X) :- X >= Y.
max(X,Y,Y) :- X < Y.

/*Obviously it can be argued that this version is inefficient, because 
the second rule contains a test that it’s unnecessary. The second rule 
will ever be applied only after the first rule has failed, but prevents 
the case presented above with the program containing the cut.

Now, if I use max(2,3,2).
PDProlog returns "No"

If I use max(2,3,3).
PDProlog returns "Yes"

And

If I use max(3,2,2).
PDProlog returns "No"
 
Because now it checks the second rule.*/