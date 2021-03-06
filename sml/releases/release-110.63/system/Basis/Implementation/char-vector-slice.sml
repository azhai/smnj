(*  char-vector-slice.sml
 *
 * Copyright (c) 2003 by The Fellowship of SML/NJ
 *
 * Author: Matthias Blume (blume@tti-c.org)
 *)
structure CharVectorSlice :> MONO_VECTOR_SLICE
				 where type elem = char
				 where type vector = CharVector.vector
				 where type slice = Substring.substring
= struct

    (* fast add/subtract avoiding the overflow test *)
    infix -- ++
    fun x -- y = InlineT.Word31.copyt_int31 (InlineT.Word31.copyf_int31 x -
					     InlineT.Word31.copyf_int31 y)
    fun x ++ y = InlineT.Word31.copyt_int31 (InlineT.Word31.copyf_int31 x +
					     InlineT.Word31.copyf_int31 y)

    structure SS = Substring

    type elem = char
    type vector = CharVector.vector
    type slice = SS.substring

    val usub = InlineT.CharVector.sub
    val vlength = InlineT.CharVector.length

    val length = SS.size
    val sub = SS.sub
    val full = SS.full
    val slice = SS.extract
    val subslice = SS.slice
    val base = SS.base
    val vector = SS.string
    val isEmpty = SS.isEmpty
    val getItem = SS.getc

    fun appi f vs = let
	val (base, start, len) = SS.base vs
	val stop = start ++ len
	fun app i =
	    if i >= stop then ()
	    else (f (i -- start, usub (base, i)); app (i ++ 1))
    in
	app start
    end

    val app = SS.app
    val foldl = SS.foldl
    val foldr = SS.foldr
    val concat = SS.concat
    val collate = SS.collate

    fun foldli f init vs = let
	val (base, start, len) = SS.base vs
	val stop = start ++ len
	fun fold (i, a) =
	    if i >= stop then a
	    else fold (i ++ 1, f (i -- start, usub (base, i), a))
    in
	fold (start, init)
    end

    fun foldri f init vs = let
	val (base, start, len) = SS.base vs
	val stop = start ++ len
	fun fold (i, a) =
	    if i < start then a
	    else fold (i -- 1, f (i -- start, usub (base, i), a))
    in
	fold (stop -- 1, init)
    end

    fun mapi f sl =
	CharVector.fromList
	    (rev (foldli (fn (i, x, a) => f (i, x) :: a) [] sl))

    fun map f sl =
	CharVector.fromList
	    (rev (foldl (fn (x, a) => f x :: a) [] sl))

    fun findi p vs = let
	val (base, start, len) = SS.base vs
	val stop = start ++ len
	fun fnd i =
	    if i >= stop then NONE
	    else let val x = usub (base, i)
		 in
		     if p (i, x) then SOME (i -- start, x) else fnd (i ++ 1)
		 end
    in
	fnd start
    end

    fun find p vs = let
	val (base, start, len) = SS.base vs
	val stop = start ++ len
	fun fnd i =
	    if i >= stop then NONE
	    else let val x = usub (base, i)
		 in
		     if p x then SOME x else fnd (i ++ 1)
		 end
    in
	fnd start
    end

    fun exists p vs = let
	val (base, start, len) = SS.base vs
	val stop = start ++ len
	fun ex i = i < stop andalso (p (usub (base, i)) orelse ex (i ++ 1))
    in
	ex start
    end

    fun all p vs = let
	val (base, start, len) = SS.base vs
	val stop = start ++ len
	fun al i = i >= stop orelse (p (usub (base, i)) andalso al (i ++ 1))
    in
	al start
    end
end
