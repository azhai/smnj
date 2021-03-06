(* timer-sig.sml
 *
 * COPYRIGHT (c) 1997 Bell Labs, Lucent Technologies.
 *
 * extracted from timer.mldoc (v. 1.7; 1997-10-31)
 *)

signature TIMER =
  sig
    type cpu_timer
    type real_timer
    val startCPUTimer : unit -> cpu_timer
    val checkCPUTimer : cpu_timer -> {usr : Time.time, sys : Time.time}
    val checkGCTime : cpu_timer -> Time.time
    val totalCPUTimer : unit -> cpu_timer
    val startRealTimer : unit -> real_timer
    val checkRealTimer : real_timer -> Time.time
    val totalRealTimer : unit -> real_timer
    
  end
