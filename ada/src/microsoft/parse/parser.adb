package body Parser is
   function Evaluate (Root : in Node_Ptr) return Integer is
      Result : Integer := 0;
   begin
      if Root /= null then
         case Root.Node_Type is
            when Empty =>
               null;

            when Literal =>
               return Root.Value;

            when Plus =>
               return Evaluate (Root.Left) + Evaluate (Root.Right);

            when Minus =>
               return Evaluate (Root.Left) - Evaluate (Root.Right);

            when Multiply =>
               return Evaluate (Root.Left) * Evaluate (Root.Right);

            when Divide =>
               return Evaluate (Root.Left) / Evaluate (Root.Right);
         end case;
      end if;

      return 0;
   end Evaluate;
end Parser;
