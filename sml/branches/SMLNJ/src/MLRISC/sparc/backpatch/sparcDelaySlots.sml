(*
 * This file was automatically generated by MDGen
 * from the machine description file "sparc/sparc.md".
 *)


functor SparcDelaySlots(structure I : SPARCINSTR
                        structure P : INSN_PROPERTIES
                           where I = I
                       ) : DELAY_SLOT_PROPERTIES =
struct
   structure I = I
   datatype delay_slot =
     D_NONE     
   | D_ERROR    
   | D_ALWAYS   
   | D_TAKEN    
   | D_FALLTHRU 
   
   fun error msg = MLRiscErrorMsg.error("SparcDelaySlots",msg)
   val delaySlotSize = 4

   fun delaySlot {instr=I.Bicc{b, a, label, nop}, backward} = {nop=nop, n=a andalso 
       (
        case b of
        I.BA => false
      | _ => true
       ), nOn=D_NONE, nOff=D_ALWAYS}
     | delaySlot {instr=I.FBfcc{b, a, label, nop}, backward} = {nop=nop, n=a, nOn=D_NONE, nOff=D_ALWAYS}
     | delaySlot {instr=I.JMP{r, i, labs, nop}, backward} = {nop=nop, n=false, nOn=D_ERROR, nOff=D_ALWAYS}
     | delaySlot {instr=I.JMPL{r, i, d, defs, uses, nop, mem}, backward} = {nop=nop, n=false, nOn=D_ERROR, nOff=D_ALWAYS}
     | delaySlot {instr=I.CALL{defs, uses, label, nop, mem}, backward} = {nop=nop, n=false, nOn=D_ERROR, nOff=D_ALWAYS}
     | delaySlot {instr=I.FCMP{cmp, r1, r2, nop}, backward} = {nop=nop, n=false, nOn=D_ERROR, nOff=D_ALWAYS}
     | delaySlot {instr=I.RET{leaf, nop}, backward} = {nop=nop, n=false, nOn=D_ERROR, nOff=D_ALWAYS}
     | delaySlot _ = {nop=true, n=false, nOn=D_ERROR, nOff=D_NONE}
   fun enableDelaySlot _ = error "enableDelaySlot"
   fun conflict _ = error "conflict"

   fun delaySlotCandidate {jmp, delaySlot=I.Bicc{b, a, label, nop}} = false
     | delaySlotCandidate {jmp, delaySlot=I.FBfcc{b, a, label, nop}} = false
     | delaySlotCandidate {jmp, delaySlot=I.JMP{r, i, labs, nop}} = false
     | delaySlotCandidate {jmp, delaySlot=I.JMPL{r, i, d, defs, uses, nop, mem}} = false
     | delaySlotCandidate {jmp, delaySlot=I.CALL{defs, uses, label, nop, mem}} = false
     | delaySlotCandidate {jmp, delaySlot=I.Ticc{t, cc, r, i}} = false
     | delaySlotCandidate {jmp, delaySlot=I.FCMP{cmp, r1, r2, nop}} = false
     | delaySlotCandidate {jmp, delaySlot=I.RET{leaf, nop}} = false
     | delaySlotCandidate _ = true
   fun setTarget _ = error "setTarget"
end

