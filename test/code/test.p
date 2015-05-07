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

    function getint : integer;
        var a : integer;
            begin
                a := getchar();
                return a - 48
            end;

    function newline : void;
        begin
            putchar(10)
        end;

    function putint(a: integer) : void;
        begin
            putchar(a + 48)
        end;

    // compound statements, "main"
    begin
        a := getint();
        newline();
        if a < 5
            then    putchar(97)
            else    putchar(98);
        newline()
    end.
