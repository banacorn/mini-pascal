PROGRAM foo(input, output, error) ;

    // declarations
    var d, e: array [ 1 .. 10 ] of integer;

    // simple, non-recursive functions
    function simplefun(a: integer) : integer;
        begin
            simplefun := a
        end;

    // procedure
    procedure  sum(a, b: integer);
        begin
            if a <= 0 then g := b + 9
            else g := b * 3
        end;

    begin
        b := 1 + 2 * 3 - 4 * (4 / 2);    // complex expression
        e[4 + 2] := simplefun(3)         // array
    end.   // this is the end of the program
