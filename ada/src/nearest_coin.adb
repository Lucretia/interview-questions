--  From https://www.youtube.com/watch?v=xC8CGv1CyFk

with Ada.Text_IO; use Ada.Text_IO;

--  In the C++ above, the coins are at coords:
--    (1, 0), (1, 3), (0, 3), (5, 5)
--  Map is 0 based.

--  distance ( (2, 1) => (1, 3) => 3 (1 left + 2 down))
--  distance ( (2, 1) => (4, 2) => 5 (2 right + 1 down))
--  distance ( (2, 1) => (5, 5) => 7 (3 right + 4 down))

--  +-----------------------+
--  | . | x | . | . | . | . |
--  +-----------------------+
--  | . | . | . | o | . | . |
--  +-----------------------+
--  | o | . | . | . | . | . |
--  +-----------------------+
--  | . | . | . | . | . | . |
--  +-----------------------+
--  | . | . | . | . | o | . |
--  +-----------------------+
--  | . | . | . | . | . | . |
--  +-----------------------+

procedure Nearest_Coin is
   subtype Map_Dimensions is Natural range 1 .. 6;

   type Point is record
     X, Y : Map_Dimensions;
   end record;

   function Manhattan_Distance (P1, P2 : in Point) return Natural is
      (abs (P1.X - P2.X) + abs (P1.Y - P2.Y));

   type Points is array (Natural range <>) of Point;

   function Closest (My_Position : in Point; Coins : in Points) return Positive is
      Index          : Natural := Natural'First;
      Index_Distance : Natural := Manhattan_Distance (My_Position, Coins (Index));
      Coin_Distance  : Natural := Natural'First;
   begin
      --  Assume the array is > 1 in length.
      --  Go through each coin in the array and calculate their distance, My_Position - p.
      for Coin_Index in Coins'First + 1 .. Coins'Last loop
         Coin_Distance := Manhattan_Distance (My_Position, Coins (Coin_Index));

         --  Skip if equal or greater than.
         if Coin_Distance < Index_Distance then
            Index          := Coin_Index;
            Index_Distance := Coin_Distance;
         end if;
      end loop;

      return Index_Distance;
   end Closest;

   Result   : Positive;

   package PIO is new Integer_IO (Positive);
   use PIO;

   My_Position : constant Point := (2, 1);
begin
   Result := Closest (My_Position,
                      Coins => Points'((1, 3), (4, 2), (5, 5)));

   Put ("Result : "); --  3 (1 left + 2 down)
   Put (Result);
   New_Line;

   Result := Closest (My_Position,
                      Coins => Points'((4, 2), (1, 3), (5, 5)));

   Put ("Result : "); --  3 as above
   Put (Result);
   New_Line;

   Result := Closest (My_Position,
                      Coins => Points'((4, 2), (1, 3), (5, 5), (1, 2)));

   Put ("Result : "); --  2 (1 left + 1 down)
   Put (Result);
   New_Line;

   Result := Closest (My_Position,
                      Coins => Points'((4, 2), (1, 3), (5, 5), (2, 2)));

   Put ("Result : "); --  1 (1 down)
   Put (Result);
   New_Line;
end Nearest_Coin;
