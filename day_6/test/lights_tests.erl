-module(lights_tests).
-include_lib("eunit/include/eunit.hrl").

read_directions_test() ->
    ?assertEqual({turn_on, {0,0}, {999,999}}, lights:read_directions("turn on 0,0 through 999,999")),
    ?assertEqual({toggle, {0,0}, {999,0}}, lights:read_directions("toggle 0,0 through 999,0")),
    ?assertEqual({turn_off, {499,499}, {500,500}}, lights:read_directions("turn off 499,499 through 500,500")).

