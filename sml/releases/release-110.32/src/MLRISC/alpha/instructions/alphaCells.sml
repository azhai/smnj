(*
 * WARNING: This file was automatically generated by MDLGen (v3.0)
 * from the machine description file "alpha/alpha.mdl".
 * DO NOT EDIT this file directly
 *)


signature ALPHACELLS =
sig
   include CELLS_COMMON
   val CELLSET : cellkind
   val showGP : register_id -> string
   val showFP : register_id -> string
   val showCC : register_id -> string
   val showMEM : register_id -> string
   val showCTRL : register_id -> string
   val showCELLSET : register_id -> string
   val showGPWithSize : (register_id * sz) -> string
   val showFPWithSize : (register_id * sz) -> string
   val showCCWithSize : (register_id * sz) -> string
   val showMEMWithSize : (register_id * sz) -> string
   val showCTRLWithSize : (register_id * sz) -> string
   val showCELLSETWithSize : (register_id * sz) -> string
   val stackptrR : cell
   val asmTmpR : cell
   val fasmTmp : cell
   val returnAddr : cell
   val r31 : cell
   val f31 : cell
   val addGP : (cell * cellset) -> cellset
   val addFP : (cell * cellset) -> cellset
   val addCC : (cell * cellset) -> cellset
   val addMEM : (cell * cellset) -> cellset
   val addCTRL : (cell * cellset) -> cellset
   val addCELLSET : (cell * cellset) -> cellset
end

structure AlphaCells : ALPHACELLS =
struct
   exception AlphaCells
   fun error msg = MLRiscErrorMsg.error("AlphaCells",msg)
   fun showGPWithSize (r, ty) = (fn (30, _) => "$sp"
                                  | (r, _) => "$" ^ (Int.toString r)
                                ) (r, ty)
   and showFPWithSize (r, ty) = (fn (f, _) => "$f" ^ (Int.toString f)
                                ) (r, ty)
   and showCCWithSize (r, ty) = (fn _ => "cc"
                                ) (r, ty)
   and showMEMWithSize (r, ty) = (fn (r, _) => "m" ^ (Int.toString r)
                                 ) (r, ty)
   and showCTRLWithSize (r, ty) = (fn (r, _) => "ctrl" ^ (Int.toString r)
                                  ) (r, ty)
   and showCELLSETWithSize (r, ty) = (fn _ => "CELLSET"
                                     ) (r, ty)
   fun showGP r = showGPWithSize (r, 64)
   fun showFP r = showFPWithSize (r, 64)
   fun showCC r = showCCWithSize (r, 64)
   fun showMEM r = showMEMWithSize (r, 8)
   fun showCTRL r = showCTRLWithSize (r, 0)
   fun showCELLSET r = showCELLSETWithSize (r, 0)
   val CELLSET = CellsBasis.newCellKind {name="CELLSET", nickname="cellset"}
   structure MyCellsCommon = CellsCommon
      (exception Cells = AlphaCells
       val firstPseudo = 256
       val desc_GP = CellsInternal.DESC {low=0, high=31, kind=CellsBasis.GP, 
              defaultValues=[(31, 0)], zeroReg=SOME 31, toString=showGP, toStringWithSize=showGPWithSize, 
              counter=ref 0, physicalRegs=ref CellsInternal.array0}
       and desc_FP = CellsInternal.DESC {low=32, high=63, kind=CellsBasis.FP, 
              defaultValues=[(63, 0)], zeroReg=SOME 31, toString=showFP, toStringWithSize=showFPWithSize, 
              counter=ref 0, physicalRegs=ref CellsInternal.array0}
       and desc_MEM = CellsInternal.DESC {low=64, high=63, kind=CellsBasis.MEM, 
              defaultValues=[], zeroReg=NONE, toString=showMEM, toStringWithSize=showMEMWithSize, 
              counter=ref 0, physicalRegs=ref CellsInternal.array0}
       and desc_CTRL = CellsInternal.DESC {low=64, high=63, kind=CellsBasis.CTRL, 
              defaultValues=[], zeroReg=NONE, toString=showCTRL, toStringWithSize=showCTRLWithSize, 
              counter=ref 0, physicalRegs=ref CellsInternal.array0}
       and desc_CELLSET = CellsInternal.DESC {low=64, high=63, kind=CELLSET, 
              defaultValues=[], zeroReg=NONE, toString=showCELLSET, toStringWithSize=showCELLSETWithSize, 
              counter=ref 0, physicalRegs=ref CellsInternal.array0}
       val cellKindDescs = [(CellsBasis.GP, desc_GP), (CellsBasis.FP, desc_FP), 
              (CellsBasis.CC, desc_GP), (CellsBasis.MEM, desc_MEM), (CellsBasis.CTRL, 
              desc_CTRL), (CELLSET, desc_CELLSET)]
      )

   open MyCellsCommon
   val addGP = CellSet.add
   and addFP = CellSet.add
   and addCC = CellSet.add
   and addMEM = CellSet.add
   and addCTRL = CellSet.add
   and addCELLSET = CellSet.add
   val RegGP = Reg GP
   and RegFP = Reg FP
   and RegCC = Reg CC
   and RegMEM = Reg MEM
   and RegCTRL = Reg CTRL
   and RegCELLSET = Reg CELLSET
   val stackptrR = RegGP 30
   val asmTmpR = RegGP 28
   val fasmTmp = RegGP 30
   val returnAddr = RegGP 26
   val r31 = RegGP 31
   val f31 = RegFP 31
end

