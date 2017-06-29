-module(problem2).

-export([main/1]).

main(Filename) ->
    {ok, InstructionsBinary} = file:read_file(Filename),
    InstructionsList = bitstring_to_list(InstructionsBinary),
    InstructionsStripped = string:strip(InstructionsList, both, $\n),
    Instructions = string:tokens(InstructionsStripped, "\n"),
    Coordinates = [coordinates(Ins) || Ins <- Instructions],
    [button(C) || C <- Coordinates].

button({X, Y}) ->
    Y * 3 + X + 1.

coordinates(Instructions) ->
    lists:foldl(fun next/2, {1,1}, Instructions).

next(Dir, Coords) ->
    {X, Y} = unsafe_next(Dir, Coords),
    {max(min(X, 2), 0), max(min(Y, 2), 0)}.

unsafe_next($U, {X, Y}) -> {X, Y - 1};
unsafe_next($R, {X, Y}) -> {X + 1, Y};
unsafe_next($D, {X, Y}) -> {X, Y + 1};
unsafe_next($L, {X, Y}) -> {X - 1, Y}.
