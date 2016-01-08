-module(light_bulb_tests).
-include_lib("eunit/include/eunit.hrl").

light_bulb_test() ->
    ?assertEqual(on, light_bulb:modify(on, turn_on)),
    ?assertEqual(on, light_bulb:modify(off, turn_on)),
    ?assertEqual(off, light_bulb:modify(off, turn_off)),
    ?assertEqual(off, light_bulb:modify(on, turn_off)),
    ?assertEqual(off, light_bulb:modify(on, toggle)),
    ?assertEqual(on, light_bulb:modify(off, toggle)).

light_bulb_brightness_test() ->
    ?assertEqual(1, light_bulb:modify_brightness(0, turn_on)),
    ?assertEqual(2, light_bulb:modify_brightness(1, turn_on)),
    ?assertEqual(3, light_bulb:modify_brightness(1, toggle)),
    ?assertEqual(3, light_bulb:modify_brightness(1, toggle)),
    ?assertEqual(1, light_bulb:modify_brightness(2, turn_off)),
    ?assertEqual(0, light_bulb:modify_brightness(0, turn_off)).
