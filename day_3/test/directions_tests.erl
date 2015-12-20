-module(directions_tests).
-include_lib("eunit/include/eunit.hrl").

parse_direction_test() ->
    ?assertEqual(north, directions:parse_direction($^)),
    ?assertEqual(south, directions:parse_direction($v)),
    ?assertEqual(east, directions:parse_direction($>)),
    ?assertEqual(west, directions:parse_direction($<)).

move_from_house_test() -> 
    ?assertEqual({house, {0,1}}, directions:follow_direction_from_house({house, {0,0}},north)),
    ?assertEqual({house, {0,-1}}, directions:follow_direction_from_house({house, {0,0}},south)),
    ?assertEqual({house, {1,0}}, directions:follow_direction_from_house({house, {0,0}},east)),
    ?assertEqual({house, {-1,0}}, directions:follow_direction_from_house({house, {0,0}},west)).

    

