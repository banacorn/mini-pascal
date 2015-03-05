PROGRAM foo(input, output, error) ;
   // variable declaraions
   var a, b, c: integer;
   var g, h: real;


   function addition(a, b: integer) : integer;
      var c: integer;  // local declaration
      begin
         return 1   // this is the return value
      end;

   begin
      c := addition(2, 1)
   end.   // this is the end of the program
