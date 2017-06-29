-module(problem4).

-export([main/1]).

main(Filename) ->
    {ok, Binary} = file:read_file(Filename),
    List = bitstring_to_list(Binary),
    Stripped = string:strip(List, both, $\n),
    AllRooms = string:tokens(Stripped, "\n"),
    Parsed = [parse(Room) || Room <- AllRooms],
    Validated = [validate(Room) || Room <- Parsed],
    lists:sum([Code || {Valid, Code} <- Validated, Valid]).

parse(Room) ->
    NoDashes = string:replace(Room, "-", "", all),
    NoDashesJoined = string:join(NoDashes, ""),
    {Test, Rest} = string:take(NoDashesJoined, lists:seq($a,$z)),
    {Code, [$[|Checksum]} = string:take(Rest, lists:seq($0,$9)),
    {Test, list_to_integer(Code), string:strip(Checksum, both, $])}.

validate({Test, Code, Checksum}) ->
    Count = lists:foldl(fun count/2, #{}, Test),
    Sorted = lists:sort([{B,A} || {A,B}<- maps:to_list(Count)]),
    {MyChecksum, _} = lists:split(5, [B || {_, B} <- Sorted]),
    {MyChecksum =:= Checksum, Code}.

count(Char, Map) ->
    case maps:get(Char, Map, none) of
	none ->
	    Map#{Char => 0};
	Occurences ->
	    Map#{Char => Occurences - 1}
    end.
