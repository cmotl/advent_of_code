-module(naughty_nice_list).
-export([nice_count/1, naughty_count/1]).

nice_count(Filename) ->
    lines:for_each_line_in_file(Filename,
            fun(X, Count) -> 
                case naughty_nice:naughty_or_nice(X) of
                    {nice} -> Count+1;
                    {naughty} -> Count 
                end
            end, [read], 0).

naughty_count(Filename) ->
    lines:for_each_line_in_file(Filename,
            fun(X, Count) -> 
                case naughty_nice:naughty_or_nice(X) of
                    {nice} -> Count;
                    {naughty} -> Count+1 
                end
            end, [read], 0).
