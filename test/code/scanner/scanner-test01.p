PROGRAM mytest(input, output, error) ;

   //incorrect symbols test
   var a, 0aa, bb: integer;
   var gg, hh, mm, pp, pp@$5: real;

  
   var di, ei, ei00, ei;,- : array [ 1 .. 10 ] of integer; 
   var dr, er, er00, er;,-: array [ 1 .. 10 ] of real; 

   var kki, iii: array [ 23 .. 57 ] of array [ 23 .. 57 ] of integer; 
   var kkr, iir: array [ 23 .. 57 ] of array [ 23 .. 57 ] of real; 
   
   var aVeryLongIdentifierGASDFDFGHJERYUKDVBNFBNDFGHwertyuioplkjhgfdsazxcvbnm: integer;
   var a_wrong_identifier_aadgnm: integer;
   
   //this is a very long comment and includes letter and symbol qwertyui~@%hopasdfghjkl;.,mnbvcxz`1234567890p;mdsf4577846799tj,vsffdfger~!@#$%^&*()POIUYEP{{}_+|_{"?><MZXCVB

   begin
      a := 1;
      bb:=354+126*(920-27/190);
      cc := 10..20;
      gg := 10.3E+5;
      hh := 10.3E+BC;
      mm := 10.3E+2.34;
      pp := 10.3EBC;
      rr := 10.3E+5+123;
      str := 'This is a srting!!';
      str2 := "  This is a srting,too!!  ";
      str3 := "";
      str4 := "adc""def";
      str4 := "cross 
         line string";
      incorrect_symbols := ~!@#$%^&*()_+|`-=\,./;[]'{}<>?:
   end.   // this is the end of the program
