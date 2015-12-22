-module(advent_coin_tests).
-include_lib("eunit/include/eunit.hrl").

mine_test() ->
    ?assertEqual("abcdef1", advent_coin:mine("abcdef")),
    ?assertEqual("pqrstuv1", advent_coin:mine("pqrstuv")).
