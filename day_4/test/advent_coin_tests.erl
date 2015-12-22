-module(advent_coin_tests).
-include_lib("eunit/include/eunit.hrl").

mine_test() ->
    ?assertEqual(609043, advent_coin:mine("abcdef", 609040)),
    ?assertEqual(1048970, advent_coin:mine("pqrstuv", 1048960)).
