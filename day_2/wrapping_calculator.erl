-module(wrapping_calculator).
-export([ribbon_needed/1,paper_needed/1]).

parse_dimensions(Input) -> 
    Dimensions = string:tokens(Input, "x"),
    [ {L, _}, {W,_}, {H,_} | [] ] = lists:map(fun(Dimension) -> string:to_integer(Dimension) end, Dimensions), 
    { L, W, H }.

ribbon_needed(Input) ->
    Dimensions = parse_dimensions(Input),
    ribbon_for_perimeter(Dimensions) + ribbon_for_bow(Dimensions).

paper_needed(Input) ->
    Dimensions = parse_dimensions(Input),
    Side_areas = three_dimensional_area(Dimensions), 
    Slack = area(smallest_side(Dimensions)),
    Slack + Side_areas.

smallest_side({L,W,H}) ->
    [S1, S2 | _] = lists:sort([L,W,H]),
    {S1, S2}.

ribbon_for_perimeter(Dimensions) -> 
    {S1, S2} = smallest_side(Dimensions),
    S1+S1+S2+S2.

ribbon_for_bow({L,W,H}) -> 
    L*W*H.

three_dimensional_area({L,W,H}) ->
    Side_areas = lists:map(fun(Side) -> 2 * area(Side) end, [{L,W},{W,H},{H,L}]),
    lists:sum(Side_areas).

area({L,W}) -> L*W. 
