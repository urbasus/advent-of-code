with Ada.Command_Line;

with Ada.Text_IO;
use Ada.Text_IO;

procedure CalorieCounting is
   File : File_Type;
   Calories : Natural;
   Highest : Natural;

   procedure CountElfCalories(File : in File_Type; Calories : out Integer) is
      -- Limiting the string prevents long lines from exhausting resources
      NumberString : String(1 .. 32);
      LastFilled : Natural;
   begin
      Calories := 0;

      while not End_Of_File(File) loop
         Get_Line(File, NumberString, LastFilled);

         Put_Line("Number string is " & NumberString(1 .. LastFilled));

         -- Stop counting on blank line
         if LastFilled < 1 then
           return;
         end if;

         Calories := Calories + Natural'Value(NumberString(1 .. LastFilled));
      end loop;

   end CountElfCalories;

begin
   -- Open file
   Put_Line("Open file");
   Open(File, In_File, Ada.Command_Line.Argument(1));

   -- Read first elf calories to highest
   Put_Line("Count first elf calories");
   CountElfCalories(File, Highest);

   -- While not end of file
   Put_Line("Find highest elf calories");
   while not End_Of_File(File) loop
      CountElfCalories(File, Calories);

      if Highest < Calories then
         Highest := Calories;
      end if;

   end loop;

   -- Output highest calories
   Put_Line("Highest calories: " & Highest'Image);

end CalorieCounting;
