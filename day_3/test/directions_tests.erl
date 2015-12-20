-module(directions_tests).
-include_lib("eunit/include/eunit.hrl").

parse_direction_test() ->
    ?assertEqual(north, directions:parse_direction($^)),
    ?assertEqual(south, directions:parse_direction($v)),
    ?assertEqual(east, directions:parse_direction($>)),
    ?assertEqual(west, directions:parse_direction($<)).
