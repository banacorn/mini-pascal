program foo(input, output, error) ;

    // global variable declarations
    var a, b, c, d: integer;
    // var g, h: real;

    // global function declarations
    function addition(a, b: integer) : integer;
        var c, d, e, f: integer;   // local variable declaration
            begin
                return 1
            end;

    function id(a: integer) : integer;
        begin
            b := a;
            return b
        end;


    // compound statements, "main"
    begin
        putchar(id(97))
        // addition(2, 1);
        // putchar(3)
    end.
