
(*
 * This file was automatically generated by ml-idl
 * (Fri Jul  6 15:20:40 2001)
 *)

structure SMLBasis : SML_BASIS = struct
structure C = Unsafe.CInterface
type idl_string = String.string
type cfun_idl_string = String.string
type ML_word8vec_t = Word8Vector.vector
type cfun_ML_word8vec_t = Word8Vector.vector
type ML_word8vec_opt_t = Word8Vector.vector option
type cfun_ML_word8vec_opt_t = Word8Vector.vector option
type ML_word8arr_t = Word8Array.array
type cfun_ML_word8arr_t = Word8Array.array
type ML_charvec_t = CharVector.vector
type cfun_ML_charvec_t = CharVector.vector
type ML_charvec_opt_t = CharVector.vector option
type cfun_ML_charvec_opt_t = CharVector.vector option
type ML_chararr_t = CharArray.array
type cfun_ML_chararr_t = CharArray.array
type ML_unit_t = unit
type cfun_ML_unit_t = unit
type ML_bool_t = bool
type cfun_ML_bool_t = bool
type ML_int_t = int
type cfun_ML_int_t = int
type ML_int32_t = Int32.int
type cfun_ML_int32_t = Int32.int
type ML_string_t = string
type cfun_ML_string_t = string
type ML_string_opt_t = string option
type cfun_ML_string_opt_t = string option
type ML_string_list_t = string list
type cfun_ML_string_list_t = string list
type ML_int_opt_t = int option
type cfun_ML_int_opt_t = int option
type ML_iodesc_t = word (* Unsafe.Object.object *)
type cfun_ML_iodesc_t = word (* Unsafe.Object.object *)
type ML_directory_t = Unsafe.Object.object
type cfun_ML_directory_t = Unsafe.Object.object
type Time_t = {seconds:Int32.int,uSeconds:Int32.int}
type cfun_Time_t = (Int32.int * Int32.int)
type ML_polldesc_list_t = (word * word (* Unsafe.Object.object *)) list
type cfun_ML_polldesc_list_t = (word * word (* Unsafe.Object.object *)) list
type ML_pollinfo_list_t = (word * word (* Unsafe.Object.object *)) list
type cfun_ML_pollinfo_list_t = (word * word (* Unsafe.Object.object *)) list
type Date_t = {tm_sec:Int32.int,tm_min:Int32.int,tm_hour:Int32.int,tm_mday:Int32.int,tm_mon:Int32.int,tm_year:Int32.int,tm_wday:Int32.int,tm_yday:Int32.int,tm_isdst:Int32.int}
type cfun_Date_t = (Int32.int * Int32.int * Int32.int * Int32.int * Int32.int * Int32.int * Int32.int * Int32.int * Int32.int)
val TO_NEAREST = 0 : Int.int
val TO_NEGINF = 1 : Int.int
val TO_POSINF = 2 : Int.int
val TO_ZERO = 3 : Int.int
val cfun_getRoundingMode : unit -> Int.int = C.c_function "SMLBasis" "getRoundingMode"
fun getRoundingMode() = let
  val (m_result) = cfun_getRoundingMode ()
  val result = (fn (x) => x)(m_result)
in
  (result)
end
val cfun_setRoundingMode : Int.int -> unit = C.c_function "SMLBasis" "setRoundingMode"
fun setRoundingMode(mode) = let
  val m_mode = (fn (x) => x)(mode)
  val () = cfun_setRoundingMode (m_mode)
  val _ = (fn _ => ()) (m_mode)
in
  ()
end
val OPEN_RD = 1 : Int.int
val OPEN_WR = 2 : Int.int
val OPEN_RDWR = 3 : Int.int
val OPEN_CREATE = 4 : Int.int
val OPEN_TRUNC = 8 : Int.int
val OPEN_APPEND = 16 : Int.int
val cfun_openFile : (cfun_ML_string_t * Int.int) -> cfun_ML_iodesc_t = C.c_function "SMLBasis" "openFile"
fun openFile(s,flags) = let
  val m_s = (fn x => x)(s)
  val m_flags = (fn (x) => x)(flags)
  val (m_result) = cfun_openFile (m_s,m_flags)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_s)
  val _ = (fn _ => ()) (m_flags)
in
  (result)
end
val cfun_closeFile : cfun_ML_iodesc_t -> unit = C.c_function "SMLBasis" "closeFile"
fun closeFile(iod) = let
  val m_iod = (fn x => x)(iod)
  val () = cfun_closeFile (m_iod)
  val _ = (fn _ => ()) (m_iod)
in
  ()
end
val cfun_cmpIODesc : (cfun_ML_iodesc_t * cfun_ML_iodesc_t) -> Int.int = C.c_function "SMLBasis" "cmpIODesc"
fun cmpIODesc(iod1,iod2) = let
  val m_iod1 = (fn x => x)(iod1)
  val m_iod2 = (fn x => x)(iod2)
  val (m_result) = cfun_cmpIODesc (m_iod1,m_iod2)
  val result = (fn (x) => x)(m_result)
  val _ = (fn _ => ()) (m_iod1)
  val _ = (fn _ => ()) (m_iod2)
in
  (result)
end
val cfun_readTextVec : (Bool.bool * cfun_ML_iodesc_t * Int.int) -> cfun_ML_charvec_opt_t = C.c_function "SMLBasis" "readTextVec"
fun readTextVec(noblock,iod,nbytes) = let
  val m_noblock = (fn (x) => x)(noblock)
  val m_iod = (fn x => x)(iod)
  val m_nbytes = (fn (x) => x)(nbytes)
  val (m_result) = cfun_readTextVec (m_noblock,m_iod,m_nbytes)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_noblock)
  val _ = (fn _ => ()) (m_iod)
  val _ = (fn _ => ()) (m_nbytes)
in
  (result)
end
val cfun_readTextArr : (Bool.bool * cfun_ML_iodesc_t * cfun_ML_chararr_t * Int.int * Int.int) -> cfun_ML_int_t = C.c_function "SMLBasis" "readTextArr"
fun readTextArr(noblock,iod,arr,nbytes,offset) = let
  val m_noblock = (fn (x) => x)(noblock)
  val m_iod = (fn x => x)(iod)
  val m_arr = (fn x => x)(arr)
  val m_nbytes = (fn (x) => x)(nbytes)
  val m_offset = (fn (x) => x)(offset)
  val (m_result) = cfun_readTextArr (m_noblock,m_iod,m_arr,m_nbytes,m_offset)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_noblock)
  val _ = (fn _ => ()) (m_iod)
  val _ = (fn _ => ()) (m_arr)
  val _ = (fn _ => ()) (m_nbytes)
  val _ = (fn _ => ()) (m_offset)
in
  (result)
end
val cfun_writeTextVec : (Bool.bool * cfun_ML_iodesc_t * cfun_ML_charvec_t * Int.int * Int.int) -> cfun_ML_int_t = C.c_function "SMLBasis" "writeTextVec"
fun writeTextVec(noblock,iod,buf,offset,nbytes) = let
  val m_noblock = (fn (x) => x)(noblock)
  val m_iod = (fn x => x)(iod)
  val m_buf = (fn x => x)(buf)
  val m_offset = (fn (x) => x)(offset)
  val m_nbytes = (fn (x) => x)(nbytes)
  val (m_result) = cfun_writeTextVec (m_noblock,m_iod,m_buf,m_offset,m_nbytes)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_noblock)
  val _ = (fn _ => ()) (m_iod)
  val _ = (fn _ => ()) (m_buf)
  val _ = (fn _ => ()) (m_offset)
  val _ = (fn _ => ()) (m_nbytes)
in
  (result)
end
val cfun_writeTextArr : (Bool.bool * cfun_ML_iodesc_t * cfun_ML_chararr_t * Int.int * Int.int) -> cfun_ML_int_t = C.c_function "SMLBasis" "writeTextArr"
fun writeTextArr(noblock,iod,buf,offset,nbytes) = let
  val m_noblock = (fn (x) => x)(noblock)
  val m_iod = (fn x => x)(iod)
  val m_buf = (fn x => x)(buf)
  val m_offset = (fn (x) => x)(offset)
  val m_nbytes = (fn (x) => x)(nbytes)
  val (m_result) = cfun_writeTextArr (m_noblock,m_iod,m_buf,m_offset,m_nbytes)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_noblock)
  val _ = (fn _ => ()) (m_iod)
  val _ = (fn _ => ()) (m_buf)
  val _ = (fn _ => ()) (m_offset)
  val _ = (fn _ => ()) (m_nbytes)
in
  (result)
end
val cfun_readBinVec : (Bool.bool * cfun_ML_iodesc_t * Int.int) -> cfun_ML_word8vec_opt_t = C.c_function "SMLBasis" "readBinVec"
fun readBinVec(noblock,iod,nbytes) = let
  val m_noblock = (fn (x) => x)(noblock)
  val m_iod = (fn x => x)(iod)
  val m_nbytes = (fn (x) => x)(nbytes)
  val (m_result) = cfun_readBinVec (m_noblock,m_iod,m_nbytes)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_noblock)
  val _ = (fn _ => ()) (m_iod)
  val _ = (fn _ => ()) (m_nbytes)
in
  (result)
end
val cfun_readBinArr : (Bool.bool * cfun_ML_iodesc_t * cfun_ML_word8arr_t * Int.int * Int.int) -> cfun_ML_int_t = C.c_function "SMLBasis" "readBinArr"
fun readBinArr(noblock,iod,arr,nbytes,offset) = let
  val m_noblock = (fn (x) => x)(noblock)
  val m_iod = (fn x => x)(iod)
  val m_arr = (fn x => x)(arr)
  val m_nbytes = (fn (x) => x)(nbytes)
  val m_offset = (fn (x) => x)(offset)
  val (m_result) = cfun_readBinArr (m_noblock,m_iod,m_arr,m_nbytes,m_offset)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_noblock)
  val _ = (fn _ => ()) (m_iod)
  val _ = (fn _ => ()) (m_arr)
  val _ = (fn _ => ()) (m_nbytes)
  val _ = (fn _ => ()) (m_offset)
in
  (result)
end
val cfun_writeBinVec : (Bool.bool * cfun_ML_iodesc_t * cfun_ML_word8vec_t * Int.int * Int.int) -> cfun_ML_int_t = C.c_function "SMLBasis" "writeBinVec"
fun writeBinVec(noblock,iod,buf,offset,nbytes) = let
  val m_noblock = (fn (x) => x)(noblock)
  val m_iod = (fn x => x)(iod)
  val m_buf = (fn x => x)(buf)
  val m_offset = (fn (x) => x)(offset)
  val m_nbytes = (fn (x) => x)(nbytes)
  val (m_result) = cfun_writeBinVec (m_noblock,m_iod,m_buf,m_offset,m_nbytes)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_noblock)
  val _ = (fn _ => ()) (m_iod)
  val _ = (fn _ => ()) (m_buf)
  val _ = (fn _ => ()) (m_offset)
  val _ = (fn _ => ()) (m_nbytes)
in
  (result)
end
val cfun_writeBinArr : (Bool.bool * cfun_ML_iodesc_t * cfun_ML_word8arr_t * Int.int * Int.int) -> cfun_ML_int_t = C.c_function "SMLBasis" "writeBinArr"
fun writeBinArr(noblock,iod,buf,offset,nbytes) = let
  val m_noblock = (fn (x) => x)(noblock)
  val m_iod = (fn x => x)(iod)
  val m_buf = (fn x => x)(buf)
  val m_offset = (fn (x) => x)(offset)
  val m_nbytes = (fn (x) => x)(nbytes)
  val (m_result) = cfun_writeBinArr (m_noblock,m_iod,m_buf,m_offset,m_nbytes)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_noblock)
  val _ = (fn _ => ()) (m_iod)
  val _ = (fn _ => ()) (m_buf)
  val _ = (fn _ => ()) (m_offset)
  val _ = (fn _ => ()) (m_nbytes)
in
  (result)
end
val SET_POS_BEGIN = 0 : Int.int
val SET_POS_CUR = 1 : Int.int
val SET_POS_END = 2 : Int.int
val cfun_getPos : cfun_ML_iodesc_t -> cfun_ML_int32_t = C.c_function "SMLBasis" "getPos"
fun getPos(iod) = let
  val m_iod = (fn x => x)(iod)
  val (m_result) = cfun_getPos (m_iod)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_iod)
in
  (result)
end
val cfun_setPos : (cfun_ML_iodesc_t * cfun_ML_int32_t * Int.int) -> cfun_ML_unit_t = C.c_function "SMLBasis" "setPos"
fun setPos(iod,offset,whence) = let
  val m_iod = (fn x => x)(iod)
  val m_offset = (fn x => x)(offset)
  val m_whence = (fn (x) => x)(whence)
  val (m_result) = cfun_setPos (m_iod,m_offset,m_whence)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_iod)
  val _ = (fn _ => ()) (m_offset)
  val _ = (fn _ => ()) (m_whence)
in
  (result)
end
val cfun_getStdIn : unit -> cfun_ML_iodesc_t = C.c_function "SMLBasis" "getStdIn"
fun getStdIn() = let
  val (m_result) = cfun_getStdIn ()
  val result = (fn x => x)(m_result)
in
  (result)
end
val cfun_getStdOut : unit -> cfun_ML_iodesc_t = C.c_function "SMLBasis" "getStdOut"
fun getStdOut() = let
  val (m_result) = cfun_getStdOut ()
  val result = (fn x => x)(m_result)
in
  (result)
end
val cfun_getStdErr : unit -> cfun_ML_iodesc_t = C.c_function "SMLBasis" "getStdErr"
fun getStdErr() = let
  val (m_result) = cfun_getStdErr ()
  val result = (fn x => x)(m_result)
in
  (result)
end
val cfun_errorName : Int32.int -> cfun_ML_string_t = C.c_function "SMLBasis" "errorName"
fun errorName(err) = let
  val m_err = (fn (x) => x)(err)
  val (m_result) = cfun_errorName (m_err)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_err)
in
  (result)
end
val cfun_errorMessage : Int32.int -> cfun_ML_string_t = C.c_function "SMLBasis" "errorMessage"
fun errorMessage(err) = let
  val m_err = (fn (x) => x)(err)
  val (m_result) = cfun_errorMessage (m_err)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_err)
in
  (result)
end
val cfun_syserror : cfun_idl_string -> cfun_ML_int_opt_t = C.c_function "SMLBasis" "syserror"
fun syserror(errName) = let
  val m_errName = (fn (x) => x)(errName)
  val (m_result) = cfun_syserror (m_errName)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_errName)
in
  (result)
end
val cfun_osSystem : cfun_idl_string -> cfun_ML_int_t = C.c_function "SMLBasis" "osSystem"
fun osSystem(name) = let
  val m_name = (fn (x) => x)(name)
  val (m_result) = cfun_osSystem (m_name)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_name)
in
  (result)
end
val cfun_exit : Int.int -> unit = C.c_function "SMLBasis" "exit"
fun exit(sts) = let
  val m_sts = (fn (x) => x)(sts)
  val () = cfun_exit (m_sts)
  val _ = (fn _ => ()) (m_sts)
in
  ()
end
val cfun_getEnv : cfun_idl_string -> cfun_ML_string_opt_t = C.c_function "SMLBasis" "getEnv"
fun getEnv(ss) = let
  val m_ss = (fn (x) => x)(ss)
  val (m_result) = cfun_getEnv (m_ss)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_ss)
in
  (result)
end
val cfun_osSleep : cfun_Time_t -> unit = C.c_function "SMLBasis" "osSleep"
fun osSleep(t) = let
  val m_t = ((fn (x) => x) o ((fn {seconds,uSeconds} => (seconds,uSeconds)) o (fn ({seconds,uSeconds}) => let   val m_seconds = (fn (x) => x)(seconds)  val m_uSeconds = (fn (x) => x)(uSeconds) in {seconds = m_seconds,uSeconds = m_uSeconds} end)))(t)
  val () = cfun_osSleep (m_t)
  val _ = (fn _ => ()) (m_t)
in
  ()
end
val cfun_openDir : cfun_idl_string -> cfun_ML_directory_t = C.c_function "SMLBasis" "openDir"
fun openDir(path) = let
  val m_path = (fn (x) => x)(path)
  val (m_result) = cfun_openDir (m_path)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_path)
in
  (result)
end
val cfun_readDir : cfun_ML_directory_t -> cfun_ML_string_opt_t = C.c_function "SMLBasis" "readDir"
fun readDir(dir) = let
  val m_dir = (fn x => x)(dir)
  val (m_result) = cfun_readDir (m_dir)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_dir)
in
  (result)
end
val cfun_rewindDir : cfun_ML_directory_t -> cfun_ML_unit_t = C.c_function "SMLBasis" "rewindDir"
fun rewindDir(dir) = let
  val m_dir = (fn x => x)(dir)
  val (m_result) = cfun_rewindDir (m_dir)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_dir)
in
  (result)
end
val cfun_closeDir : cfun_ML_directory_t -> cfun_ML_unit_t = C.c_function "SMLBasis" "closeDir"
fun closeDir(dir) = let
  val m_dir = (fn x => x)(dir)
  val (m_result) = cfun_closeDir (m_dir)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_dir)
in
  (result)
end
val cfun_chDir : cfun_idl_string -> cfun_ML_unit_t = C.c_function "SMLBasis" "chDir"
fun chDir(path) = let
  val m_path = (fn (x) => x)(path)
  val (m_result) = cfun_chDir (m_path)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_path)
in
  (result)
end
val cfun_getDir : unit -> cfun_ML_string_t = C.c_function "SMLBasis" "getDir"
fun getDir() = let
  val (m_result) = cfun_getDir ()
  val result = (fn x => x)(m_result)
in
  (result)
end
val cfun_mkDir : cfun_idl_string -> cfun_ML_unit_t = C.c_function "SMLBasis" "mkDir"
fun mkDir(path) = let
  val m_path = (fn (x) => x)(path)
  val (m_result) = cfun_mkDir (m_path)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_path)
in
  (result)
end
val cfun_rmDir : cfun_idl_string -> cfun_ML_unit_t = C.c_function "SMLBasis" "rmDir"
fun rmDir(path) = let
  val m_path = (fn (x) => x)(path)
  val (m_result) = cfun_rmDir (m_path)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_path)
in
  (result)
end
val cfun_isReg : cfun_idl_string -> cfun_ML_bool_t = C.c_function "SMLBasis" "isReg"
fun isReg(path) = let
  val m_path = (fn (x) => x)(path)
  val (m_result) = cfun_isReg (m_path)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_path)
in
  (result)
end
val cfun_isDir : cfun_idl_string -> cfun_ML_bool_t = C.c_function "SMLBasis" "isDir"
fun isDir(path) = let
  val m_path = (fn (x) => x)(path)
  val (m_result) = cfun_isDir (m_path)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_path)
in
  (result)
end
val cfun_isLink : cfun_idl_string -> cfun_ML_bool_t = C.c_function "SMLBasis" "isLink"
fun isLink(path) = let
  val m_path = (fn (x) => x)(path)
  val (m_result) = cfun_isLink (m_path)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_path)
in
  (result)
end
val cfun_readLink : cfun_idl_string -> cfun_ML_string_t = C.c_function "SMLBasis" "readLink"
fun readLink(path) = let
  val m_path = (fn (x) => x)(path)
  val (m_result) = cfun_readLink (m_path)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_path)
in
  (result)
end
val cfun_fileSize : cfun_idl_string -> cfun_ML_int32_t = C.c_function "SMLBasis" "fileSize"
fun fileSize(path) = let
  val m_path = (fn (x) => x)(path)
  val (m_result) = cfun_fileSize (m_path)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_path)
in
  (result)
end
val cfun_modTime : cfun_idl_string -> cfun_ML_int32_t = C.c_function "SMLBasis" "modTime"
fun modTime(path) = let
  val m_path = (fn (x) => x)(path)
  val (m_result) = cfun_modTime (m_path)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_path)
in
  (result)
end
val cfun_setTime : (cfun_idl_string * cfun_Time_t option) -> cfun_ML_unit_t = C.c_function "SMLBasis" "setTime"
fun setTime(path,t) = let
  val m_path = (fn (x) => x)(path)
  val m_t = ((fn (x) => x) o  (fn NONE => NONE | SOME (v) => SOME (((fn (x) => x) o ((fn {seconds,uSeconds} => (seconds,uSeconds)) o (fn ({seconds,uSeconds}) => let   val m_seconds = (fn (x) => x)(seconds)  val m_uSeconds = (fn (x) => x)(uSeconds) in {seconds = m_seconds,uSeconds = m_uSeconds} end))) (v))))(t)
  val (m_result) = cfun_setTime (m_path,m_t)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_path)
  val _ = (fn _ => ()) (m_t)
in
  (result)
end
val cfun_removeFile : cfun_idl_string -> cfun_ML_unit_t = C.c_function "SMLBasis" "removeFile"
fun removeFile(path) = let
  val m_path = (fn (x) => x)(path)
  val (m_result) = cfun_removeFile (m_path)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_path)
in
  (result)
end
val cfun_renameFile : (cfun_idl_string * cfun_idl_string) -> cfun_ML_unit_t = C.c_function "SMLBasis" "renameFile"
fun renameFile(old,new) = let
  val m_old = (fn (x) => x)(old)
  val m_new = (fn (x) => x)(new)
  val (m_result) = cfun_renameFile (m_old,m_new)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_old)
  val _ = (fn _ => ()) (m_new)
in
  (result)
end
val A_READ = 1 : Int.int
val A_WRITE = 2 : Int.int
val A_EXEC = 4 : Int.int
val cfun_fileAccess : (cfun_idl_string * Int.int) -> cfun_ML_bool_t = C.c_function "SMLBasis" "fileAccess"
fun fileAccess(path,mode) = let
  val m_path = (fn (x) => x)(path)
  val m_mode = (fn (x) => x)(mode)
  val (m_result) = cfun_fileAccess (m_path,m_mode)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_path)
  val _ = (fn _ => ()) (m_mode)
in
  (result)
end
val cfun_tmpName : unit -> cfun_ML_string_t = C.c_function "SMLBasis" "tmpName"
fun tmpName() = let
  val (m_result) = cfun_tmpName ()
  val result = (fn x => x)(m_result)
in
  (result)
end
val cfun_fileId : cfun_idl_string -> cfun_ML_word8vec_t = C.c_function "SMLBasis" "fileId"
fun fileId(path) = let
  val m_path = (fn (x) => x)(path)
  val (m_result) = cfun_fileId (m_path)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_path)
in
  (result)
end
val IOD_KIND_FILE = 0 : Int.int
val IOD_KIND_DIR = 1 : Int.int
val IOD_KIND_SYMLINK = 2 : Int.int
val IOD_KIND_TTY = 3 : Int.int
val IOD_KIND_PIPE = 4 : Int.int
val IOD_KIND_SOCKET = 5 : Int.int
val IOD_KIND_DEVICE = 6 : Int.int
val cfun_ioDescKind : cfun_ML_iodesc_t -> cfun_ML_int_t = C.c_function "SMLBasis" "ioDescKind"
fun ioDescKind(iod) = let
  val m_iod = (fn x => x)(iod)
  val (m_result) = cfun_ioDescKind (m_iod)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_iod)
in
  (result)
end
val POLL_RD = 0wx1 : Word.word
val POLL_WR = 0wx2 : Word.word
val POLL_ERR = 0wx4 : Word.word
val cfun_osPoll : (cfun_ML_polldesc_list_t * cfun_Time_t option) -> cfun_ML_pollinfo_list_t = C.c_function "SMLBasis" "osPoll"
fun osPoll(pds,t) = let
  val m_pds = (fn x => x)(pds)
  val m_t = ((fn (x) => x) o  (fn NONE => NONE | SOME (v) => SOME (((fn (x) => x) o ((fn {seconds,uSeconds} => (seconds,uSeconds)) o (fn ({seconds,uSeconds}) => let   val m_seconds = (fn (x) => x)(seconds)  val m_uSeconds = (fn (x) => x)(uSeconds) in {seconds = m_seconds,uSeconds = m_uSeconds} end))) (v))))(t)
  val (m_result) = cfun_osPoll (m_pds,m_t)
  val result = (fn x => x)(m_result)
  val _ = (fn _ => ()) (m_pds)
  val _ = (fn _ => ()) (m_t)
in
  (result)
end
val cfun_now : unit -> cfun_Time_t = C.c_function "SMLBasis" "now"
fun now() = let
  val (m_t) = cfun_now ()
  val t = (((fn (v) => let   val m_seconds = (fn (x) => x) ((fn (x_0,x_1) => x_0) (v))  val m_uSeconds = (fn (x) => x) ((fn (x_0,x_1) => x_1) (v)) in {seconds = m_seconds,uSeconds = m_uSeconds} end) o (fn (x) => x)) m_t)
  val _ = (fn _ => ()) (m_t)
in
  (t)
end
val cfun_gmTime : cfun_Time_t -> cfun_Date_t = C.c_function "SMLBasis" "gmTime"
fun gmTime(t) = let
  val m_t = ((fn (x) => x) o ((fn {seconds,uSeconds} => (seconds,uSeconds)) o (fn ({seconds,uSeconds}) => let   val m_seconds = (fn (x) => x)(seconds)  val m_uSeconds = (fn (x) => x)(uSeconds) in {seconds = m_seconds,uSeconds = m_uSeconds} end)))(t)
  val (m_date) = cfun_gmTime (m_t)
  val date = (((fn (v) => let   val m_tm_sec = (fn (x) => x) ((fn (x_0,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8) => x_0) (v))  val m_tm_min = (fn (x) => x) ((fn (x_0,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8) => x_1) (v))  val m_tm_hour = (fn (x) => x) ((fn (x_0,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8) => x_2) (v))  val m_tm_mday = (fn (x) => x) ((fn (x_0,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8) => x_3) (v))  val m_tm_mon = (fn (x) => x) ((fn (x_0,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8) => x_4) (v))  val m_tm_year = (fn (x) => x) ((fn (x_0,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8) => x_5) (v))  val m_tm_wday = (fn (x) => x) ((fn (x_0,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8) => x_6) (v))  val m_tm_yday = (fn (x) => x) ((fn (x_0,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8) => x_7) (v))  val m_tm_isdst = (fn (x) => x) ((fn (x_0,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8) => x_8) (v)) in {tm_sec = m_tm_sec,tm_min = m_tm_min,tm_hour = m_tm_hour,tm_mday = m_tm_mday,tm_mon = m_tm_mon,tm_year = m_tm_year,tm_wday = m_tm_wday,tm_yday = m_tm_yday,tm_isdst = m_tm_isdst} end) o (fn (x) => x)) m_date)
  val _ = (fn _ => ()) (m_t)
  val _ = (fn _ => ()) (m_date)
in
  (date)
end
val cfun_localTime : cfun_Time_t -> cfun_Date_t = C.c_function "SMLBasis" "localTime"
fun localTime(t) = let
  val m_t = ((fn (x) => x) o ((fn {seconds,uSeconds} => (seconds,uSeconds)) o (fn ({seconds,uSeconds}) => let   val m_seconds = (fn (x) => x)(seconds)  val m_uSeconds = (fn (x) => x)(uSeconds) in {seconds = m_seconds,uSeconds = m_uSeconds} end)))(t)
  val (m_date) = cfun_localTime (m_t)
  val date = (((fn (v) => let   val m_tm_sec = (fn (x) => x) ((fn (x_0,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8) => x_0) (v))  val m_tm_min = (fn (x) => x) ((fn (x_0,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8) => x_1) (v))  val m_tm_hour = (fn (x) => x) ((fn (x_0,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8) => x_2) (v))  val m_tm_mday = (fn (x) => x) ((fn (x_0,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8) => x_3) (v))  val m_tm_mon = (fn (x) => x) ((fn (x_0,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8) => x_4) (v))  val m_tm_year = (fn (x) => x) ((fn (x_0,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8) => x_5) (v))  val m_tm_wday = (fn (x) => x) ((fn (x_0,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8) => x_6) (v))  val m_tm_yday = (fn (x) => x) ((fn (x_0,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8) => x_7) (v))  val m_tm_isdst = (fn (x) => x) ((fn (x_0,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8) => x_8) (v)) in {tm_sec = m_tm_sec,tm_min = m_tm_min,tm_hour = m_tm_hour,tm_mday = m_tm_mday,tm_mon = m_tm_mon,tm_year = m_tm_year,tm_wday = m_tm_wday,tm_yday = m_tm_yday,tm_isdst = m_tm_isdst} end) o (fn (x) => x)) m_date)
  val _ = (fn _ => ()) (m_t)
  val _ = (fn _ => ()) (m_date)
in
  (date)
end
fun mkTime _ = raise Fail "mkTime missing"
fun strFTime _ = raise Fail "strFTime missing"
val cfun_getCPUTime : unit -> (cfun_Time_t * cfun_Time_t * cfun_Time_t) = C.c_function "SMLBasis" "getCPUTime"
fun getCPUTime() = let
  val (m_u,m_s,m_g) = cfun_getCPUTime ()
  val u = (((fn (v) => let   val m_seconds = (fn (x) => x) ((fn (x_0,x_1) => x_0) (v))  val m_uSeconds = (fn (x) => x) ((fn (x_0,x_1) => x_1) (v)) in {seconds = m_seconds,uSeconds = m_uSeconds} end) o (fn (x) => x)) m_u)
  val s = (((fn (v) => let   val m_seconds = (fn (x) => x) ((fn (x_0,x_1) => x_0) (v))  val m_uSeconds = (fn (x) => x) ((fn (x_0,x_1) => x_1) (v)) in {seconds = m_seconds,uSeconds = m_uSeconds} end) o (fn (x) => x)) m_s)
  val g = (((fn (v) => let   val m_seconds = (fn (x) => x) ((fn (x_0,x_1) => x_0) (v))  val m_uSeconds = (fn (x) => x) ((fn (x_0,x_1) => x_1) (v)) in {seconds = m_seconds,uSeconds = m_uSeconds} end) o (fn (x) => x)) m_g)
  val _ = (fn _ => ()) (m_u)
  val _ = (fn _ => ()) (m_s)
  val _ = (fn _ => ()) (m_g)
in
  (u,s,g)
end
val cfun_cmdName : unit -> cfun_idl_string = C.c_function "SMLBasis" "cmdName"
fun cmdName() = let
  val (m_s) = cfun_cmdName ()
  val s = (((fn (x) => x) o (fn (x) => x)) m_s)
  val _ = (fn _ => ()) (m_s)
in
  (s)
end
val cfun_cmdArgs : unit -> cfun_ML_string_list_t = C.c_function "SMLBasis" "cmdArgs"
fun cmdArgs() = let
  val (m_result) = cfun_cmdArgs ()
  val result = (fn x => x)(m_result)
in
  (result)
end
end

