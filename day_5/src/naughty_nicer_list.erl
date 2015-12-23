-module(naughty_nicer_list).
-export([nicer_count/1, naughty_count/1]).

nicer_count(Filename) ->
    lines:for_each_line_in_file(Filename,
            fun(X, Count) -> 
                case naughty_nicer:naughty_or_nicer(X) of
                    {nicer} -> Count+1;
                    {naughty} -> Count 
                end
            end, [read], 0).

naughty_count(Filename) ->
    lines:for_each_line_in_file(Filename,
            fun(X, Count) -> 
                case naughty_nicer:naughty_or_nicer(X) of
                    {nicer} -> Count;
                    {naughty} -> Count+1 
                end
            end, [read], 0).
