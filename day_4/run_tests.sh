erlc -o ebin/ src/*.erl test/*.erl 
erl -pa ebin -noshell -eval "eunit:test(advent_coin, [verbose])" -s init stop
