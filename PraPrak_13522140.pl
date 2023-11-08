/*
Nama	: Yasmin Farisah Salma
NIM	: 13522140
Kelas	: K-03

Pra-Praktikum 01 IF2121 Logika Komputasional
*/



/* BAGIAN I: Fakta, Rule, dan Query */
/* 1. Fakta */
% a. pria(X): X adalah pria
pria(athif).
pria(dillon).
pria(henri).
pria(michael).
pria(hanif).
pria(robert).
pria(bagas).
pria(fio).
pria(daniel).
pria(rupert).


% b. wanita(X): X adalah wanita
wanita(joli).
wanita(elysia).
wanita(margot).
wanita(jena).
wanita(jeni).
wanita(ana).
wanita(emma).


% c. usia(X,Y): X berusia Y
usia(athif,60).
usia(joli,58).
usia(dillon,63).
usia(elysia,500).
usia(henri,48).
usia(margot,43).
usia(michael,28).
usia(hanif,47).
usia(robert,32).
usia(bagas,29).
usia(jena,27).
usia(fio,30).
usia(jeni,28).
usia(ana,23).
usia(daniel,7).
usia(rupert,6).
usia(emma,6).


% d. menikah(X,Y): X menikah dengan Y 
menikah(athif,joli).
menikah(joli,athif).
menikah(dillon,elysia).
menikah(elysia,dillon).
menikah(henri,margot).
menikah(margot,henri).
menikah(fio,jena).
menikah(jena,fio).
menikah(fio,jeni).
menikah(jeni,fio).


% e. anak(X,Y): X adalah anak Y 
anak(margot,athif).
anak(margot,joli).
anak(michael,athif).
anak(michael,joli).
anak(hanif,dillon).
anak(hanif,elysia).
anak(robert,henri).
anak(robert,margot).
anak(bagas,henri).
anak(bagas,margot).
anak(jena,henri).
anak(jena,margot).
anak(jeni,hanif).
anak(ana,hanif).
anak(daniel,fio).
anak(daniel,jena).
anak(rupert,fio).
anak(rupert,jena).
anak(emma,fio).
anak(emma,jeni).



/* 2. Rule */
% saudara(X,Y): X adalah saudara kandung maupun tiri dari Y
saudara(X,Y) :-
	X\==Y,
	(anak(X,Z), anak(Y,Z));
	saudaratiri(X,Y).


% saudaratiri(X,Y): X adalah saudara tiri dari Y
saudaratiri(X,Y) :-
	X\==Y,
	anak(X,Z),
	anak(Y,Z),
	\+ (anak(X,B), anak(Y,B), B\==Z).


% kakak(X,Y): X adalah kakak dari Y (kakak kandung maupun tiri) 
kakak(X,Y) :-
	saudara(X,Y),
	usia(X,A),
	usia(Y,B),
	A>B.


% keponakan(X,Y): X adalah keponakan dari Y
keponakan(X,Y) :-
	anak(X,Z),
	saudara(Z,Y).


% mertua(X,Y): X adalah mertua dari Y 
mertua(X,Y) :-
	menikah(Y,Z),
	anak(Z,X).


% nenek(X,Y): X adalah nenek dari Y 
nenek(X,Y) :-
	wanita(X),
	anak(Y,Z),
	anak(Z,X).


% keturunan(X,Y): X adalah keturunan dari Y (anak, cucu, dan seterusnya) 
keturunan(X,Y) :- anak(X,Y).
keturunan(X,Y) :-
	anak(X,Z),
	anak(Z,Y).
keturunan(X,Y) :-
	anak(X,A),
	keturunan(A,Y).


% lajang(X): X adalah orang yang tidak menikah
lajang(X) :-
	pria(X), \+menikah(X,_), \+menikah(_,X), \+anak(_,X);
	wanita(X), \+menikah(X,_), \+menikah(_,X), \+anak(_,X).


% anakbungsu(X): X adalah anak paling muda 
anakbungsu(X) :-
	anak(X,Y),
	\+kakak(X,_).


% yatimpiatu(X): X adalah orang yang orang tuanya tidak terdefinisi
yatimpiatu(X) :-
	pria(X), \+anak(X,_);
	wanita(X), \+anak(X,_).



/* 3. Query */
% Suami dari Margot
% Kakek buyut dan nenek buyut dari Daniel
% Paman dari orang tua Rupert
% Orang yang memiliki lebih dari satu istri
% Saudara tiri tertua dari Emma
% Orang tua yang memiliki tepat satu anak
% Pria yang memiliki mertua berusia lebih dari 50 tahun
% Orang yatim piatu dengan usia termuda
% Orang diatas 25 tahun yang statusnya menikah dengan orang yang memiliki saudara lebih dari 1 orang
% Seluruh keturunan Athif yang memiliki tepat 2 keponakan



/* BAGIAN II: Rekursivitas */
% 1. Exponent
exponent(A, 0, 1).
exponent(A, B, X) :-
	B > 0,
	B1 is B - 1,
	exponent(A, B1, X1),
	X is A * X1.
	

% 2. Population
population(P, _, 0, _, X):- X is P.
population(P, R, T, C, X):-
    T > 0,
    P1 is P * R,
    T1 is T - 1,
    C1 is C + 1,
    (T mod 2 =:= 1 -> P2 is P1 + C1; T mod 2 =:= 0 -> P2 is P1 - C1),
    population(P2, R, T1, C1, X).


% 3. Perrin 
perrin(0, 3).
perrin(1, 0).
perrin(2, 2).
perrin(N, X) :-
    N > 2,
    N1 is N - 2,
    N2 is N - 3,
    perrin(N1, X1),
    perrin(N2, X2),
    X is X1 + X2.


% 4. HCF 
hcf(0, B, B).
hcf(A, 0, A).
hcf(A, B, X) :-
    A >= B,
    A1 is A - B,
    hcf(A1, B, X).
hcf(A, B, X) :-
    A < B,
    B1 is B - A,
    hcf(A, B1, X).


% 5. Make Pattern
makePattern(N):- baris(0, N).
kali(N, N).
kali(Row, N):-
    Row1 is Row + 1,
    write('\n'),
    elmt(Row, 0, N).

elmt(_, N, N).
elmt(Row, Col, N):-
    Kolom2 is Col + 1,
    Baris1 is (N - 1) - Row,
    Kolom1 is (N - 1) - Col,
    batasan(Row, Baris1, Col, Kolom1, MinEl),
    write(MinEl), write(' '),
    elmt(Row, Kolom2, N).

batasan(P, Q, MinEl):-
    Diff is P - Q,
    (Diff =< 0 -> MinEl is P; MinEl is Q).

batasan(P, Q, R, S, MinEl):-
    batasan(P, Q, Min1),
    batasan(R, S, Min2),
    batasan(Min1, Min2, MinEl).

baris(N, N).
baris(Row, N):-
    Row1 is Row + 1,
    kali(Row, N),
    baris(Row1, N).


/* BAGIAN III: List */
/* 1. List Static */
% min: mencari elemen dengan nilai minimum
min([X], X).
min([X|Xs], X) :-
	min(Xs, Y),
	X =< Y.
min([X|Xs], Y) :-
	min(Xs, Y),
	X > Y.


% max: mencari elemen dengan nilai maksimum
max([X], X).
max([X|Xs], X) :-
	max(Xs, Y),
	X >= Y.
max([X|Xs], Y) :-
	max(Xs, Y),
	X < Y.


% range: mencari selisih antara elemen terbesar dan elemen terkecil
range([X|Xs], Y) :-
	max([X|Xs], Z),
	min([X|Xs], W),
	Y is Z - W.


% count: mencari jumlah elemen pada list
count([], 0).
count([_|Xs], Y) :-
	count(Xs, Y1),
	Y is Y1 + 1.


% sum: mencari jumlah total elemen pada list
sum([], 0).
sum([X|Xs], Y) :-
	sum(Xs, Y1),
	Y is Y1 + X.



/* 2. List Manipulation */
% a. Get Index 
getIndex([X|_], X, 1).
getIndex([_|Xs], Y, Z) :-
    getIndex(Xs, Y, Z1),
    Z is Z1 + 1.


% b. Get Element 
getElement([X|_], 1, X).
getElement([_|Xs], Index, Result) :-
    Index > 1,
    Index1 is Index - 1,
    getElement(Xs, Index1, Result).


% c. Swap 
replace([OldEl|Rest],[NewEl|Rest],Index,OldEl,NewEl) :- Index == 0, !.
replace([First|Rest],[First|NewRest],Index,OldEl,NewEl) :- 
    Index > 0,
    NewIndex is Index - 1, 
    replace(Rest,NewRest,NewIndex,OldEl,NewEl).

swap(OldList, I, J, NewList) :-
    A is I - 1,
    B is J - 1,
    replace(OldList, List, A, X, Y),
    replace(List, NewList, B, Y, X).


% d. Slice 
slice([], _, _, []).
slice([Head | Tail], 1, 1, [Head]).
slice([Head | Tail], A, 1, []).
slice([Head | Tail], 1, B1, [Head | T]) :-
    B is B1 - 1,
    slice(Tail, A, B, T), !. 

slice([Head | Tail], A1, B1, T) :-
    A is A1 - 1,
    B is B1 - 1 - 1,
    slice(Tail, A, B, T), !.

 
% e. Sort List
sortList(List, Sorted) :- sortList(List, Sorted, List).

sortList([], [], _).
sortList([H|T], Sorted, Original) :-
    swap(Original, H, Min),
    sortList(T, RestSorted, Original),
    Sorted = [Min|RestSorted].


/* BONUS */

