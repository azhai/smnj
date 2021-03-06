(* basictypes.sig *)

signature BASICTYPES = sig

structure Basics: BASICS

val arrowTycon : Basics.tycon ref
val --> : Basics.ty * Basics.ty -> Basics.ty

val intTycon : Basics.tycon ref
val intTy : Basics.ty

val realTycon  : Basics.tycon ref
val realTy : Basics.ty

val stringTycon  : Basics.tycon ref
val stringTy : Basics.ty

val exnDcons : Basics.datacon list ref
val exnTycon : Basics.tycon ref
val exnTy : Basics.ty

val arrayTycon : Basics.tycon ref

val byte_arrayTycon : Basics.tycon ref
val byte_arrayTy : Basics.ty

val unitTycon : Basics.tycon ref
val unitTy : Basics.ty

val recordTy : (Basics.label * Basics.ty) list -> Basics.ty
val tupleTy : Basics.ty list -> Basics.ty

val boolTycon : Basics.tycon ref
val boolTy : Basics.ty
val falseDcon : Basics.datacon
val trueDcon : Basics.datacon

val refTycon : Basics.tycon ref
val refDcon : Basics.datacon

val listTycon : Basics.tycon ref
val nilDcon : Basics.datacon
val consDcon : Basics.datacon

val newEqualityType : unit -> Basics.ty
val newAssignType : unit -> Basics.ty
val newUpdateType : unit -> Basics.ty

end (* signature BASICTYPES *)
