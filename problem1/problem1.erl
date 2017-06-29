-module(problem1).

-export([main/1]).

main(Filename) ->
    {ok, InstructionsBinary} = file:read_file(Filename),
    InstructionsList = bitstring_to_list(InstructionsBinary),
    InstructionsStripped = string:strip(InstructionsList, both, $\n),
    Instructions = string:tokens(InstructionsStripped, ", "),
    loop(Instructions).

loop(Instructions) ->
    {{X, Y}, _} = lists:foldl(fun walk/2, {{0, 0}, north}, Instructions),
    abs(X) + abs(Y).

walk([$R|Steps], {Coords, north}) ->
    move_east(list_to_integer(Steps), Coords);
walk([$L|Steps], {Coords, south}) ->
    move_east(list_to_integer(Steps), Coords);
walk([$L|Steps], {Coords, north}) ->
    move_west(list_to_integer(Steps), Coords);
walk([$R|Steps], {Coords, south}) ->
    move_west(list_to_integer(Steps), Coords);
walk([$R|Steps], {Coords, east}) ->
    move_south(list_to_integer(Steps), Coords);
walk([$L|Steps], {Coords, west}) ->
    move_south(list_to_integer(Steps), Coords);
walk([$R|Steps], {Coords, west}) ->
    move_north(list_to_integer(Steps), Coords);
walk([$L|Steps], {Coords, east}) ->
    move_north(list_to_integer(Steps), Coords).

move_east(Steps, {X, Y})  -> {{X + Steps, Y}, east}.
move_south(Steps, {X, Y}) -> {{X, Y - Steps}, south}.
move_west(Steps, {X, Y})  -> {{X - Steps, Y}, west}.
move_north(Steps, {X, Y}) -> {{X, Y + Steps}, north}.
