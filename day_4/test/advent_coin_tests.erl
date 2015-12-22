-module(advent_coin_tests).
-include_lib("eunit/include/eunit.hrl").

mine_test() ->
    ?assertEqual("abcdef", advent_coin:mine("abcdef")).
