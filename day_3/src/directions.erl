-module(directions).
-export([parse_direction/1]).

parse_direction($^) -> north;
parse_direction($v) -> south;
parse_direction($>) -> east;
parse_direction($<) -> west.


