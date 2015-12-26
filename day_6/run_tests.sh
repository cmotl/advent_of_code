erlc -o ebin/ src/*.erl test/*.erl 
erl -pa ebin -noshell -eval "eunit:test(lights, [verbose])" -eval "eunit:test(light_bulb, [verbose])" -s init stop
