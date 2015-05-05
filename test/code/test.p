program foo(input, output, error) ;

    // global variable declarations
    var a, b, c: integer;
    var g, h: real;

    // global function declarations
    function addition(a, b: integer) : integer;
      var c: integer;   // local variable declaration
      begin
         c := a + b;
         return 1
      end;


    // compound statements, "main"
    begin
        a := 3
        // addition(2, 1);
        // putchar(3)
    end.
