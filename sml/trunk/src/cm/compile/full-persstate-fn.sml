(*
 * Build a new "full" persistent state.
 *
 * (C) 1999 Lucent Technologies, Bell Laboratories
 *
 * Author: Matthias Blume (blume@kurims.kyoto-u.ac.jp)
 *)
local
    structure E = GenericVC.Environment
    structure EM = GenericVC.ErrorMsg
    structure PP = PrettyPrint

    type env = GenericVC.Environment.dynenv
in
functor FullPersstateFn (structure MachDepVC : MACHDEP_VC
			 val warmup_hook: env option ref) :> FULL_PERSSTATE =
    struct
	type env = env

	datatype ord_key =
	    SML of SmlInfo.info
	  | STABLE of BinInfo.info

	fun compare (SML _, STABLE _) = LESS
	  | compare (STABLE _, SML _) = GREATER
	  | compare (SML i, SML i') = SmlInfo.compare (i, i')
	  | compare (STABLE i, STABLE i') = BinInfo.compare (i, i')


	structure K = struct
	    type ord_key = ord_key
	    val compare = compare
	end

	structure Map = BinaryMapFn (K)

	structure Set = BinarySetFn (K)

	type persentry = env * Set.set ref
	type tmpentry = env * ord_key list

	val persmap = ref (Map.empty: persentry option Map.map)
	val tmpmap = ref (Map.empty: tmpentry Map.map)

	fun share (SML i) = SmlInfo.share i
	  | share (STABLE i) = BinInfo.share i

	fun discard (k, m) =
	    case Map.find (m, k) of
		NONE => m
	      | SOME NONE => m
	      | SOME (SOME (_, ref dl)) =>
		    Set.foldl discard (Map.insert (m, k, NONE)) dl

	fun discard_pers i = persmap := discard (i, !persmap)

	fun new_info (i, popt) = let
	    fun dlook (e, p) =
		SOME (DynamicEnv.look e p) handle DynamicEnv.Unbound => NONE
	in
	    discard_pers i;
	    case (!warmup_hook, popt) of
		(SOME we, SOME pid) =>
		    (case dlook (we, pid) of
			 NONE => ()
		       | SOME x => let
			     val de =
				 DynamicEnv.bind (pid, x, DynamicEnv.empty)
			 in
			     persmap := Map.insert (!persmap, i,
						    SOME (de, ref Set.empty))
			 end)
	      | _ => ()
	end

	fun new_smlinfo (i, popt) = new_info (SML i, popt)
	fun new_bininfo (i, popt) = new_info (STABLE i, popt)

	local
	    structure RecompPersstate =
		RecompPersstateFn (structure MachDepVC = MachDepVC
				   val discard_code = false
				   val new_smlinfo = new_smlinfo)
	    val reset_recomp = RecompPersstate.reset
	in
	    open RecompPersstate
	    fun reset () =
		(reset_recomp ();
		 persmap := Map.empty;
		 tmpmap := Map.empty)
	end

	infix o'
	fun (f o' g) (x, y) = f (g x, y)

	fun exec_look (k, gp) = let
	    fun descr (SML i) = SmlInfo.descr i
	      | descr (STABLE i) = BinInfo.describe i
	    fun error (SML i) = SmlInfo.error gp i
	      | error (STABLE i) = BinInfo.error i
	in
	    case Map.find (!tmpmap, k) of
		NONE =>
		    (case Map.find (!persmap, k) of
			 NONE => NONE
		       | SOME NONE =>
			     (if share k = SOME true then
				  error k EM.WARN
				  (concat ["re-instantiating ", descr k,
					   " (sharing may be lost)"])
				  EM.nullErrorBody
			      else ();
			      NONE)
		       | SOME (SOME (e, _)) =>
			     if share k = SOME false then
				 (discard_pers k; NONE)
			     else  SOME e)
	      | SOME (e, _) => SOME e
	end

	val exec_look_sml = exec_look o' SML
	val exec_look_stable = exec_look o' STABLE

	fun exec_memo (k, e, d) = tmpmap := Map.insert (!tmpmap, k, (e, d))

	fun exec_memo_sml (i, e, sl, bl) =
	    exec_memo (SML i, e, map STABLE bl @ map SML sl)

	fun exec_memo_stable (i, e, il) =
	    exec_memo (STABLE i, e, map STABLE il)

	fun rememberShared () = let
	    fun retainShared (k, (e, d), m) = let
		val m = discard (k, m)
	    in
		if share k = SOME false then m
		else Map.insert (m, k, SOME (e, ref Set.empty))
	    end
	    fun addDep (k, (e, d)) = let
		fun addOneDep k' =
		    case Map.find (!persmap, k') of
			NONE => ()
		      | SOME NONE => ()
		      | SOME (SOME (_, r as ref s)) => r := Set.add (s, k)
	    in
		app addOneDep d
	    end
	    val tm = !tmpmap
	in
	    tmpmap := Map.empty;
	    persmap := Map.foldli retainShared (!persmap) tm;
	    Map.appi addDep tm
	end
    end
end
