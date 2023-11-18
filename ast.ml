type bop = 
  | Add
  | Sub
  | Mult
  | Divide
  | Leq
  | Geq
  | FAdd
  | FSub
  | FMult
  | FDivide


(** [typ] represents the type of an expression. *)
type typ =
  | TInt
  | TBool
  | TFloat

type expr = 
| Var of string
| Int of int
| Bool of bool
| Binop of bop * expr * expr
| Float of float
| Let of string * typ * expr * expr
| If of expr * expr * expr
