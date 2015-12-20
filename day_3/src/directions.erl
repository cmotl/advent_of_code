-module(directions).
-export([parse_direction/1, follow_direction_from_house/2]).

parse_direction($^) -> north;
parse_direction($v) -> south;
parse_direction($>) -> east;
parse_direction($<) -> west.

follow_direction_from_house({house, {X,Y}},north) -> {house, {X,Y+1}};
follow_direction_from_house({house, {X,Y}},south) -> {house, {X,Y-1}};
follow_direction_from_house({house, {X,Y}},east) -> {house, {X+1,Y}};
follow_direction_from_house({house, {X,Y}},west) -> {house, {X-1,Y}}.
