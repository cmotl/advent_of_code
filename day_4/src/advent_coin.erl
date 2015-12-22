-module(advent_coin).
-export([mine/1, mine/2]).

secret_key(Secret, Coin_key) ->
    md5:md5_hex(Secret ++ integer_to_list(Coin_key)).

mine(Secret) -> mine(Secret, 1).

mine(Secret, Coin_key) -> mine(Secret, Coin_key, secret_key(Secret, Coin_key)).

mine(_, Coin_key, [$0,$0,$0,$0,$0|_]) -> Coin_key;
mine(Secret, Coin_key, _) -> 
    New_coin_key = Coin_key + 1,
    mine(Secret, New_coin_key, secret_key(Secret, New_coin_key)).

