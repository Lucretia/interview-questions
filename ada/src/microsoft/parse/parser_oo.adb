package body Parser_OO is
   function Evaluate (Root : in Node_Ptr) return Integer is
      Result : Integer := 0;
   begin
      if Root /= null then
         if Root.all'Class in Literal then
            return Literal (Root.all).Value;
         elsif Root.all'Class in Operator then
            case Operator (Root.all).Which is
               when '+' =>
                  return Evaluate (Operator (Root.all).Left) + Evaluate (Operator (Root.all).Right);

               when '-' =>
                  return Evaluate (Operator (Root.all).Left) - Evaluate (Operator (Root.all).Right);

               when '*' =>
                  return Evaluate (Operator (Root.all).Left) * Evaluate (Operator (Root.all).Right);

               when '/' =>
                  return Evaluate (Operator (Root.all).Left) / Evaluate (Operator (Root.all).Right);
            end case;
         end if;
      end if;

      return 0;
   end Evaluate;
end Parser_OO;
