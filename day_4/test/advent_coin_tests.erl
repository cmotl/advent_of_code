-module(advent_coin_tests).
-include_lib("eunit/include/eunit.hrl").

mine_test() ->
    ?assertEqual(mine, advent_coin:mine()).
