(* bug1318.1.sml *)
(* this fails with g actual: ?.S.tree -> ?.S.info *)

funsig FSIG(type info) = 
sig
  type node
  type info
  type tree
  val f : node -> info
end;

functor FUN(functor F : FSIG):
sig
  type info
  type node
  val g : node -> info
end = 
struct
  type info = int * bool
  structure S = F(type info = info)
  type node = S.node
  val g = S.f
end;

