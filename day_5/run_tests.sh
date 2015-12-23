erlc -o ebin/ src/*.erl test/*.erl 
erl -pa ebin -noshell -eval "eunit:test(naughty_nicer, [verbose])" -s init stop
