-module(lights).
-export([read_directions/1, create_strand/2]).

read_directions([$t,$u,$r,$n,_,$o,$n,_|Tail]) -> read_directions(turn_on, Tail);
read_directions([$t,$u,$r,$n,_,$o,$f,$f,_|Tail]) -> read_directions(turn_off, Tail);
read_directions([$t,$o,$g,$g,$l,$e,_|Tail]) -> read_directions(toggle, Tail).

read_directions(Direction, Grid) -> 
    [From,_,To] = string:tokens(Grid," "),
    [X_from,Y_from] = string:tokens(From,","),
    [X_to,Y_to] = string:tokens(To,","),
    {Direction, {list_to_integer(X_from), list_to_integer(Y_from)}, {list_to_integer(X_to), list_to_integer(Y_to)}}.

create_strand(Rows, Columns) -> create_strand({Rows, Columns}, {0, 0}, dict:new()).

create_strand({Rows, _}, {Current_row, _}, Strand) 
    when Current_row > Rows -> Strand;
create_strand({Rows, Columns} = Dimensions, {Current_row, Current_column}, Strand) 
    when Current_column > Columns, Current_row =< Rows -> 
    create_strand(Dimensions, {Current_row+1, 0}, Strand);
create_strand(Dimensions, {Current_row, Current_column}, Strand) -> 
    New_strand = Strand:append({Current_row, Current_column}, off),
    create_strand(Dimensions, {Current_row, Current_column + 1}, New_strand).
    

