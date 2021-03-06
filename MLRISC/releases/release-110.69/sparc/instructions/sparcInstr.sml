(*
 * WARNING: This file was automatically generated by MDLGen (v3.0)
 * from the machine description file "sparc/sparc.mdl".
 * DO NOT EDIT this file directly
 *)


signature SPARCINSTR =
sig
   structure C : SPARCCELLS
   structure CB : CELLS_BASIS = CellsBasis
   structure T : MLTREE
   structure Constant: CONSTANT
   structure Region : REGION
      sharing Constant = T.Constant
      sharing Region = T.Region
   datatype load =
     LDSB
   | LDSH
   | LDUB
   | LDUH
   | LD
   | LDX
   | LDD
   datatype store =
     STB
   | STH
   | ST
   | STX
   | STD
   datatype fload =
     LDF
   | LDDF
   | LDQF
   | LDFSR
   | LDXFSR
   datatype fstore =
     STF
   | STDF
   | STFSR
   datatype arith =
     AND
   | ANDCC
   | ANDN
   | ANDNCC
   | OR
   | ORCC
   | ORN
   | ORNCC
   | XOR
   | XORCC
   | XNOR
   | XNORCC
   | ADD
   | ADDCC
   | TADD
   | TADDCC
   | TADDTV
   | TADDTVCC
   | SUB
   | SUBCC
   | TSUB
   | TSUBCC
   | TSUBTV
   | TSUBTVCC
   | UMUL
   | UMULCC
   | SMUL
   | SMULCC
   | UDIV
   | UDIVCC
   | SDIV
   | SDIVCC
   | MULX
   | SDIVX
   | UDIVX
   datatype shift =
     SLL
   | SRL
   | SRA
   | SLLX
   | SRLX
   | SRAX
   datatype farith1 =
     FiTOs
   | FiTOd
   | FiTOq
   | FsTOi
   | FdTOi
   | FqTOi
   | FsTOd
   | FsTOq
   | FdTOs
   | FdTOq
   | FqTOs
   | FqTOd
   | FMOVs
   | FNEGs
   | FABSs
   | FMOVd
   | FNEGd
   | FABSd
   | FMOVq
   | FNEGq
   | FABSq
   | FSQRTs
   | FSQRTd
   | FSQRTq
   datatype farith2 =
     FADDs
   | FADDd
   | FADDq
   | FSUBs
   | FSUBd
   | FSUBq
   | FMULs
   | FMULd
   | FMULq
   | FsMULd
   | FdMULq
   | FDIVs
   | FDIVd
   | FDIVq
   datatype fcmp =
     FCMPs
   | FCMPd
   | FCMPq
   | FCMPEs
   | FCMPEd
   | FCMPEq
   datatype branch =
     BN
   | BE
   | BLE
   | BL
   | BLEU
   | BCS
   | BNEG
   | BVS
   | BA
   | BNE
   | BG
   | BGE
   | BGU
   | BCC
   | BPOS
   | BVC
   datatype rcond =
     RZ
   | RLEZ
   | RLZ
   | RNZ
   | RGZ
   | RGEZ
   datatype cc =
     ICC
   | XCC
   datatype prediction =
     PT
   | PN
   datatype fbranch =
     FBN
   | FBNE
   | FBLG
   | FBUL
   | FBL
   | FBUG
   | FBG
   | FBU
   | FBA
   | FBE
   | FBUE
   | FBGE
   | FBUGE
   | FBLE
   | FBULE
   | FBO
   datatype ea =
     Direct of CellsBasis.cell
   | FDirect of CellsBasis.cell
   | Displace of {base:CellsBasis.cell, disp:T.labexp, mem:Region.region}
   datatype fsize =
     S
   | D
   | Q
   datatype operand =
     REG of CellsBasis.cell
   | IMMED of int
   | LAB of T.labexp
   | LO of T.labexp
   | HI of T.labexp
   type addressing_mode = CellsBasis.cell * operand
   datatype instr =
     LOAD of {l:load, d:CellsBasis.cell, r:CellsBasis.cell, i:operand, mem:Region.region}
   | STORE of {s:store, d:CellsBasis.cell, r:CellsBasis.cell, i:operand, mem:Region.region}
   | FLOAD of {l:fload, r:CellsBasis.cell, i:operand, d:CellsBasis.cell, mem:Region.region}
   | FSTORE of {s:fstore, d:CellsBasis.cell, r:CellsBasis.cell, i:operand, 
        mem:Region.region}
   | UNIMP of {const22:int}
   | SETHI of {i:int, d:CellsBasis.cell}
   | ARITH of {a:arith, r:CellsBasis.cell, i:operand, d:CellsBasis.cell}
   | SHIFT of {s:shift, r:CellsBasis.cell, i:operand, d:CellsBasis.cell}
   | MOVicc of {b:branch, i:operand, d:CellsBasis.cell}
   | MOVfcc of {b:fbranch, i:operand, d:CellsBasis.cell}
   | MOVR of {rcond:rcond, r:CellsBasis.cell, i:operand, d:CellsBasis.cell}
   | FMOVicc of {sz:fsize, b:branch, r:CellsBasis.cell, d:CellsBasis.cell}
   | FMOVfcc of {sz:fsize, b:fbranch, r:CellsBasis.cell, d:CellsBasis.cell}
   | Bicc of {b:branch, a:bool, label:Label.label, nop:bool}
   | FBfcc of {b:fbranch, a:bool, label:Label.label, nop:bool}
   | BR of {rcond:rcond, p:prediction, r:CellsBasis.cell, a:bool, label:Label.label, 
        nop:bool}
   | BP of {b:branch, p:prediction, cc:cc, a:bool, label:Label.label, nop:bool}
   | JMP of {r:CellsBasis.cell, i:operand, labs:Label.label list, nop:bool}
   | JMPL of {r:CellsBasis.cell, i:operand, d:CellsBasis.cell, defs:C.cellset, 
        uses:C.cellset, cutsTo:Label.label list, nop:bool, mem:Region.region}
   | CALL of {defs:C.cellset, uses:C.cellset, label:Label.label, cutsTo:Label.label list, 
        nop:bool, mem:Region.region}
   | Ticc of {t:branch, cc:cc, r:CellsBasis.cell, i:operand}
   | FPop1 of {a:farith1, r:CellsBasis.cell, d:CellsBasis.cell}
   | FPop2 of {a:farith2, r1:CellsBasis.cell, r2:CellsBasis.cell, d:CellsBasis.cell}
   | FCMP of {cmp:fcmp, r1:CellsBasis.cell, r2:CellsBasis.cell, nop:bool}
   | SAVE of {r:CellsBasis.cell, i:operand, d:CellsBasis.cell}
   | RESTORE of {r:CellsBasis.cell, i:operand, d:CellsBasis.cell}
   | RDY of {d:CellsBasis.cell}
   | WRY of {r:CellsBasis.cell, i:operand}
   | RET of {leaf:bool, nop:bool}
   | SOURCE of {}
   | SINK of {}
   | PHI of {}
   and instruction =
     LIVE of {regs: C.cellset, spilled: C.cellset}
   | KILL of {regs: C.cellset, spilled: C.cellset}
   | COPY of {k: CellsBasis.cellkind, 
              sz: int,          (* in bits *)
              dst: CellsBasis.cell list,
              src: CellsBasis.cell list,
              tmp: ea option (* NONE if |dst| = {src| = 1 *)}
   | ANNOTATION of {i:instruction, a:Annotations.annotation}
   | INSTR of instr
   val load : {l:load, d:CellsBasis.cell, r:CellsBasis.cell, i:operand, mem:Region.region} -> instruction
   val store : {s:store, d:CellsBasis.cell, r:CellsBasis.cell, i:operand, mem:Region.region} -> instruction
   val fload : {l:fload, r:CellsBasis.cell, i:operand, d:CellsBasis.cell, mem:Region.region} -> instruction
   val fstore : {s:fstore, d:CellsBasis.cell, r:CellsBasis.cell, i:operand, 
      mem:Region.region} -> instruction
   val unimp : {const22:int} -> instruction
   val sethi : {i:int, d:CellsBasis.cell} -> instruction
   val arith : {a:arith, r:CellsBasis.cell, i:operand, d:CellsBasis.cell} -> instruction
   val shift : {s:shift, r:CellsBasis.cell, i:operand, d:CellsBasis.cell} -> instruction
   val movicc : {b:branch, i:operand, d:CellsBasis.cell} -> instruction
   val movfcc : {b:fbranch, i:operand, d:CellsBasis.cell} -> instruction
   val movr : {rcond:rcond, r:CellsBasis.cell, i:operand, d:CellsBasis.cell} -> instruction
   val fmovicc : {sz:fsize, b:branch, r:CellsBasis.cell, d:CellsBasis.cell} -> instruction
   val fmovfcc : {sz:fsize, b:fbranch, r:CellsBasis.cell, d:CellsBasis.cell} -> instruction
   val bicc : {b:branch, a:bool, label:Label.label, nop:bool} -> instruction
   val fbfcc : {b:fbranch, a:bool, label:Label.label, nop:bool} -> instruction
   val br : {rcond:rcond, p:prediction, r:CellsBasis.cell, a:bool, label:Label.label, 
      nop:bool} -> instruction
   val bp : {b:branch, p:prediction, cc:cc, a:bool, label:Label.label, nop:bool} -> instruction
   val jmp : {r:CellsBasis.cell, i:operand, labs:Label.label list, nop:bool} -> instruction
   val jmpl : {r:CellsBasis.cell, i:operand, d:CellsBasis.cell, defs:C.cellset, 
      uses:C.cellset, cutsTo:Label.label list, nop:bool, mem:Region.region} -> instruction
   val call : {defs:C.cellset, uses:C.cellset, label:Label.label, cutsTo:Label.label list, 
      nop:bool, mem:Region.region} -> instruction
   val ticc : {t:branch, cc:cc, r:CellsBasis.cell, i:operand} -> instruction
   val fpop1 : {a:farith1, r:CellsBasis.cell, d:CellsBasis.cell} -> instruction
   val fpop2 : {a:farith2, r1:CellsBasis.cell, r2:CellsBasis.cell, d:CellsBasis.cell} -> instruction
   val fcmp : {cmp:fcmp, r1:CellsBasis.cell, r2:CellsBasis.cell, nop:bool} -> instruction
   val save : {r:CellsBasis.cell, i:operand, d:CellsBasis.cell} -> instruction
   val restore : {r:CellsBasis.cell, i:operand, d:CellsBasis.cell} -> instruction
   val rdy : {d:CellsBasis.cell} -> instruction
   val wry : {r:CellsBasis.cell, i:operand} -> instruction
   val ret : {leaf:bool, nop:bool} -> instruction
   val source : {} -> instruction
   val sink : {} -> instruction
   val phi : {} -> instruction
end

functor SparcInstr(T: MLTREE
                  ) : SPARCINSTR =
struct
   structure C = SparcCells
   structure CB = CellsBasis
   structure T = T
   structure Region = T.Region
   structure Constant = T.Constant
   datatype load =
     LDSB
   | LDSH
   | LDUB
   | LDUH
   | LD
   | LDX
   | LDD
   datatype store =
     STB
   | STH
   | ST
   | STX
   | STD
   datatype fload =
     LDF
   | LDDF
   | LDQF
   | LDFSR
   | LDXFSR
   datatype fstore =
     STF
   | STDF
   | STFSR
   datatype arith =
     AND
   | ANDCC
   | ANDN
   | ANDNCC
   | OR
   | ORCC
   | ORN
   | ORNCC
   | XOR
   | XORCC
   | XNOR
   | XNORCC
   | ADD
   | ADDCC
   | TADD
   | TADDCC
   | TADDTV
   | TADDTVCC
   | SUB
   | SUBCC
   | TSUB
   | TSUBCC
   | TSUBTV
   | TSUBTVCC
   | UMUL
   | UMULCC
   | SMUL
   | SMULCC
   | UDIV
   | UDIVCC
   | SDIV
   | SDIVCC
   | MULX
   | SDIVX
   | UDIVX
   datatype shift =
     SLL
   | SRL
   | SRA
   | SLLX
   | SRLX
   | SRAX
   datatype farith1 =
     FiTOs
   | FiTOd
   | FiTOq
   | FsTOi
   | FdTOi
   | FqTOi
   | FsTOd
   | FsTOq
   | FdTOs
   | FdTOq
   | FqTOs
   | FqTOd
   | FMOVs
   | FNEGs
   | FABSs
   | FMOVd
   | FNEGd
   | FABSd
   | FMOVq
   | FNEGq
   | FABSq
   | FSQRTs
   | FSQRTd
   | FSQRTq
   datatype farith2 =
     FADDs
   | FADDd
   | FADDq
   | FSUBs
   | FSUBd
   | FSUBq
   | FMULs
   | FMULd
   | FMULq
   | FsMULd
   | FdMULq
   | FDIVs
   | FDIVd
   | FDIVq
   datatype fcmp =
     FCMPs
   | FCMPd
   | FCMPq
   | FCMPEs
   | FCMPEd
   | FCMPEq
   datatype branch =
     BN
   | BE
   | BLE
   | BL
   | BLEU
   | BCS
   | BNEG
   | BVS
   | BA
   | BNE
   | BG
   | BGE
   | BGU
   | BCC
   | BPOS
   | BVC
   datatype rcond =
     RZ
   | RLEZ
   | RLZ
   | RNZ
   | RGZ
   | RGEZ
   datatype cc =
     ICC
   | XCC
   datatype prediction =
     PT
   | PN
   datatype fbranch =
     FBN
   | FBNE
   | FBLG
   | FBUL
   | FBL
   | FBUG
   | FBG
   | FBU
   | FBA
   | FBE
   | FBUE
   | FBGE
   | FBUGE
   | FBLE
   | FBULE
   | FBO
   datatype ea =
     Direct of CellsBasis.cell
   | FDirect of CellsBasis.cell
   | Displace of {base:CellsBasis.cell, disp:T.labexp, mem:Region.region}
   datatype fsize =
     S
   | D
   | Q
   datatype operand =
     REG of CellsBasis.cell
   | IMMED of int
   | LAB of T.labexp
   | LO of T.labexp
   | HI of T.labexp
   type addressing_mode = CellsBasis.cell * operand
   datatype instr =
     LOAD of {l:load, d:CellsBasis.cell, r:CellsBasis.cell, i:operand, mem:Region.region}
   | STORE of {s:store, d:CellsBasis.cell, r:CellsBasis.cell, i:operand, mem:Region.region}
   | FLOAD of {l:fload, r:CellsBasis.cell, i:operand, d:CellsBasis.cell, mem:Region.region}
   | FSTORE of {s:fstore, d:CellsBasis.cell, r:CellsBasis.cell, i:operand, 
        mem:Region.region}
   | UNIMP of {const22:int}
   | SETHI of {i:int, d:CellsBasis.cell}
   | ARITH of {a:arith, r:CellsBasis.cell, i:operand, d:CellsBasis.cell}
   | SHIFT of {s:shift, r:CellsBasis.cell, i:operand, d:CellsBasis.cell}
   | MOVicc of {b:branch, i:operand, d:CellsBasis.cell}
   | MOVfcc of {b:fbranch, i:operand, d:CellsBasis.cell}
   | MOVR of {rcond:rcond, r:CellsBasis.cell, i:operand, d:CellsBasis.cell}
   | FMOVicc of {sz:fsize, b:branch, r:CellsBasis.cell, d:CellsBasis.cell}
   | FMOVfcc of {sz:fsize, b:fbranch, r:CellsBasis.cell, d:CellsBasis.cell}
   | Bicc of {b:branch, a:bool, label:Label.label, nop:bool}
   | FBfcc of {b:fbranch, a:bool, label:Label.label, nop:bool}
   | BR of {rcond:rcond, p:prediction, r:CellsBasis.cell, a:bool, label:Label.label, 
        nop:bool}
   | BP of {b:branch, p:prediction, cc:cc, a:bool, label:Label.label, nop:bool}
   | JMP of {r:CellsBasis.cell, i:operand, labs:Label.label list, nop:bool}
   | JMPL of {r:CellsBasis.cell, i:operand, d:CellsBasis.cell, defs:C.cellset, 
        uses:C.cellset, cutsTo:Label.label list, nop:bool, mem:Region.region}
   | CALL of {defs:C.cellset, uses:C.cellset, label:Label.label, cutsTo:Label.label list, 
        nop:bool, mem:Region.region}
   | Ticc of {t:branch, cc:cc, r:CellsBasis.cell, i:operand}
   | FPop1 of {a:farith1, r:CellsBasis.cell, d:CellsBasis.cell}
   | FPop2 of {a:farith2, r1:CellsBasis.cell, r2:CellsBasis.cell, d:CellsBasis.cell}
   | FCMP of {cmp:fcmp, r1:CellsBasis.cell, r2:CellsBasis.cell, nop:bool}
   | SAVE of {r:CellsBasis.cell, i:operand, d:CellsBasis.cell}
   | RESTORE of {r:CellsBasis.cell, i:operand, d:CellsBasis.cell}
   | RDY of {d:CellsBasis.cell}
   | WRY of {r:CellsBasis.cell, i:operand}
   | RET of {leaf:bool, nop:bool}
   | SOURCE of {}
   | SINK of {}
   | PHI of {}
   and instruction =
     LIVE of {regs: C.cellset, spilled: C.cellset}
   | KILL of {regs: C.cellset, spilled: C.cellset}
   | COPY of {k: CellsBasis.cellkind, 
              sz: int,          (* in bits *)
              dst: CellsBasis.cell list,
              src: CellsBasis.cell list,
              tmp: ea option (* NONE if |dst| = {src| = 1 *)}
   | ANNOTATION of {i:instruction, a:Annotations.annotation}
   | INSTR of instr
   val load = INSTR o LOAD
   and store = INSTR o STORE
   and fload = INSTR o FLOAD
   and fstore = INSTR o FSTORE
   and unimp = INSTR o UNIMP
   and sethi = INSTR o SETHI
   and arith = INSTR o ARITH
   and shift = INSTR o SHIFT
   and movicc = INSTR o MOVicc
   and movfcc = INSTR o MOVfcc
   and movr = INSTR o MOVR
   and fmovicc = INSTR o FMOVicc
   and fmovfcc = INSTR o FMOVfcc
   and bicc = INSTR o Bicc
   and fbfcc = INSTR o FBfcc
   and br = INSTR o BR
   and bp = INSTR o BP
   and jmp = INSTR o JMP
   and jmpl = INSTR o JMPL
   and call = INSTR o CALL
   and ticc = INSTR o Ticc
   and fpop1 = INSTR o FPop1
   and fpop2 = INSTR o FPop2
   and fcmp = INSTR o FCMP
   and save = INSTR o SAVE
   and restore = INSTR o RESTORE
   and rdy = INSTR o RDY
   and wry = INSTR o WRY
   and ret = INSTR o RET
   and source = INSTR o SOURCE
   and sink = INSTR o SINK
   and phi = INSTR o PHI
end

