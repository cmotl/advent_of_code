-module(naughty_nice).
-export([contains_duplicate_letters/1, contains_three_vowels/1, contains_naughty_sequences/1]).

contains_duplicate_letters([]) -> false;
contains_duplicate_letters([_|[]]) -> false;
contains_duplicate_letters([X,X|_]) -> true;
contains_duplicate_letters([_,Y|Tail]) -> contains_duplicate_letters([Y|Tail]).

contains_three_vowels(String) -> contains_three_vowels(String, 0).

contains_three_vowels(_, 3) -> true;
contains_three_vowels([], _) -> false;
contains_three_vowels([X|Tail], Vowel_count) ->
    case lists:member(X, "aeiou") of
        true -> contains_three_vowels(Tail, Vowel_count+1); 
        false -> contains_three_vowels(Tail, Vowel_count) 
    end.

contains_naughty_sequences(_) -> false.
