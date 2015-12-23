-module(naughty_nice).
-export([contains_duplicate_letters/1, contains_three_vowels/1, contains_naughty_sequences/1, naughty_or_nice/1]).

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

contains_naughty_sequences([]) -> false;
contains_naughty_sequences([_|[]]) -> false;
contains_naughty_sequences([X,Y|Tail]) -> 
    case lists:member([X,Y], ["ab", "cd", "pq", "xy"]) of
        true -> true;
        false -> contains_naughty_sequences([Y|Tail])
    end.    

naughty_or_nice(String) ->
    Three_vowels = contains_three_vowels(String),
    Duplicate_letters = contains_duplicate_letters(String),
    Naughty_sequences = contains_naughty_sequences(String),
    case {Three_vowels, Duplicate_letters, Naughty_sequences} of
        {true, true, false} -> {nice};
        _ -> {naughty}
    end.
