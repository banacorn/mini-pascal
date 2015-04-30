PROGRAM foo(input, output, error) ;
   var c, d, e, f, g: integer;

   procedure  sum(a, b: integer);
      begin   // here is a parser error.
         a := b + ;
         if a <= 0 then g := b + 9
         else g := b * 3
      end;
      
   begin   // here is another parser error.
      g := c + (d * (e);. 
   end.   // this is the end of the program
