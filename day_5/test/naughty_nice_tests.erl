-module(naughty_nice_tests).
-include_lib("eunit/include/eunit.hrl").

duplicate_letters_test() ->
    ?assertEqual(false, naughty_nice:contains_duplicate_letters("")),
    ?assertEqual(false, naughty_nice:contains_duplicate_letters("a")),
    ?assertEqual(true, naughty_nice:contains_duplicate_letters("aa")),
    ?assertEqual(false, naughty_nice:contains_duplicate_letters("ab")),
    ?assertEqual(false, naughty_nice:contains_duplicate_letters("abcdefg")),
    ?assertEqual(true, naughty_nice:contains_duplicate_letters("abcdeff")),
    ?assertEqual(true, naughty_nice:contains_duplicate_letters("aabcdef")),
    ?assertEqual(true, naughty_nice:contains_duplicate_letters("abcdeefgh")).

three_vowels_test() ->
    ?assertEqual(false, naughty_nice:contains_three_vowels("")),
    ?assertEqual(false, naughty_nice:contains_three_vowels("a")),
    ?assertEqual(false, naughty_nice:contains_three_vowels("aa")),
    ?assertEqual(true, naughty_nice:contains_three_vowels("aaa")),
    ?assertEqual(true, naughty_nice:contains_three_vowels("aei")),
    ?assertEqual(true, naughty_nice:contains_three_vowels("iou")),
    ?assertEqual(true, naughty_nice:contains_three_vowels("aeiou")),
    ?assertEqual(true, naughty_nice:contains_three_vowels("xazegov")),
    ?assertEqual(true, naughty_nice:contains_three_vowels("aeiouaeiouaeiou")),
    ?assertEqual(false, naughty_nice:contains_three_vowels("bcdfghjklmnpqrstvwxyz")),
    ?assertEqual(true, naughty_nice:contains_three_vowels("abcdfghjklmnpqrstvwxyzaa")).

contains_naughty_sequences_test() ->
    ?assertEqual(false, naughty_nice:contains_naughty_sequences("")).
