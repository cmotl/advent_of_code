-module(lights).
-export([read_directions/1]).

read_directions([$t,$u,$r,$n,_,$o,$n,_|Tail]) -> read_directions(turn_on, Tail);
read_directions([$t,$u,$r,$n,_,$o,$f,$f,_|Tail]) -> read_directions(turn_off, Tail);
read_directions([$t,$o,$g,$g,$l,$e,_|Tail]) -> read_directions(toggle, Tail).

read_directions(Direction, Grid) -> 
    [From,_,To] = string:tokens(Grid," "),
    [X_from,Y_from] = string:tokens(From,","),
    [X_to,Y_to] = string:tokens(To,","),
    {Direction, {list_to_integer(X_from), list_to_integer(Y_from)}, {list_to_integer(X_to), list_to_integer(Y_to)}}.

