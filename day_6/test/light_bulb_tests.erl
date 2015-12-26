-module(light_bulb_tests).
-include_lib("eunit/include/eunit.hrl").

light_bulb_test() ->
    ?assertEqual(on, light_bulb:modify(on, turn_on)),
    ?assertEqual(on, light_bulb:modify(off, turn_on)),
    ?assertEqual(off, light_bulb:modify(off, turn_off)),
    ?assertEqual(off, light_bulb:modify(on, turn_off)),
    ?assertEqual(off, light_bulb:modify(on, toggle)),
    ?assertEqual(on, light_bulb:modify(off, toggle)).

