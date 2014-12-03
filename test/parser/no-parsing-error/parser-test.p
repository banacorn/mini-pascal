PROGRAM foo(input, output, error) ;
   // this test checks various degrees of constant folding

   var a, b, c: integer;
   var d, e: array [ 1 .. 10 ] of integer;

   // procedure and function declarations
   procedure sort(a: array [ 1 .. 10 ] of integer);
      var a, b, c: integer; // duplicated declaration
      begin
        e := a;   // array assignment, global variable
        a := b;
        sort(a);
        begin
            a := b;
            c := d
        end
      end;


   function  addition(a, b: integer) : integer;
      var c: integer;  // local declaration
      begin
            if a = 0
                then
                    addition := b
                else 
                    addition := a + b   // this is the return value
      end;


   begin
      a := 2+ -99; // simple expression
      b := 3 + 93 * 5 + 87 * (23+15*6);    // complex expression
      c[4+2] := 3 + 9 * 5 + 87 * (2+15*6); // constant array index
                                           // constant address
      c[3 + 9 * 5 + 87 * (2+15*6)] := 3 + 9 * 5 + 8* (2+15*6)
   end.   // this is the end of the program
