--  From https://youtu.be/tj_sBZw9nS0

--  This took way too long to do, far too many different edge cases, also as it is
--  it doesn't handle the second to last example.

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;

--  p is a sequence of any of the following:
--  1. a-z - stands for themselves.
--  2. .   - matches any character.
--  3. *   - matches zero of more of the preceding character.
--
--  s = "abc"   p = "ab"       => false
--  s = "aa"    p = "a*"       => true
--  s = "ab"    p = ".*"       => true
--  s = "ab"    p = "."        => false
--  s = "aab"   p = "c*a*b*"   => true
--  s = "aaa"   p = "a*."      => true

procedure Reg_Exp is
   -- subtype Operations is Character with
   --    Static_Predicate => Operations in 'a' .. 'z' | '.' | '*';

   function Match (S, Pattern : in String) return Boolean is
      function Look_Ahead (S : in String; Index : in Positive) return Character is
      begin
         --  Return NUL on end of string.
         if Index + 1 > S'Last then
            return NUL;
         end if;

         return S (Index + 1);
      end Look_Ahead;

      --  Read characters from the Pattern stack and match along the S stack as we go.
      P_Index : Positive := Pattern'First;
      S_Index : Positive := S'First;
      Char    : Character;
      Op      : Character;
      Kleene  : constant Character := '*';
      Dot     : constant Character := '.';
   begin
      --  Case for strings of length 1.
      --  Pattern can only contain . or a-z.
      if Pattern'Length = 1 then
         if Pattern (Pattern'First) = Dot then
            --  Make sure the string passed in is >=1.
            if S'Length = 1 then
               return True;
            else
               --  Cannot match substrings.
               return False;
            end if;
         else
            --  Case of matching a-z.
            if S'Length = 1 and S (S'First) = Pattern (Pattern'First) then
               return True;
            else
               return False;
            end if;
         end if;
      end if;

      --  Strings longer than 1.
      while P_Index <= Pattern'Last loop
         Char := Pattern (P_Index);
         Op   := Look_Ahead (Pattern, P_Index);  --  Might be . or *

         -- Op could be NUL, a-z, . or *
         if Op /= NUL then
            -- Op could be a-z, . or *
            if Op = Kleene then
               --  Skip to the Kleene closure.
               P_Index := P_Index + 1;

               --  Char may not exist in S!
               --  Match against Char or Dot.
               while S_Index <= S'Last and then
                     ((Char = Dot and then S (S_Index) in 'a' .. 'z') or
                      S (S_Index) = Char)
               loop
                  S_Index := S_Index + 1;
               end loop;
            else
               -- At this point we need to match Char
               if S_Index <= S'Last and then S (S_Index) = Char then
                  S_Index := S_Index + 1;
               else
                  return False;
               end if;
            end if;

            --  Skip past the character.
            -- P_Index := P_Index + 1;
         else
            -- At this point we need to match Char
            if S_Index <= S'Last and then S (S_Index) = Char then
               S_Index := S_Index + 1;
            else
               return False;
            end if;
         end if;

         -- Put_Line ("...");
         P_Index := P_Index + 1;
      end loop;

      --  We haven't matched a full string's worth of data.
      if S_Index <= S'Last then
         return False;
      end if;

      return True;
   end Match;

   procedure Do_Match (S, Pattern : in String; Expect : in Boolean) is
   begin
      Put_Line ("S : " & S & "    P : " & Pattern & "   => " &
         Boolean'Image (Match (S, Pattern)) &
         "   Expected : " & Boolean'Image (Expect));
   end Do_Match;

begin
   Do_Match (S => "abc", Pattern => "ab",     Expect => False);
   Do_Match (S => "aa",  Pattern => "a*",     Expect => True);
   Do_Match (S => "ab",  Pattern => ".*",     Expect => True);
   Do_Match (S => "ab",  Pattern => ".",      Expect => False);
   Do_Match (S => "aab", Pattern => "c*a*b*", Expect => True);
   Do_Match (S => "aaa", Pattern => "a*.",    Expect => True);
   Do_Match (S => "a", Pattern => "a",    Expect => True);
end Reg_Exp;