% Phonetics - Properties of English phones

:- ['properties.pl'].

% Numbers 1-19
french([u, n], [number, single, z]).
french([d, u], [number, single, y]).
french([t, r, a], [number, single, y]).

french([k, a, t, r, A], [number, single, y]) :-
    phone(A), not(cns(A)), not(hih(A)), low(A), not(bck(A)).

french([s, a, n, k], [number, single, y]).
french([s, i, s], [number, single, y]).
french([s, e, p, t], [number, single, y]).
french([u, i, t], [number, single, y]).

french([n, A, f], [number, single, y]) :-
    phone(A), not(cns(A)), mid(A), ctr(A), not(str(A)).

french([d, i, s], [number, tens, y]).
french([o, n, z], [number, tens, y]).
french([d, u, z], [number, tens, y]).
french([t, r, a, z], [number, tens, y]).

french([k, a, t, A, r, z], [number, tens, y]) :-
    phone(A), not(cns(A)), hih(A), bck(A), not(tns(A)).

french([k, i, a, n, z], [number, tens, y]).

french([s, A, z], [number, tens, y]) :-
    phone(A), not(cns(A)), hih(A), not(bck(A)), not(tns(A)).

french([d, i, s, -, s, e, p, t], [number, tens, y]).
french([d, i, s, -, u, i, t], [number, tens, y]).

french([d, i, s, -, n, A, f], [number, tens, y]) :-
    phone(A), not(cns(A)), mid(A), ctr(A), not(str(A)).

% Numbers 20, 30, 40, 50, 60
french([v, A], [number, tens, x]) :-
    phone(A), not(cns(A)), hih(A), bck(A), not(tns(A)).

french([t, r, a, n, t], [number, tens, x]).
french([k, e, r, a, n, t], [number, tens, x]).
french([s, a, n, k, u, a, n, t], [number, tens, x]).

french([s, A, s, a, n, t], [number, tens, x]) :-
    phone(A), not(cns(A)), hih(A), bck(A), not(tns(A)).

% Numbers 80 and 81
french([k, a, t, r, A, -, v, B], [number, tens, a]) :-
    phone(A), not(cns(A)), not(hih(A)), low(A), not(bck(A)),
    phone(B), not(cns(B)), hih(B), bck(B), not(tns(B)).

french([k, a, t, r, A, -, v, B, -, u, n], [number, tens, a]) :-
    phone(A), not(cns(A)), not(hih(A)), low(A), not(bck(A)),
    phone(B), not(cns(B)), hih(B), bck(B), not(tns(B)).

% Numbers 100 and 1000
french([s, o, n], [number, hundred, b]).
french([m, i, l], [number, thousand, c]).

% This predicate generates two-digit numbers that end in 1 (e.g. 21) up to 61
french(Number, [composite]) :-
    french(A, [number, tens, x]),
    french(B, [number, single, z]),
    append(A, [-, e, t, -], C),
    append(C, B, Number).

% This predicate generates two-digit numbers between 22-69, aside from the 
% numbers generated by the previous predicate
french(Number, [composite]) :-
    french(A, [number, tens, x]),
    french(B, [number, single, y]),
    append(A, [-], C),
    append(C, B, Number).

% This predicate generates two-digit numbers between 70-79
french(Number, [composite]) :-
    french(A, [number, tens, x]),
    french(B, [number, tens, y]),
    A = [H|T],
    T = [X|_],
    cns(H), not(voi(H)), cnt(H), alv(H),
    phone(X), not(cns(X)), hih(X), bck(X), not(tns(X)),
    append(A, [-], C),
    append(C, B, Number).

% This predicate generates two-digit numbers between 82-99
french(Number, [composite]) :-
    french(A, [number, single, y]),
    A = [Ha|_],
    cns(Ha), not(voi(Ha)), vel(Ha),
    french(B, [number, tens, x]),
    B = [Hb|_],
    cns(Hb), voi(Hb), lab(Hb), ant(Hb), cnt(Hb),
    french(C, [number, _, y]),
    append(A, [-], D),
    append(D, B, E),
    append(E, [-], F),
    append(F, C, Number).

% This predicate generates three-digit numbers 100-199
french(Number, [hundreds]) :-
    french(A, [number, hundred, b]),
    (french(B, [number, single, _]); french(B, [number, tens, _]); 
    french(B, [composite])),
    append(A, [-], C),
    append(C, B, Number).

% This predicate generates three-digit numbers 200, 300, 400
% 500, 600, 700, 800, and 900
french(Number, [triple]) :-
    french(A, [number, single, y]),
    french(B, [number, hundred, b]),
    append(A, [-], C),
    append(C, B, Number).

% This predicate generates three-digit numbers 201-999
french(Number, [thousands]) :-
    french(A, [number, single, y]),
    french(B, [hundreds]),
    append(A, [-], C),
    append(C, B, Number).

% This predicate generates all numbers between 1-1000 using facts 
% and prior predicates
french(Number) :-
    french(Number, _).
