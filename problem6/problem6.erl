-module(problem6).

-export([main/1]).

main(Filename) ->
    {ok, Binary} = file:read_file(Filename),
    List = bitstring_to_list(Binary),
    Stripped = string:strip(List, both, $\n),
    Codes = string:tokens(Stripped, "\n"),
    Maps = [#{} || _ <- hd(Codes)],
    OccMaps = lists:foldl(fun process/2, Maps, Codes),
    OccLists = [maps:to_list(M) || M <- OccMaps],
    Result = [lists:max([{Count, Char} || {Char, Count} <- OccList]) 
	      || OccList <- OccLists],
    [Char || {_Count, Char} <- Result].

process(Code, Maps) ->
    lists:zipwith(fun count/2, Code, Maps).

count(Char, Map) -> 
    case maps:get(Char, Map, none) of
	none ->
	    Map#{Char => 1};
	Occs ->
	    Map#{Char := Occs + 1}
    end.
