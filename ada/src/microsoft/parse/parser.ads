--  Suppose an arithmetic expression is given as a binary tree. Each leaf is an integer and each internal node is
--  one of '+', '−', '∗', or '/'.
--
--  Given the root to such a tree, write a function to evaluate it.
--
--  For example, given the following tree:
--
--             *
--        /      \
--      +           +
--  /    \     /   \
--  3      2  4      5
--
--  You should return 45, as it is (3 + 2) * (4 + 5).

package Parser is
   type Node_Types is (Empty, Literal, Plus, Minus, Multiply, Divide);

   type Node (Node_Type : Node_Types) is private;
   type Node_Ptr is access Node;

   Null_Node : constant Node;

   --  Root is the root of the current sub-tree.
   function Evaluate (Root : in Node_Ptr) return Integer;
private
   type Node (Node_Type : Node_Types) is record
      case Node_Type is
         when Empty =>
            null;

         when Literal =>     --  Leaf of the tree.
            Value : Integer;

         when others =>
            Left  : Node_Ptr;
            Right : Node_Ptr;
      end case;
   end record;

   Null_Node : constant Node := (Node_Type => Empty, others => null);
end Parser;
