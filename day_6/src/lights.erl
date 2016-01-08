-module(lights).
-export([read_directions/1, create_strand/3, execute_direction/2, execute_directions/2, count_lights_on/1, execute_brightness_direction/2, execute_brightness_directions/2, count_brightness/1]).

read_directions([$t,$u,$r,$n,_,$o,$n,_|Tail]) -> read_directions(turn_on, Tail);
read_directions([$t,$u,$r,$n,_,$o,$f,$f,_|Tail]) -> read_directions(turn_off, Tail);
read_directions([$t,$o,$g,$g,$l,$e,_|Tail]) -> read_directions(toggle, Tail).

read_directions(Direction, Grid) -> 
    [From,_,To] = string:tokens(Grid," "),
    [X_from,Y_from] = string:tokens(From,","),
    [X_to,Y_to] = string:tokens(To,","),
    {Direction, {list_to_integer(X_from), list_to_integer(Y_from)}, {list_to_integer(X_to), list_to_integer(Y_to)}}.

create_strand(Rows, Columns, Initial_value) -> create_strand({Rows, Columns}, {0, 0}, Initial_value, dict:new()).

create_strand({Rows, _}, {Current_row, _}, _, Strand) 
    when Current_row > Rows -> Strand;
create_strand({Rows, Columns} = Dimensions, {Current_row, Current_column}, Initial_value,  Strand) 
    when Current_column > Columns, Current_row =< Rows -> 
    create_strand(Dimensions, {Current_row+1, 0}, Initial_value, Strand);
create_strand(Dimensions, {Current_row, Current_column}, Initial_value, Strand) -> 
    New_strand = Strand:store({Current_row, Current_column}, Initial_value),
    create_strand(Dimensions, {Current_row, Current_column + 1}, Initial_value, New_strand).
    
execute_direction({Direction, Bulb}, Strand) -> 
    New_state = light_bulb:modify(dict:fetch(Bulb, Strand),Direction),
    dict:store(Bulb, New_state, Strand).

execute_directions({Direction, From_bulb, To_bulb}, Strand) -> 
    execute_directions(Direction, From_bulb, To_bulb, From_bulb, Strand).

execute_directions(_, _, {To_x, _}, {Current_x, _}, Strand) 
    when Current_x > To_x -> Strand;
execute_directions(Direction, {From_x, From_y}, {To_x, To_y}, {Current_x, Current_y}, Strand) 
    when Current_y > To_y, Current_x =< To_x ->
    execute_directions(Direction, {From_x, From_y}, {To_x, To_y},{Current_x+1, From_y}, Strand);
execute_directions(Direction, {From_x, From_y}, {To_x, To_y}, {Current_x, Current_y}, Strand) ->
    execute_directions(Direction, {From_x, From_y}, {To_x, To_y}, {Current_x, Current_y+1}, execute_direction({Direction, {Current_x, Current_y}}, Strand)).
    
count_lights_on(Filename) ->
    Strand = create_strand(999,999, off),
    Reversed_instructions = lines:for_each_line_in_file(Filename,
        fun(Line, Instructions) -> [read_directions(string:substr(Line, 1, string:len(Line)-1))|Instructions] end, 
        [read], []),
    Instructions = lists:reverse(Reversed_instructions),
    Completed_strand = lists:foldl(fun(Instruction, Partial_strand) -> execute_directions(Instruction, Partial_strand) end, Strand, Instructions),
    dict:fold(
        fun(_, State, Count) ->
            case State of
                on -> Count+1;
                off -> Count
            end
        end, 0, Completed_strand).

execute_brightness_direction({Direction, Bulb}, Strand) -> 
    New_state = light_bulb:modify_brightness(dict:fetch(Bulb, Strand),Direction),
    dict:store(Bulb, New_state, Strand).

execute_brightness_directions({Direction, From_bulb, To_bulb}, Strand) -> 
    execute_brightness_directions(Direction, From_bulb, To_bulb, From_bulb, Strand).

execute_brightness_directions(_, _, {To_x, _}, {Current_x, _}, Strand) 
    when Current_x > To_x -> Strand;
execute_brightness_directions(Direction, {From_x, From_y}, {To_x, To_y}, {Current_x, Current_y}, Strand) 
    when Current_y > To_y, Current_x =< To_x ->
    execute_brightness_directions(Direction, {From_x, From_y}, {To_x, To_y},{Current_x+1, From_y}, Strand);
execute_brightness_directions(Direction, {From_x, From_y}, {To_x, To_y}, {Current_x, Current_y}, Strand) ->
    execute_brightness_directions(Direction, {From_x, From_y}, {To_x, To_y}, {Current_x, Current_y+1}, execute_brightness_direction({Direction, {Current_x, Current_y}}, Strand)).

count_brightness(Filename) ->
    Strand = create_strand(999,999,0),
    Reversed_instructions = lines:for_each_line_in_file(Filename,
        fun(Line, Instructions) -> [read_directions(string:substr(Line, 1, string:len(Line)-1))|Instructions] end, 
        [read], []),
    Instructions = lists:reverse(Reversed_instructions),
    Completed_strand = lists:foldl(fun(Instruction, Partial_strand) -> execute_brightness_directions(Instruction, Partial_strand) end, Strand, Instructions),
    dict:fold(
        fun(_, Brightness, Total_brightness) ->
            Brightness + Total_brightness
        end, 0, Completed_strand).
