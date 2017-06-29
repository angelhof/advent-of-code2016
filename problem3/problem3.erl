-module(problem3).

-export([main/1]).

main(Filename) ->
    {ok, Binary} = file:read_file(Filename),
    String = bitstring_to_list(Binary),
    Stripped = string:strip(String, both, $\n),
    Lines = string:tokens(Stripped, "\n"),
    TrianglesStrings = [string:tokens(Tris, "  ") || Tris <- Lines],
    Triangles = [[list_to_integer(Tri) || Tri <- Tris] || Tris <- TrianglesStrings],
    length([true || Tri <- Triangles, is_valid(Tri)]).

is_valid([A, B, C]) ->
    A + B > C andalso B + C > A andalso C + A > B.
	
