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

package Parser_OO is
   type Node is tagged private;
   type Literal is new Node with private;
   type Operator is new Node with private;

   type Node_Ptr is access Node'Class;

   Null_Node     : constant Node;
   Null_Literal  : constant Literal;
   Null_Operator : constant Operator;

   --  Root is the root of the current sub-tree.
   function Evaluate (Root : in Node_Ptr) return Integer;
private
   type Node tagged is null record;

   type Literal is new Node with record
      Value : Integer;
   end record;

   type Operator is new Node with record
      Which : Character;
      Left  : Node_Ptr;
      Right : Node_Ptr;
   end record;

   Null_Node     : constant Node     := (others => <>);
   Null_Literal  : constant Literal  := (Value  => 0);
   Null_Operator : constant Operator := (Which  => '0', others => null);
end Parser_OO;
