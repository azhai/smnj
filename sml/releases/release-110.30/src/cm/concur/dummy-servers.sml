(*
 * Handling compile-servers under non-Unix systems.
 *
 *  This is just a placeholder that disables parallel make on non-supported
 *  systems.
 *
 * (C) 1999 Lucent Technologies, Bell Laboratories
 *
 * Author: Matthias Blume (blume@kurims.kyoto-u.ac.jp)
 *)
structure Servers :> SERVERS = struct
    type server = unit
    local
	fun unavailable x =
	    (Say.say ["Compile server facility not available."]; x)
	fun impossible () = raise Fail "Servers: impossible"
    in
        fun start _ = unavailable NONE
	fun stop () = impossible ()
	fun kill () = impossible ()
	fun name () = impossible ()
	fun reset _ = Concur.reset ()
	fun dirbase _ = ()
	fun cd _ = ()
	fun cm _ = ()
	fun cmb _ = ()
	fun cmb_new _ = ()
	fun compile _ = false
	fun withServers f =
	    SafeIO.perform { openIt = fn () => (),
			     closeIt = fn () => (),
			     work = f,
			     cleanup = reset }
	fun allIdle () = true
    end
end
