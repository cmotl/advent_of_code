-module(chars).
-export([for_each_char_in_file/4]).
 
for_each_char_in_file(Name, Proc, Mode, Accum0) ->
    {ok, Device} = file:open(Name, Mode),
    for_each_char(Device, Proc, Accum0).
 
for_each_char(Device, Proc, Accum) ->
    case io:get_chars(Device, "", 1) of
        eof  -> file:close(Device), Accum;
        Line -> NewAccum = Proc(Line, Accum),
                    for_each_char(Device, Proc, NewAccum)
    end.
