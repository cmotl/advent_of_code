-module(lights_tests).
-include_lib("eunit/include/eunit.hrl").

read_directions_test() ->
    ?assertEqual({turn_on, {0,0}, {999,999}}, lights:read_directions("turn on 0,0 through 999,999")),
    ?assertEqual({toggle, {0,0}, {999,0}}, lights:read_directions("toggle 0,0 through 999,0")),
    ?assertEqual({turn_off, {499,499}, {500,500}}, lights:read_directions("turn off 499,499 through 500,500")).

create_strand_test() ->
    ?assertEqual(1, dict:size(lights:create_strand(0,0,off))),
    ?assertEqual(2, dict:size(lights:create_strand(0,1,off))),
    ?assertEqual(2, dict:size(lights:create_strand(1,0,off))),
    ?assertEqual(4, dict:size(lights:create_strand(1,1,off))),
    ?assertEqual(6, dict:size(lights:create_strand(2,1,off))),
    ?assertEqual(9, dict:size(lights:create_strand(2,2,off))),
    ?assertEqual(100, dict:size(lights:create_strand(9,9,off))),
    ?assertEqual(10000, dict:size(lights:create_strand(99,99,off))).

execute_direction_test() ->
    ?assertEqual(on, dict:fetch({0,0},lights:execute_direction({turn_on,{0,0}}, lights:create_strand(0,0,off)))).

execute_directions_test() ->
    ?assertEqual(on, dict:fetch({0,0},lights:execute_directions({turn_on,{0,0},{1,1}}, lights:create_strand(1,1,off)))),
    ?assertEqual(on, dict:fetch({0,1},lights:execute_directions({turn_on,{0,0},{1,1}}, lights:create_strand(1,1,off)))),
    ?assertEqual(on, dict:fetch({1,0},lights:execute_directions({turn_on,{0,0},{1,1}}, lights:create_strand(1,1,off)))),
    ?assertEqual(on, dict:fetch({1,1},lights:execute_directions({turn_on,{0,0},{1,1}}, lights:create_strand(1,1,off)))).

execute_brightness_direction_test() ->
    ?assertEqual(1, dict:fetch({0,0},lights:execute_brightness_direction({turn_on,{0,0}}, lights:create_strand(0,0,0)))).

execute_brightness_directions_test() ->
    ?assertEqual(1, dict:fetch({0,0},lights:execute_brightness_directions({turn_on,{0,0},{1,1}}, lights:create_strand(1,1,0)))),
    ?assertEqual(2, dict:fetch({0,1},lights:execute_brightness_directions({toggle,{0,0},{1,1}}, lights:create_strand(1,1,0)))),
    ?assertEqual(2, dict:fetch({1,0},lights:execute_brightness_directions({toggle,{0,0},{1,1}}, lights:create_strand(1,1,0)))),
    ?assertEqual(1, dict:fetch({1,1},lights:execute_brightness_directions({turn_on,{0,0},{1,1}}, lights:create_strand(1,1,0)))).

