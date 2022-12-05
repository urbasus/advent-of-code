with Ada.Command_Line;

with Ada.Text_IO;
use Ada.Text_IO;

procedure CalorieCounting is
   File : File_Type;
   Calories : Natural;
   Highest : Natural;
   Sum : Natural;

   type Top_Three_Type is array (1 .. 3) of Natural;
   Top_Three : Top_Three_Type := (0, 0, 0);

   procedure Update_Top_Three(Top_Three : in out Top_Three_Type; Value : in Natural) is
      Bubble : Natural := Value;
      Swap : Natural;
   begin
      -- One pass bubble sort, dropping the smallest value
      for Index in Top_Three'First .. Top_Three'Last loop
         if Bubble > Top_Three(Index) then
            Swap := Top_Three(Index);
            Top_Three(Index) := Bubble;
            Bubble := Swap;
         end if;
      end loop;
   end Update_Top_Three;

   procedure CountElfCalories(File : in File_Type; Calories : out Integer) is
      -- Limiting the string prevents long lines from exhausting resources
      Number_String : String(1 .. 32);
      Last_Filled : Natural;
   begin
      Calories := 0;

      while not End_Of_File(File) loop
         Get_Line(File, Number_String, Last_Filled);

         Put_Line("Number string is " & Number_String(1 .. Last_Filled));

         -- Stop counting on blank line
         if Last_Filled < 1 then
           return;
         end if;

         Calories := Calories + Natural'Value(Number_String(1 .. Last_Filled));
      end loop;

   end CountElfCalories;

begin
   -- Open file
   Put_Line("Open file");
   Open(File, In_File, Ada.Command_Line.Argument(1));

   -- Read first elf calories to highest
   Put_Line("Count first elf calories");
   CountElfCalories(File, Calories);

   Top_Three(Top_Three'First) := Calories;

   -- While not end of file
   Put_Line("Find highest elf calories");
   while not End_Of_File(File) loop
      CountElfCalories(File, Calories);

      Update_Top_Three(Top_Three, Calories);

   end loop;

   Highest := Top_Three(Top_Three'First);

   -- Output highest calories
   Put_Line("Highest calories: " & Highest'Image);

   Sum := Top_Three(Top_Three'First);

   for Index in Top_Three'First + 1 .. Top_Three'Last loop
      Sum := Sum + Top_Three(Index);
   end loop;

   Put_Line("Sum of top three calories: " & Sum'Image);

end CalorieCounting;
