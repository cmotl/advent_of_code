-module(directions).
-export([parse_direction/1, follow_direction_from_house/2, directions_to_addresses/1, number_of_houses_to_visit/1, radio_directions_from_file/1, cardinal_directions_from_radio_directions/1, houses_to_visit/1, divide_directions/1, number_of_houses_to_visit_with_help/1, houses_to_visit_with_help/1]).

parse_direction($^) -> north;
parse_direction($v) -> south;
parse_direction($>) -> east;
parse_direction($<) -> west.

radio_directions_from_file(Filename) ->
    [_|Lists_of_directions] = chars:for_each_char_in_file(Filename, fun(H, Tail) -> [H|Tail] end, [read], []),
    Directions_to_flatten = lists:reverse(Lists_of_directions),
    lists:flatten(Directions_to_flatten).


cardinal_directions_from_radio_directions(Radio_directions) ->
    lists:map(fun(X) -> parse_direction(X) end, Radio_directions).

follow_direction_from_house({house, {X,Y}},north) -> {house, {X,Y+1}};
follow_direction_from_house({house, {X,Y}},south) -> {house, {X,Y-1}};
follow_direction_from_house({house, {X,Y}},east) -> {house, {X+1,Y}};
follow_direction_from_house({house, {X,Y}},west) -> {house, {X-1,Y}}.

directions_to_addresses(Directions) ->
    {_, Reversed_addresses} = lists:foldl(
            fun(Direction, {{house, {_,_}} = Address, Addresses}) -> 
                Next_house = directions:follow_direction_from_house(Address, Direction),
                {Next_house, [Next_house | Addresses]} end, {{house,{0,0}},[{house,{0,0}}]}, Directions),
    lists:reverse(Reversed_addresses).

number_of_houses_to_visit(Directions) ->
    Addresses = directions_to_addresses(Directions),
    Unique_addresses = lists:foldl(
            fun(K, D) -> dict:append(K,K,D) end,
            dict:new(),
            Addresses),
    dict:size(Unique_addresses).

divide_directions(Directions) ->
    {Set1, Set2} = divide_directions(Directions, [], [], 0),
    {lists:reverse(Set1), lists:reverse(Set2)}.

divide_directions([], Set1, Set2, _) -> {Set1, Set2}; 
divide_directions([H|Tail], Set1, Set2, Index) when Index rem 2 =:= 0 -> 
    divide_directions(Tail, [H|Set1], Set2, Index + 1);
divide_directions([H|Tail], Set1, Set2, Index) when Index rem 2 =/= 0 -> 
    divide_directions(Tail, Set1, [H|Set2], Index + 1).
    
    

number_of_houses_to_visit_with_help(Directions) ->
    {Santa_directions, Robo_santa_directions} = divide_directions(Directions),
    Santa_addresses = directions_to_addresses(Santa_directions),
    Robo_santa_addresses = directions_to_addresses(Robo_santa_directions),
    Santa_unique_addresses = lists:foldl(
            fun(K, D) -> dict:append(K,K,D) end,
            dict:new(),
            Santa_addresses),
    Combined_unique_addresses = lists:foldl(
            fun(K, D) -> dict:append(K,K,D) end,
            Santa_unique_addresses,
            Robo_santa_addresses),
    dict:size(Combined_unique_addresses).

houses_to_visit(Filename) -> 
    Radio_directions = directions:radio_directions_from_file(Filename),
    Cardinal_directions = directions:cardinal_directions_from_radio_directions(Radio_directions),
    number_of_houses_to_visit(Cardinal_directions).

houses_to_visit_with_help(Filename) -> 
    Radio_directions = directions:radio_directions_from_file(Filename),
    Cardinal_directions = directions:cardinal_directions_from_radio_directions(Radio_directions),
    number_of_houses_to_visit_with_help(Cardinal_directions).
