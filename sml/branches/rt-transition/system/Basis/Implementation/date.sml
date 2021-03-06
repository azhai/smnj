(* date.sml
 *
 * COPYRIGHT (c) 2015 The Fellowship of SML/NJ (http://www.smlnj.org)
 * All rights reserved.
 *
 * The SML Basis Library Date module.  This code is partially based on
 * ideas from the paper
 *
 *	Calendrical Calculations
 *	by Nachum Dershowitz and Edward M. Reingold
 *	Software---Practice & Experience,
 *	vol. 20, no. 9 (September, 1990), pp. 899--928.
 *
 * C++, Lisp, and EmacsLisp code from that paper can be found at
 *
 *	http://emr.cs.iit.edu/~reingold/calendars.shtml
 *)

structure Date : DATE =
  struct

    structure Int = IntImp
    structure Int32 = Int32Imp
    structure IntInf = IntInfImp
    structure String = StringImp
    structure Time = TimeImp
    structure SS = InitSubstring

  (* the run-time system indexes the year off this *)
    val baseYear = 1900
	
    exception Date

    datatype weekday = Mon | Tue | Wed | Thu | Fri | Sat | Sun

    datatype month
      = Jan | Feb | Mar | Apr | May | Jun
      | Jul | Aug | Sep | Oct | Nov | Dec

    datatype date = DATE of {
	year : int,
	month : month,
	day : int,
	hour : int,
	minute : int,
	second : int,
	offset : Time.time option,
	wday : weekday,
	yday : int,
	isDst : bool option
      }

  (* tables for mapping integers to days/months *)
    val dayTbl = #[Sun, Mon, Tue, Wed, Thu, Fri, Sat]
    val monthTbl = #[Jan, Feb, Mar, Apr, May, Jun, Jul, 
		     Aug, Sep, Oct, Nov, Dec]

    fun dayToInt Sun = 0
      | dayToInt Mon = 1
      | dayToInt Tue = 2
      | dayToInt Wed = 3
      | dayToInt Thu = 4
      | dayToInt Fri = 5
      | dayToInt Sat = 6

  (* careful about this: the month numbers are 0-11 *)
    fun monthToInt Jan = 0
      | monthToInt Feb = 1
      | monthToInt Mar = 2
      | monthToInt Apr = 3
      | monthToInt May = 4
      | monthToInt Jun = 5
      | monthToInt Jul = 6
      | monthToInt Aug = 7
      | monthToInt Sep = 8
      | monthToInt Oct = 9
      | monthToInt Nov = 10
      | monthToInt Dec = 11

  (* the type used to communicate with C; this record has the
   * following fields, all int values:
   *   tm_sec, tm_min, tm_hour, tm_mday, tm_mon, tm_year,
   *   tm_wday, tm_yday,
   *   tm_isdst.
   *)
    type tm = SMLBasis.Date_t

  (* wrap a C function call with a handler that maps SysErr
   * exception into Date exceptions.
   *)
    fun wrap f x = (f x) handle _ => raise Date

  (* note: mkTime assumes the tm structure passed to it reflects
   * the local time zone
   *)
    val ascTime		= SMLBasis.ascTime	: tm -> string
    val localTime'	= SMLBasis.localTime	: SMLBasis.Time_t -> tm
    val gmTime'		= SMLBasis.gmTime	: SMLBasis.Time_t -> tm
    val mkTime'		= SMLBasis.mkTime	: tm -> SMLBasis.Time_t
    val strfTime	= SMLBasis.strfTime	: (string * tm) -> string

    val localTime = localTime' o Time.toTime_t
    val gmTime = gmTime' o Time.toTime_t
    val mkTime = Time.fromTime_t o mkTime'

    fun year (DATE{year, ...}) = year
    fun month (DATE{month, ...}) = month
    fun day (DATE{day, ...}) = day
    fun hour (DATE{hour, ...}) = hour
    fun minute (DATE{minute, ...}) = minute
    fun second (DATE{second, ...}) = second
    fun weekDay (DATE{wday, ...}) = wday
    fun yearDay (DATE{yday, ...}) = yday
    fun isDst (DATE{isDst, ...}) = isDst
    fun offset (DATE{offset,...}) = offset

  (* functionally updates a tm's dst flag.
   * Used to compute local offsets 
   *)
    fun withDst dst (tm : tm) : tm = {
	    tm_sec = #tm_sec tm, 
	    tm_min = #tm_min tm,
	    tm_hour = #tm_hour tm,
	    tm_mday = #tm_mday tm,
	    tm_mon = #tm_mon tm,
	    tm_year = #tm_year tm,
	    tm_wday = #tm_wday tm,
	    tm_yday = #tm_yday tm,
	    tm_isdst = dst
	  }

    fun dstOf (tm : tm) = #tm_isdst tm

    fun localOffset' () = let
          val t = Time.now()
	  val t_as_utc_tm = gmTime t
	  val t_as_loc_tm = localTime t
	  val loc_dst = dstOf t_as_loc_tm
	  val t_as_utc_tm' = withDst loc_dst t_as_utc_tm
	  val t' = mkTime' t_as_utc_tm'
          in
	    (Time.- (Time.fromTime_t t', t), loc_dst)
	  end

    val localOffset = #1 o localOffset'

    (* 
     * This code is taken from Reingold's paper
     *)
    local 
	val quot = Int.quot
	val not = Bool.not
	fun sum (f,k,p) = 
	    let fun loop (f,i,p,acc) = if (not(p(i))) then acc
				       else loop(f,i+1,p,acc+f(i))
	    in
		loop (f,k,p,0)
	    end
	fun lastDayOfGregorianMonth (month,year) =
	    if ((month=1) andalso 
		(Int.mod (year,4) = 0) andalso 
		not (Int.mod (year,400) = 100) andalso
		not (Int.mod (year,400) = 200) andalso
		not (Int.mod (year,400) = 300))
		then 29
	    else List.nth ([31,28,31,30,31,30,31,31,30,31,30,31],month)
    in
	fun toAbsolute (month, day, year) =
	    day  
	    + sum (fn (m) => lastDayOfGregorianMonth(m,year),0,
		   fn (m) => (m<month)) 
	    + 365 * (year -1)
	    + quot (year-1,4)
	    - quot (year-1,100)
	    + quot (year-1,400)
	fun fromAbsolute (abs) =
	    let val approx = quot (abs,366)
		val year = (approx + sum(fn(_)=>1, approx, 
					 fn(y)=> (abs >= toAbsolute(0,1,y+1))))
		val month = (sum (fn(_)=>1, 0,
				  fn(m)=> (abs > toAbsolute(m,lastDayOfGregorianMonth(m,year),year))))
		val day = (abs - toAbsolute(month,1,year) + 1)
	    in
		(month, day, year)
	    end
	fun wday abs = InlineT.PolyVector.sub (dayTbl, Int.mod(abs,7))
	fun yday (year, abs) = let
	      val daysPrior = 
		  365 * (year -1)
		  + quot (year-1,4)
		  - quot (year-1,100)
		  + quot (year-1,400)
	      in 
		abs - daysPrior - 1    (* to conform to ISO standard *)
	      end
    end (* local *)

  (*
   * this function should also canonicalize the time (hours, etc...)
   *)
    fun canonicalizeDate (DATE d) = let
	  val args = (monthToInt(#month d), #day d, #year d)
	  val abs = toAbsolute args
	  val (monthC,dayC, yearC) = fromAbsolute abs
	  val yday = yday (yearC, abs)
	  val wday = wday abs
	  in
	    DATE{
		year = yearC,
		month = InlineT.PolyVector.sub (monthTbl,monthC),
		day = dayC,
		hour = #hour d,
		minute = #minute d,
		second = #second d,
		offset = #offset d,
		isDst = NONE,
		yday = yday,
		wday = wday
	      }
	  end

    fun toTM (DATE d) = {
	    tm_sec = #second d,
	    tm_min = #minute d,		
	    tm_hour = #hour d,	
	    tm_mday = #day d,
	    tm_mon = monthToInt(#month d),
	    tm_year = #year d - baseYear,
	    tm_wday = dayToInt(#wday d),
	    tm_yday = #yday d,
	    tm_isdst = case (#isDst d)
			of NONE => ~1
			 | (SOME false) => 0
			 | (SOME true) => 1
	  }

    fun fromTM {tm_sec, tm_min, tm_hour, tm_mday, tm_mon,
		tm_year, tm_wday, tm_yday, tm_isdst} offset =
	  DATE{
	      year = baseYear + tm_year,
	      month = InlineT.PolyVector.sub (monthTbl, tm_mon),
	      day = tm_mday,
	      hour = tm_hour,
	      minute = tm_min,
	      second = tm_sec,
	      wday = InlineT.PolyVector.sub (dayTbl, tm_wday),
	      yday = tm_yday,
	      isDst = if (tm_isdst < 0) then NONE else SOME(tm_isdst <> 0),
	      offset = offset
	    }

    fun fromTimeLocal t = fromTM (localTime t) NONE

    fun fromTimeUniv t = fromTM (gmTime t) (SOME Time.zeroTime)

    fun fromTimeOffset (t, offset) =
	  fromTM (gmTime (Time.- (t, offset))) (SOME offset)

    val day_seconds = IntInfImp.fromInt (24 * 60 * 60)
    val hday_seconds = IntInfImp.fromInt (12 * 60 * 60)

    fun canonicalOffset off = let
	  val offs = Time.toSeconds off
	  val offs' = offs mod day_seconds
	  val offs'' = if offs' > hday_seconds then offs' - day_seconds else offs'
	  in
	    Time.fromSeconds offs''
	  end

    fun toTime d = let
	  val tm = toTM d
	  in
	    case offset d
	     of NONE => mkTime tm
	      | SOME tm_utc_off => let
		    val tm_utc_off = canonicalOffset tm_utc_off
		    val (loc_utc_off, loc_dst) = localOffset' ()
		    (* time west of here *)
		    val tm_loc_off = Time.- (tm_utc_off, loc_utc_off)
		in
		    (* pretend tm refers to local time, then subtract
		     * difference between dest. and local time *)
		    Time.- (mkTime (withDst loc_dst tm), tm_loc_off)
		end
	  end

    fun date { year, month, day, hour, minute, second, offset } = let
	  val d = DATE{
		  second = second,
		  minute = minute,
		  hour = hour,
		  year = year,
		  month = month, 
		  day = day,
		  offset = offset,
		  isDst = NONE,
		  yday = 0,
		  wday = Mon
		}
	  val canonicalDate = canonicalizeDate d
	  fun internalDate () = (case offset
		 of NONE => fromTimeLocal (toTime canonicalDate)
		  | SOME off => fromTimeOffset (toTime canonicalDate, off)
		(* end case *))
	  in
	    internalDate () handle Date => d
	  end

  (* date comparison does not take into account the offset
   * thus, it does not compare dates in different time zones
   *)
    fun compare (DATE d1, DATE d2) = let
	  fun cmp (sel, k) = (case Int.compare (sel d1, sel d2)
		 of EQUAL => k()
		  | order => order
		(* end case *))
	  in
	    cmp (#year, fn () =>
	    cmp (monthToInt o #month, fn () =>
	    cmp (#day, fn () =>
	    cmp (#hour, fn () =>
	    cmp (#minute, fn () =>
	    cmp (#second, fn () => EQUAL))))))
	  end


  (***** String conversions *****)

    fun toString d = ascTime (date2tm d)

  (* the size of the runtime system character buffer, not including space for the '\0' *)
    val fmtBuf = 512-1
    fun fmt fmtStr = let
	(* get a format character; the next character in start should be #"%" (or else
	 * start is empty.  Returns a triple (maxLen, frag, rest), where maxLen is an
	 * upperbound on the expansion of the format string, frag is the format string
	 * and rest is the rest of the substring.
	 *)
	  fun getFmtC start = (case SS.getc start
		 of SOME(_, rest) => let
		      fun continue (len, ss') = (len, SS.slice(start, 0, SOME 2), ss')
		      in
			case SS.getc rest
			 of NONE => (1, SS.full "%", rest)
			  | SOME(#"a", ss') => continue(3, ss')
			  | SOME(#"A", ss') => continue(20, ss')
			  | SOME(#"b", ss') => continue(3, ss')
			  | SOME(#"B", ss') => continue(20, ss')
			  | SOME(#"c", ss') => continue(24, ss')
			  | SOME(#"d", ss') => continue(2, ss')
			  | SOME(#"H", ss') => continue(2, ss')
			  | SOME(#"I", ss') => continue(2, ss')
			  | SOME(#"j", ss') => continue(3, ss')
			  | SOME(#"m", ss') => continue(2, ss')
			  | SOME(#"M", ss') => continue(2, ss')
			  | SOME(#"p", ss') => continue(3, ss')
			  | SOME(#"S", ss') => continue(2, ss')
			  | SOME(#"U", ss') => continue(2, ss')
			  | SOME(#"w", ss') => continue(1, ss')
			  | SOME(#"W", ss') => continue(2, ss')
			  | SOME(#"x", ss') => continue(24, ss')
			  | SOME(#"X", ss') => continue(24, ss')
			  | SOME(#"y", ss') => continue(2, ss')
			  | SOME(#"Y", ss') => continue(4, ss')
			  | SOME(#"Z", ss') => continue(3, ss')
			  | SOME(c, ss') => (1, SS.full(String.str c), ss')
			(* end case *)
		      end
		  | NONE => (0, start, start)
		(* end case *))
	  fun mkFmtFn (frags, fmtFns) = if List.null frags
		then fmtFns
		else let
		  val s = SS.concat(List.rev frags)
		  in
		    (fn tm => strfTime(s, tm)) :: fmtFns
		  end
	  fun notPct #"%" = false | notPct _ = true
	  fun scan (ss, totLen, frags, fmtFns) = let
		val (ss1, ss2) = SS.splitl notPct ss
		val n = SS.size ss1
		val (totLen, frags, fmtFns) = if (n = 0)
			then (totLen, frags, fmtFns)
		      else if (totLen+n >= fmtBuf)
			then let
			  val fmtFns = mkFmtFn(frags, fmtFns)
			  val s = SS.string ss1
			  in
			    (0, [], (fn _ => s) :: fmtFns)
			  end
			else (totLen+n, ss1::frags, fmtFns)
		in
		  case getFmtC ss2
		   of (0, _, _) => List.rev(mkFmtFn (frags, fmtFns))
		    | (n, frag, rest) => if (totLen + n >= fmtBuf)
			then let
			  val fmtFns = mkFmtFn(frags, fmtFns)
			  in
			    scan (rest, n, [frag], fmtFns)
			  end
			else scan (rest, totLen+n, frag::frags, fmtFns)
		  (* end case *)
		end
	  val fmtFns = scan (SS.full fmtStr, 0, [], [])
	  in
	    fn d => let val tm = toTM d in String.concat(List.map (fn f => f tm) fmtFns) end
	  end

  (* Date scanner *)
    fun scan getc s = let
	  fun getword s = StringCvt.splitl Char.isAlpha getc s
	(* consume the character c from the stream s and then pass the remaining
	 * stream to the continuation k.  Returns NONE if a different character
	 * is encountered.
	 *)
	  fun expect c s k = (case getc s
		 of NONE => NONE
		  | SOME(c', s') => if c = c' then k s' else NONE
		(* end case *))
	  fun getdig s = (case getc s
		of NONE => NONE
		 | SOME(c, s') => if Char.isDigit c
		    then SOME (Char.ord c - Char.ord #"0", s')
		    else NONE
  		(* end case *))
	  fun get2dig s = (case getdig s
		 of SOME(c1, s') => (case getdig s'
		       of SOME (c2, s'') => SOME (10 * c1 + c2, s'')
		        | NONE => NONE
		      (* end case *))
		  | NONE => NONE
    		(* end case *))
	(* day can be two digits or one digit preceded by a space *)
	  fun getday s = (case get2dig s
		 of NONE => expect #" " s (fn s' => getdig s')
		  | (res as SOME (n, s')) => res
  		(* end case *))
	  fun year0 (wday, mon, d, hr, mn, sc) s = (case Int.scan StringCvt.DEC getc s
		 of NONE => NONE
		  | SOME (yr, s') => (SOME(date {
			year = yr, month = mon, day = d,
			hour = hr, minute = mn, second = sc,
			offset = NONE
		      }, s')) handle _ => NONE
		(* end case *))
	  fun year args s = expect #" " s (year0 args)
	  fun second0 (wday, mon, d, hr, mn) s = (case get2dig s
		 of NONE => NONE
		  | SOME (sc, s') => year (wday, mon, d, hr, mn, sc) s'
		(* end case *))
	  fun second args s = expect #":" s (second0 args)
	  fun minute0 (wday, mon, d, hr) s = (case get2dig s
		 of NONE => NONE
		  | SOME (mn, s') => second (wday, mon, d, hr, mn) s'
		(* end case *))
	  fun minute args s = expect #":" s (minute0 args)
	  fun time0 (wday, mon, d) s = (case get2dig s
		 of NONE => NONE
		  | SOME (hr, s') => minute (wday, mon, d, hr) s'
		(* end case *))
	  fun time args s = expect #" " s (time0 args)
	  fun mday0 (wday, mon) s = (case getday s
		 of NONE => NONE
		  | SOME (d, s') => time (wday, mon, d) s'
  		(* end case *))
	  fun mday args s = expect #" " s (mday0 args)
	  fun month0 wday s = (case getword s
		 of ("Jan", s') => mday (wday, Jan) s'
		  | ("Feb", s') => mday (wday, Feb) s'
		  | ("Mar", s') => mday (wday, Mar) s'
		  | ("Apr", s') => mday (wday, Apr) s'
		  | ("May", s') => mday (wday, May) s'
		  | ("Jun", s') => mday (wday, Jun) s'
		  | ("Jul", s') => mday (wday, Jul) s'
		  | ("Aug", s') => mday (wday, Aug) s'
		  | ("Sep", s') => mday (wday, Sep) s'
		  | ("Oct", s') => mday (wday, Oct) s'
		  | ("Nov", s') => mday (wday, Nov) s'
		  | ("Dec", s') => mday (wday, Dec) s'
		  | _ => NONE
		(* end case *))
	  fun month wday s = expect #" " s (month0 wday)
	  fun wday s = (case getword s
		 of ("Sun", s') => month Sun s'
		  | ("Mon", s') => month Mon s'
		  | ("Tue", s') => month Tue s'
		  | ("Wed", s') => month Wed s'
		  | ("Thu", s') => month Thu s'
		  | ("Fri", s') => month Fri s'
		  | ("Sat", s') => month Sat s'
		  | _ => NONE
		(* end case *))
	  in
	    wday s
	  end (* scan *)

    fun fromString s = StringCvt.scanString scan s

  end (* Date *)
