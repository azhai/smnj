
(*
 * This file was automatically generated by ml-idl
 * (Fri Jul  6 15:20:40 2001)
 *)

signature SML_BASIS = sig
type idl_string = String.string
type ML_word8vec_t = Word8Vector.vector
type ML_word8vec_opt_t = Word8Vector.vector option
type ML_word8arr_t = Word8Array.array
type ML_charvec_t = CharVector.vector
type ML_charvec_opt_t = CharVector.vector option
type ML_chararr_t = CharArray.array
type ML_unit_t = unit
type ML_bool_t = bool
type ML_int_t = int
type ML_int32_t = Int32.int
type ML_string_t = string
type ML_string_opt_t = string option
type ML_string_list_t = string list
type ML_int_opt_t = int option
type ML_iodesc_t = word (* was: Unsafe.Object.object *)
type ML_directory_t = Unsafe.Object.object
type Time_t = {seconds:Int32.int,uSeconds:Int32.int}
type ML_polldesc_list_t = (word * word (* Unsafe.Object.object *)) list
type ML_pollinfo_list_t = (word * word (* Unsafe.Object.object *)) list
type Date_t = {tm_sec:Int32.int,tm_min:Int32.int,tm_hour:Int32.int,tm_mday:Int32.int,tm_mon:Int32.int,tm_year:Int32.int,tm_wday:Int32.int,tm_yday:Int32.int,tm_isdst:Int32.int}
val TO_NEAREST : Int.int
val TO_NEGINF : Int.int
val TO_POSINF : Int.int
val TO_ZERO : Int.int
val getRoundingMode : unit -> Int.int
val setRoundingMode : Int.int -> unit
val OPEN_RD : Int.int
val OPEN_WR : Int.int
val OPEN_RDWR : Int.int
val OPEN_CREATE : Int.int
val OPEN_TRUNC : Int.int
val OPEN_APPEND : Int.int
val openFile : (ML_string_t * Int.int) -> ML_iodesc_t
val closeFile : ML_iodesc_t -> unit
val cmpIODesc : (ML_iodesc_t * ML_iodesc_t) -> Int.int
val readTextVec : (Bool.bool * ML_iodesc_t * Int.int) -> ML_charvec_opt_t
val readTextArr : (Bool.bool * ML_iodesc_t * ML_chararr_t * Int.int * Int.int) -> ML_int_t
val writeTextVec : (Bool.bool * ML_iodesc_t * ML_charvec_t * Int.int * Int.int) -> ML_int_t
val writeTextArr : (Bool.bool * ML_iodesc_t * ML_chararr_t * Int.int * Int.int) -> ML_int_t
val readBinVec : (Bool.bool * ML_iodesc_t * Int.int) -> ML_word8vec_opt_t
val readBinArr : (Bool.bool * ML_iodesc_t * ML_word8arr_t * Int.int * Int.int) -> ML_int_t
val writeBinVec : (Bool.bool * ML_iodesc_t * ML_word8vec_t * Int.int * Int.int) -> ML_int_t
val writeBinArr : (Bool.bool * ML_iodesc_t * ML_word8arr_t * Int.int * Int.int) -> ML_int_t
val SET_POS_BEGIN : Int.int
val SET_POS_CUR : Int.int
val SET_POS_END : Int.int
val getPos : ML_iodesc_t -> ML_int32_t
val setPos : (ML_iodesc_t * ML_int32_t * Int.int) -> ML_unit_t
val getStdIn : unit -> ML_iodesc_t
val getStdOut : unit -> ML_iodesc_t
val getStdErr : unit -> ML_iodesc_t
val errorName : Int32.int -> ML_string_t
val errorMessage : Int32.int -> ML_string_t
val syserror : idl_string -> ML_int_opt_t
val osSystem : idl_string -> ML_int_t
val exit : Int.int -> unit
val getEnv : idl_string -> ML_string_opt_t
val osSleep : Time_t -> unit
val openDir : idl_string -> ML_directory_t
val readDir : ML_directory_t -> ML_string_opt_t
val rewindDir : ML_directory_t -> ML_unit_t
val closeDir : ML_directory_t -> ML_unit_t
val chDir : idl_string -> ML_unit_t
val getDir : unit -> ML_string_t
val mkDir : idl_string -> ML_unit_t
val rmDir : idl_string -> ML_unit_t
val isReg : idl_string -> ML_bool_t
val isDir : idl_string -> ML_bool_t
val isLink : idl_string -> ML_bool_t
val readLink : idl_string -> ML_string_t
val fileSize : idl_string -> ML_int32_t
val modTime : idl_string -> ML_int32_t
val setTime : (idl_string * Time_t option) -> ML_unit_t
val removeFile : idl_string -> ML_unit_t
val renameFile : (idl_string * idl_string) -> ML_unit_t
val A_READ : Int.int
val A_WRITE : Int.int
val A_EXEC : Int.int
val fileAccess : (idl_string * Int.int) -> ML_bool_t
val tmpName : unit -> ML_string_t
val fileId : idl_string -> ML_word8vec_t
val IOD_KIND_FILE : Int.int
val IOD_KIND_DIR : Int.int
val IOD_KIND_SYMLINK : Int.int
val IOD_KIND_TTY : Int.int
val IOD_KIND_PIPE : Int.int
val IOD_KIND_SOCKET : Int.int
val IOD_KIND_DEVICE : Int.int
val ioDescKind : ML_iodesc_t -> ML_int_t
val POLL_RD : Word.word
val POLL_WR : Word.word
val POLL_ERR : Word.word
val osPoll : (ML_polldesc_list_t * Time_t option) -> ML_pollinfo_list_t
val now : unit -> Time_t
val gmTime : Time_t -> Date_t
val localTime : Time_t -> Date_t
val mkTime : Date_t -> Time_t
val strFTime : (idl_string * Date_t) -> ML_string_t
val getCPUTime : unit -> (Time_t * Time_t * Time_t)
val cmdName : unit -> idl_string
val cmdArgs : unit -> ML_string_list_t
end

