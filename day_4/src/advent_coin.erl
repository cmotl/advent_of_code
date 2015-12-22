-module(advent_coin).
-export([mine/1]).

mine(Secret) -> mine(Secret, 1).

mine(Secret, Coin_key) ->
    Secret ++ integer_to_list(Coin_key).
