-module(problem7).

-export([main/1, check/1]).

main(Filename) ->
    {ok, Binary} = file:read_file(Filename),
    List = bitstring_to_list(Binary),
    Stripped = string:strip(List, both, $\n),
    Ips = string:tokens(Stripped, "\n"),
    Clean = [lists:foldl(fun separate/2, {good, [[]], []}, Ip)
	     || Ip <- Ips],
    Valid = [good || {_, Good, Bad} <- Clean, is_valid({Good, Bad})],
    length(Valid).

separate($[, {good, Good, Bad}) ->
    {bad, Good, [[]|Bad]};
separate($], {bad, Good, Bad}) ->
    {good, [[]|Good], Bad};
separate(Char, {good, [Curr|Rest], Bad}) ->
    {good, [[Char|Curr]|Rest], Bad};
separate(Char, {bad, Good, [Curr|Rest]}) ->
    {bad, Good, [[Char|Curr]|Rest]}.


is_valid({Good, Bad}) ->
    lists:any(fun check/1, Good) andalso 
	not lists:any(fun check/1, Bad).

check([]) -> false;
check([_]) -> false;
check([_,_]) -> false;
check([_,_,_]) -> false;
check([A,B,B,A|_]) when A =/= B-> true;
check([_,X2,X3,X4|Rest]) -> 
    check([X2,X3,X4|Rest]).

