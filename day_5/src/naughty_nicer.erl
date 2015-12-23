-module(naughty_nicer).
-export([naughty_or_nicer/1, contains_these_two_letters/3, contains_two_pairs_of_letters/1, contains_repeat_with_one_between/1]).

contains_these_two_letters(_,_,[]) -> false;
contains_these_two_letters(_,_,[_|[]]) -> false;
contains_these_two_letters(X,Y,[X,Y|_]) -> true;
contains_these_two_letters(_,_,[_,_|[]]) -> false;
contains_these_two_letters(X,Y,[_,Z|Tail]) -> contains_these_two_letters(X,Y,[Z|Tail]).
    

contains_two_pairs_of_letters([]) -> false;
contains_two_pairs_of_letters([_|[]]) -> false;
contains_two_pairs_of_letters([_,_|[]]) -> false;
contains_two_pairs_of_letters([_,_,_|[]]) -> false;
contains_two_pairs_of_letters([X,Y|Tail]) -> 
    case contains_these_two_letters(X,Y,Tail) of
        true -> true;
        false -> contains_two_pairs_of_letters([Y|Tail])
    end.

contains_repeat_with_one_between([]) -> false;
contains_repeat_with_one_between([_|[]]) -> false;
contains_repeat_with_one_between([_,_|[]]) -> false;
contains_repeat_with_one_between([X,_,X|_]) -> true;
contains_repeat_with_one_between([_,_,_|[]]) -> false;
contains_repeat_with_one_between([_,Y,Z|Tail]) -> contains_repeat_with_one_between([Y,Z|Tail]).

naughty_or_nicer(String) ->
    Repeat_with_one_between = contains_repeat_with_one_between(String),
    Two_pairs_of_letters = contains_two_pairs_of_letters(String),
    case {Repeat_with_one_between, Two_pairs_of_letters} of
        {true, true} -> {nicer};
        _ -> {naughty}
    end.
