% Wavelet Wang -- wangwav
% Sean Cramsey -- cramseys


% Here are a bunch of facts describing the Simpson's family tree.
% Don't change them!

female(mona).
female(jackie).
female(marge).
female(patty).
female(selma).
female(lisa).
female(maggie).
female(ling).

male(abe).
male(clancy).
male(herb).
male(homer).
male(bart).

married_(abe,mona).
married_(clancy,jackie).
married_(homer,marge).

married(X,Y) :- married_(X,Y).
married(X,Y) :- married_(Y,X).

parent(abe,herb).
parent(abe,homer).
parent(mona,homer).

parent(clancy,marge).
parent(jackie,marge).
parent(clancy,patty).
parent(jackie,patty).
parent(clancy,selma).
parent(jackie,selma).

parent(homer,bart).
parent(marge,bart).
parent(homer,lisa).
parent(marge,lisa).
parent(homer,maggie).
parent(marge,maggie).

parent(selma,ling).



%%
% Part 1. Family relations
%%

% 1. Define a predicate `child/2` that inverts the parent relationship.

child(X,Y) :- parent(Y,X).

% 2. Define two predicates `isMother/1` and `isFather/1`.

isMother(X) :- parent(X,_),female(X).
isFather(X) :- parent(X,_),male(X).

% 3. Define a predicate `grandparent/2`.

grandparent(X,Y) :- parent(Z,Y),parent(Z,X).

% 4. Define a predicate `sibling/2`. Siblings share at least one parent.

sibling(X,Y) :- parent(Z,X),parent(Z,Y),not(X==Y).

% 5. Define two predicates `brother/2` and `sister/2`.

brother(X,Y) :- sibling(X,Y),male(X), not(X==Y).
sister(X,Y) :- sibling(X,Y),female(X), not(X==Y).

% 6. Define a predicate `siblingInLaw/2`. A sibling-in-law is either married to
%    a sibling or the sibling of a spouse.

siblingInLaw_(X,Y) :- married(Z,Y), sibling(Z,X).
siblingInLaw(X,Y) :- siblingInLaw_(X,Y).
siblingInLaw(X,Y) :- siblingInLaw_(Y,X).


% 7. Define two predicates `aunt/2` and `uncle/2`. Your definitions of these
%    predicates should include aunts and uncles by marriage.

aunt(X,Y) :- sibling(X,Z),parent(Z,Y), female(X).
aunt(X,Y) :- siblingInLaw(X,Z),parent(Z,Y), female(X).
uncle(X,Y) :- sibling(X,Z),parent(Z,Y), male(X).
uncle(X,Y) :- siblingInLaw(X,Z),parent(Z,Y), male(X).

% 8. Define the predicate `cousin/2`.

cousin(X,Y) :- parent(Z,X),parent(A,Y),sibling(Z,A).

% 9. Define the predicate `ancestor/2`.

ancestor(X,Y) :- parent(X,Y).
ancestor(X,Y) :- parent(X,Z), ancestor(Z,Y).

% Extra credit: Define the predicate `related/2`.



%%
% Part 2. Language implementation
%%

% 1. Define the predicate `cmd/3`, which describes the effect of executing a
%    command on the stack.

cmd(C, S1, S2) :- S2 = [C | S1].
cmd(add, [Stack1, Stack2 | S1], S2) :- Sum is (Stack1 + Stack2), S2 = [Sum | S1].
cmd(lte, [Stack1, Stack2 | S1], S2) :- Comp = (Stack1 =< Stack2 -> Res=t;Res=f), call(Comp), S2 = [Res | S1].

% 2. Define the predicate `prog/3`, which describes the effect of executing a
%    program on the stack.
