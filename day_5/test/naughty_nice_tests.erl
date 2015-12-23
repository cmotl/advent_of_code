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
    ?assertEqual(false, naughty_nice:contains_naughty_sequences("")),
    ?assertEqual(false, naughty_nice:contains_naughty_sequences("a")),
    ?assertEqual(false, naughty_nice:contains_naughty_sequences("aa")),
    ?assertEqual(true, naughty_nice:contains_naughty_sequences("ab")),
    ?assertEqual(true, naughty_nice:contains_naughty_sequences("cd")),
    ?assertEqual(true, naughty_nice:contains_naughty_sequences("pq")),
    ?assertEqual(true, naughty_nice:contains_naughty_sequences("xy")),
    ?assertEqual(false, naughty_nice:contains_naughty_sequences("acefghijklmnoprstuvwxz")),
    ?assertEqual(true, naughty_nice:contains_naughty_sequences("abcefghijklmnoprstuvwxz")),
    ?assertEqual(true, naughty_nice:contains_naughty_sequences("acdefghijklmnoprstuvwxz")),
    ?assertEqual(true, naughty_nice:contains_naughty_sequences("acefghijklmnopqrstuvwxz")),
    ?assertEqual(true, naughty_nice:contains_naughty_sequences("acefghijklmnoprstuvwxyz")),
    ?assertEqual(true, naughty_nice:contains_naughty_sequences("abcdefghijklmnopqrstuvwxyz")).

naughty_or_nice_test() ->
    ?assertEqual({nice}, naughty_nice:naughty_or_nice("ugknbfddgicrmopn")),
    ?assertEqual({nice}, naughty_nice:naughty_or_nice("aaa")),
    ?assertEqual({naughty}, naughty_nice:naughty_or_nice("jchzalrnumimnmhp")),
    ?assertEqual({naughty}, naughty_nice:naughty_or_nice("haegwjzuvuyypxyu")),
    ?assertEqual({naughty}, naughty_nice:naughty_or_nice("dvszwmarrgswjxmb")).
