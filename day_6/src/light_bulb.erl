-module(light_bulb).
-export([plug_in/0, loop/1, modify/2, modify_brightness/2]).

plug_in() -> spawn(light_bulb, loop, [off]).

modify(Current_state, Instruction) ->
    case Instruction of
        turn_on -> on;
        turn_off -> off;
        toggle when Current_state =:= on -> off;
        toggle when Current_state =:= off -> on
    end.

modify_brightness(Current_brightness, Instruction) ->
    case Instruction of
        turn_on -> Current_brightness+1;
        toggle -> Current_brightness+2;
        turn_off when Current_brightness > 0 -> Current_brightness-1;
        turn_off when Current_brightness =:= 0 -> 0
    end.
loop(Current_state) ->
    receive
        {Instruction} -> loop(modify(Current_state, Instruction));
        {From, state} -> From ! Current_state, loop(Current_state)
    end.

