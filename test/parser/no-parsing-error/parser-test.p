PROGRAM foo(input, output, error) ;
   // this test checks various degrees of constant folding

   var a, b, c: integer;
   var d, e: array [ 1 .. 10 ] of integer;

   // test simple, non-recursive functions
   function  simplesum(a: integer) : integer;
      begin
         simplesum := a * b
         // simplesum is the return value
      end;

   procedure  sum(a, b: integer);
      begin
         if a <= 0 then g := b + 9
         else g := b * 3
      end;
      

   begin
      a := 2+ -99; // simple expression
      b := 3 + 93 * 5 + 87 * (23+15*6);    // complex expression
      c[4+2] := 3 + 9 * 5 + 87 * (2+15*6); // constant array index
                                           // constant address
      c[3 + 9 * 5 + 87 * (2+15*6)] := 3 + 9 * 5 + 8* (2+15*6)
   end.   // this is the end of the program
