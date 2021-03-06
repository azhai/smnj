(* alphaJumps.sml --- information to resolve jumps. 
 *
 * COPYRIGHT (c) 1996 Bell Laboratories.
 *
 *)
functor AlphaJumps
  (structure Instr : ALPHAINSTR
   structure Shuffle : ALPHASHUFFLE
      sharing Shuffle.I = Instr) : SDI_JUMPS = 
struct
  structure I = Instr
  structure C = I.C
  structure Const = I.Constant
  structure LE = I.LabelExp

  fun error msg = MLRiscErrorMsg.error("AlphaJumps",msg)

  val branchDelayedArch = false

  fun isSdi(I.DEFFREG _) 	          = true
    | isSdi(I.LDA{d=I.LABop _, ...})      = true
    | isSdi(I.LOAD{d=I.LABop _, ...})   = true
    | isSdi(I.STORE{d=I.LABop _, ...})  = true
    | isSdi(I.FSTORE{d=I.LABop _, ...}) = true
    | isSdi(I.FLOAD{d=I.LABop _, ...})  = true
    | isSdi(I.OPERATE{rb=I.LABop _, ...})= true
    | isSdi(I.OPERATEV{rb=I.LABop _, ...})= true
    | isSdi(I.CMOVE{rb=I.LABop _, ...}) = true
    | isSdi(I.COPY _)			  = true
    | isSdi(I.FCOPY _)			  = true
    | isSdi(I.ANNOTATION{i,...})          = isSdi i
    | isSdi _            		  = false

  fun minSize(I.DEFFREG _) = 0
    | minSize(I.COPY _)    = 0
    | minSize(I.FCOPY _)   = 0
    | minSize(I.ANNOTATION{i,...}) = minSize i
    | minSize _            = 4

  (* max Size is not used for the alpha span dependency analysis. *)
  fun maxSize _ = error "maxSize"

  fun immed16 n =  ~32768 <= n andalso n < 32768 
  fun im16load n = if immed16 n then 4 else 8
  fun im16Oper le = if immed16 (LE.valueOf le) then 4 else 12

  fun immed8 n = n >= 0 andalso n < 256
  fun im8Oper le = if immed8 (LE.valueOf le) then 4 else 12

  fun sdiSize(I.DEFFREG _, _, _) = 0
    | sdiSize(I.LDA{d=I.LABop le, ...}, _, _) = im16load(LE.valueOf le)
    | sdiSize(I.LOAD{d=I.LABop le, ...}, _, _) = im16Oper le
    | sdiSize(I.STORE{d=I.LABop le, ...}, _, _) = im16Oper le
    | sdiSize(I.FLOAD{d=I.LABop le, ...}, _, _) = im16Oper le
    | sdiSize(I.FSTORE{d=I.LABop le, ...}, _, _) = im16Oper le
    | sdiSize(I.OPERATE{rb=I.LABop le, ...}, _, _) = im8Oper le
    | sdiSize(I.OPERATEV{rb=I.LABop le, ...}, _, _) = im8Oper le
    | sdiSize(I.CMOVE{rb=I.LABop le, ...}, _, _) = im8Oper le
    | sdiSize(I.COPY{impl=ref(SOME l),...}, _, _) = 4 * length l
    | sdiSize(I.FCOPY{impl=ref(SOME l),...}, _, _) = 4 * length l
    | sdiSize(I.COPY{dst, src, impl as ref NONE, tmp}, _, _) = let
	val instrs = Shuffle.shuffle{tmp=tmp, dst=dst, src=src}
      in  impl := SOME instrs;  4 * length instrs
      end
    | sdiSize(I.FCOPY{dst, src, impl as ref NONE, tmp}, _, _) = let
        val instrs = Shuffle.shufflefp{tmp=tmp, dst=dst, src=src}
      in impl := SOME(instrs); 4 * length instrs
      end
    | sdiSize(I.ANNOTATION{i,...},x,y) = sdiSize(i,x,y)
    | sdiSize _ = error "sdiSize"

 (* NOTE: All sdis must use a dedicated physical register as a 
  * temporaries, since sdi expansion is performed after register 
  * allocation.
  *)
  val zeroR = Option.valOf(C.zeroReg CellsBasis.GP)

  fun expand(instr, size, pos) = let
    fun load(ldClass, ldOp, r, b, d as I.LABop le, mem) = 
      (case size 
       of 4 => [ldClass{ldOp=ldOp, r=r, b=b, d=I.IMMop(LE.valueOf le), mem=mem}]
        | 12 => let
            val instrs = expand(I.LDA{r=r, b=b, d=d}, 8, pos)
          in instrs @ [ldClass{ldOp=ldOp, r=r, b=r, d=I.IMMop 0, mem=mem}]
          end)

    fun store(stClass, stOp, r, b, d as I.LABop le, mem) = 
      (case size 
       of 4 => [stClass{stOp=stOp, r=r, b=b, d=I.IMMop(LE.valueOf le), mem=mem}]
        | 12 => let
	    val instrs = expand(I.LDA{r=C.asmTmpR, b=b, d=d}, 8, pos)
	  in instrs @ [stClass{stOp=stOp, r=r, b=C.asmTmpR, d=I.IMMop 0, mem=mem}]
	  end)

    fun operate(opClass, oper, ra, rb as I.LABop le, rc) =
      (case size
       of 4 => [opClass{oper=oper, ra=ra, rb=I.IMMop(LE.valueOf le), rc=rc}]
	| 12 => let
	    val instrs = expand(I.LDA{r=C.asmTmpR, b=zeroR, d=rb}, 8, pos)
	  in instrs @ [opClass{oper=oper, ra=ra, rb=I.REGop C.asmTmpR, rc=rc}]
	  end)
  in
    case instr
    of I.DEFFREG _ => []
     | I.LDA{r=rd, b=rs, d=I.LABop le} => 
       (case size of
	  4  => [I.LDA{r=rd, b=rs, d=I.LOLABop le}]
	| 8  => [I.LDA{r=rd, b=rs, d=I.LOLABop le},
		 I.LDAH{r=rd, b=rd, d=I.HILABop le}]
	| _  => error "expand:LDA"
       )
    | I.COPY{impl=ref(SOME instrs),...} => instrs
    | I.FCOPY{impl=ref(SOME instrs),...} => instrs
    | I.LOAD{ldOp, r, b, d, mem} => load(I.LOAD, ldOp, r, b, d, mem)
    | I.FLOAD{ldOp, r, b, d, mem} => load(I.FLOAD, ldOp, r, b, d, mem)
    | I.STORE{stOp, r, b, d, mem} => store(I.STORE, stOp, r, b, d, mem)
    | I.FSTORE{stOp, r, b, d, mem} => store(I.FSTORE, stOp, r, b, d, mem)
    | I.OPERATE{oper, ra, rb, rc} => operate(I.OPERATE, oper, ra, rb, rc)
    | I.OPERATEV{oper, ra, rb, rc} => operate(I.OPERATEV, oper, ra, rb, rc)
    | I.CMOVE{oper, ra, rb, rc} => 
      (case size
       of 4 => [instr]
	| 12 => 
          let val instrs = expand(I.LDA{r=C.asmTmpR, b=zeroR, d=rb}, 8, pos)
	  in  instrs @ [I.CMOVE{oper=oper, ra=ra, rb=I.REGop C.asmTmpR, rc=rc}]
	  end)
    | I.ANNOTATION{i,...} => expand(i,size,pos)
    | _ => error "expand"
  end

end


