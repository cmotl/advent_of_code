-module(floor_counter).
-export([count_floors/1, first_basement/1, parse_file/1]).

count_floors(Directions) -> count_floors_helper(Directions, 0).

count_floors_helper([], Count) -> Count;
count_floors_helper([H|T], Count) when H == $( -> count_floors_helper(T, Count+1);
count_floors_helper([H|T], Count) when H == $) -> count_floors_helper(T, Count-1).

first_basement(Directions) -> first_basement_helper(Directions, 0, 0).

first_basement_helper([],_,_) -> -1;
first_basement_helper([H|T], Count, Position) when H == $( -> first_basement_helper(T, Count+1, Position+1);
first_basement_helper([H|T], Count, Position) when H == $), Count > 0 -> first_basement_helper(T, Count-1, Position+1);
first_basement_helper([H|_],_, Position) when H == $) -> Position+1.

parse_file(File) ->
    {ok, Data} = file:read_file(File),
    binary:bin_to_list(Data,{0,byte_size(Data)-1}).
