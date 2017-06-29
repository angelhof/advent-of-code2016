-module(problem5).

-export([main/0]).

main() ->
    PuzzleKey = <<"ugkcyxxp">>,
    Res = loop(PuzzleKey, 1, 8, []),
    StringRes = string:join([integer_to_list(Num, 16) || Num <- Res], ""),
    string:lowercase(StringRes).

loop(_, _, 0, Acc) ->
    lists:reverse(Acc);
loop(Key, X, N, Acc) ->
    XBin = list_to_bitstring(integer_to_list(X)),
    ToHash = <<Key/binary, XBin/binary>>,
    Hash = crypto:hash(md5, ToHash),
    <<Zero:20, Num:4, _/binary>> = Hash,
    case Zero of
	0 ->
	    io:format("Found it: ~p~n", [X]),
	    loop(Key, X+1, N-1, [Num|Acc]);
	_ ->
	    loop(Key, X+1, N, Acc)
    end.
			    
