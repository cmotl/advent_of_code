-module(naughty_nicer_tests).
-include_lib("eunit/include/eunit.hrl").

contains_these_two_letters_test() ->
    ?assertEqual(false, naughty_nicer:contains_these_two_letters($a,$a,"")),
    ?assertEqual(false, naughty_nicer:contains_these_two_letters($a,$a,"a")),
    ?assertEqual(true, naughty_nicer:contains_these_two_letters($a,$a,"aa")),
    ?assertEqual(true, naughty_nicer:contains_these_two_letters($a,$a,"aaa")),
    ?assertEqual(true, naughty_nicer:contains_these_two_letters($a,$a,"baa")).

contains_two_pairs_of_letters_test() ->
    ?assertEqual(false, naughty_nicer:contains_two_pairs_of_letters("")),
    ?assertEqual(false, naughty_nicer:contains_two_pairs_of_letters("a")),
    ?assertEqual(false, naughty_nicer:contains_two_pairs_of_letters("aa")),
    ?assertEqual(false, naughty_nicer:contains_two_pairs_of_letters("aaa")),
    ?assertEqual(true, naughty_nicer:contains_two_pairs_of_letters("aaaa")),
    ?assertEqual(true, naughty_nicer:contains_two_pairs_of_letters("aabaa")),
    ?assertEqual(true, naughty_nicer:contains_two_pairs_of_letters("baaaa")),
    ?assertEqual(false, naughty_nicer:contains_two_pairs_of_letters("babbcd")),
    ?assertEqual(true, naughty_nicer:contains_two_pairs_of_letters("xyxy")),
    ?assertEqual(true, naughty_nicer:contains_two_pairs_of_letters("aabcdefgaa")).

contains_repeat_with_one_between_test() ->
    ?assertEqual(false, naughty_nicer:contains_repeat_with_one_between("")),
    ?assertEqual(false, naughty_nicer:contains_repeat_with_one_between("a")),
    ?assertEqual(false, naughty_nicer:contains_repeat_with_one_between("aa")),
    ?assertEqual(true, naughty_nicer:contains_repeat_with_one_between("axa")),
    ?assertEqual(false, naughty_nicer:contains_repeat_with_one_between("aax")),
    ?assertEqual(true, naughty_nicer:contains_repeat_with_one_between("xxabadd")),
    ?assertEqual(true, naughty_nicer:contains_repeat_with_one_between("xyx")),
    ?assertEqual(true, naughty_nicer:contains_repeat_with_one_between("abcdefeghi")),
    ?assertEqual(true, naughty_nicer:contains_repeat_with_one_between("aaa")).

naughty_or_nicer_test() ->
    ?assertEqual({naughty}, naughty_nicer:naughty_or_nicer("")),
    ?assertEqual({nicer}, naughty_nicer:naughty_or_nicer("qjhvhtzxzqqjkmpb")),
    ?assertEqual({nicer}, naughty_nicer:naughty_or_nicer("xxyxx")),
    ?assertEqual({naughty}, naughty_nicer:naughty_or_nicer("uurcxstgmygtbstg")),
    ?assertEqual({naughty}, naughty_nicer:naughty_or_nicer("ieodomkazucvgmuy")).
