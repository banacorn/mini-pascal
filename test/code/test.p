program foo(boo);

    var a, b, c, d: integer;

    function addition(a, b: integer) : integer;
        var c: integer;
            begin
                begin
                    c := a + b
                end;
                return c
            end;

    function id(a: integer) : integer;
        begin
            return a
        end;

    // compound statements, "main"
    begin
        if 3 < 5
            then    putchar(96)
            else    putchar(98);
        putchar(10)
    end.
