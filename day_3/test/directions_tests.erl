-module(directions_tests).
-include_lib("eunit/include/eunit.hrl").

parse_direction_test() ->
    ?assertEqual(north, directions:parse_direction($^)),
    ?assertEqual(south, directions:parse_direction($v)),
    ?assertEqual(east, directions:parse_direction($>)),
    ?assertEqual(west, directions:parse_direction($<)).

radio_directions_from_file_test() ->
    ?assertEqual("><<^v^^>", directions:radio_directions_from_file("sample_input.txt")).

cardinal_directions_from_radio_directions_test() ->
    ?assertEqual([north], directions:cardinal_directions_from_radio_directions("^")),
    ?assertEqual([north, south], directions:cardinal_directions_from_radio_directions("^v")),
    ?assertEqual([west, north, east, south], directions:cardinal_directions_from_radio_directions("<^>v")).

divide_dircections_test() ->
    ?assertEqual({[north], []}, directions:divide_directions([north])),
    ?assertEqual({[north], [south]}, directions:divide_directions([north, south])),
    ?assertEqual({[north, east], [south]}, directions:divide_directions([north, south, east])),
    ?assertEqual({[north, east], [south, west]}, directions:divide_directions([north, south, east, west])).

move_from_house_test() -> 
    ?assertEqual({house, {0,1}}, directions:follow_direction_from_house({house, {0,0}},north)),
    ?assertEqual({house, {0,-1}}, directions:follow_direction_from_house({house, {0,0}},south)),
    ?assertEqual({house, {1,0}}, directions:follow_direction_from_house({house, {0,0}},east)),
    ?assertEqual({house, {-1,0}}, directions:follow_direction_from_house({house, {0,0}},west)).
    
cardinal_directions_to_addresses_test() -> 
    ?assertEqual([ {house, {0,0}}, {house, {1,0}} ], directions:directions_to_addresses([east])),
    ?assertEqual([ {house, {0,0}}, {house, {1,0}}, {house,{2,0}} ], directions:directions_to_addresses([east, east])).

number_of_houses_to_visit_test() -> 
    ?assertEqual(1, directions:number_of_houses_to_visit([])),
    ?assertEqual(2, directions:number_of_houses_to_visit([east])),
    ?assertEqual(2, directions:number_of_houses_to_visit([north, south, north, south, north])),
    ?assertEqual(3, directions:number_of_houses_to_visit([east,south])),
    ?assertEqual(4, directions:number_of_houses_to_visit([north, east, south, west])),
    ?assertEqual(3, directions:number_of_houses_to_visit([east,south])).

number_of_houses_to_visit_with_help_test() -> 
    ?assertEqual(1, directions:number_of_houses_to_visit_with_help([])),
    ?assertEqual(2, directions:number_of_houses_to_visit_with_help([east])),
    ?assertEqual(3, directions:number_of_houses_to_visit_with_help([north, south])),
    ?assertEqual(3, directions:number_of_houses_to_visit_with_help([north, east, south, west])),
    ?assertEqual(11, directions:number_of_houses_to_visit_with_help([north, south, north, south, north, south, north, south, north, south])).
