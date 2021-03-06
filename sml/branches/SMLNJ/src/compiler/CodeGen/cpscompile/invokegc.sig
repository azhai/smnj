(*
 * This is an alternative module for generating GC code.
 * There are a few improvements.
 *
 * All code to invoke GC is generated once at the end of the
 * compilation unit---with one exception. For each cluster, a 
 * call to GC is a jump  to the end of the cluster  where there 
 * is another jump.
 * Code to invoke GC for known functions is generated at the end of
 * the cluster. This is important as there may be spilling across
 * gc invocation calls.
 *)

signature INVOKE_GC =
sig
   structure T     : MLTREE
   structure Cells : CELLS

   type t = { maxAlloc : int,
              regfmls  : T.mlrisc list,
	      regtys   : CPS.cty list,
	      return   : T.stm
            }

      (* initialize the state before compiling a module *)
   val init : unit -> unit

      (* generate a check limit for standard function *)
   val stdCheckLimit : (T.stm,int Intmap.intmap) T.stream -> t -> unit

      (* generate a check limit for known function *)
   val knwCheckLimit : (T.stm,int Intmap.intmap) T.stream -> t -> unit

      (* generate a check limit for optimized, known function *)
   val optimizedKnwCheckLimit : (T.stm,int Intmap.intmap) T.stream -> t -> unit

      (* generate a long jump to call gc *)
   val emitLongJumpsToGCInvocation : (T.stm,int Intmap.intmap) T.stream -> unit

      (* generate all GC invocation code in a module *)
   val emitModuleGC : (T.stm,int Intmap.intmap) T.stream -> unit

      (* generate the actual GC invocation code *)
   val callGC : (T.stm,int Intmap.intmap) T.stream -> 
                {regfmls : T.mlrisc list, 
                 regtys : CPS.cty list,
                 ret : T.stm
                }  -> unit

end
