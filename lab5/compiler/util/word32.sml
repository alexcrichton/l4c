(* L5 Compiler
 * Utilities for signed modular arithmetic
 * Author: Frank Pfenning
 *)

(*
 * There are two useful structure in the SML Basis Library
 * Int32, with 2's complement arithmetic,
 *        but it raises Overflow instead of doing modular arithmetic
 * Word32, with unsigned modular arithmetic
 *
 * This structure implements some signed operations on Word32
 *)

signature WORD32_SIGNED =
sig
  val TMAX : Word32.word  (* largest signed positive word, 2^31-1  *)
  val TMIN : Word32.word  (* smallest signed negative word -2^31 *)
  val ZERO : Word32.word  (* 0 *)
  (* parse from string, no sign *)
  val fromString : string -> Word32.word option
        (* raises Overflow if not 0 <= n < 2^31 *)
  val fromHexString : string -> Word32.word option (* parse from string, no sign *)
        (* raises Overflow if not 0 <= n < 2^31 *)
  val toString : Word32.word -> string (* print to string, with sign *)

  val candiv : Word32.word * Word32.word -> bool
  val add_ : Word32.word * Word32.word -> Word32.word
  val sub_ : Word32.word * Word32.word -> Word32.word
  val mul_ : Word32.word * Word32.word -> Word32.word
  val div_ : Word32.word * Word32.word -> Word32.word
  val mod_ : Word32.word * Word32.word -> Word32.word
  val and_ : Word32.word * Word32.word -> Word32.word
  val or_  : Word32.word * Word32.word -> Word32.word
  val xor_ : Word32.word * Word32.word -> Word32.word
  val lsh_ : Word32.word * Word32.word -> Word32.word
  val rsh_ : Word32.word * Word32.word -> Word32.word
  val lt_  : Word32.word * Word32.word -> bool
  val lte_ : Word32.word * Word32.word -> bool
  val gt_  : Word32.word * Word32.word -> bool
  val gte_ : Word32.word * Word32.word -> bool
  val eq_  : Word32.word * Word32.word -> bool
  val neq_ : Word32.word * Word32.word -> bool
end

structure Word32Signed :> WORD32_SIGNED =
struct
  val TMIN = Word32.<<(Word32.fromInt(1), Word.fromInt(Word32.wordSize-1))
  val TMAX = Word32.-(TMIN, Word32.fromInt(1))
  val ZERO = Word32.fromInt(0)
  fun neg w = Word32.>(w, TMAX)

  (* fromString does not allow leading "-" *)
  fun fromString s = case StringCvt.scanString (Word32.scan StringCvt.DEC) s
                       of SOME i => if i > TMIN then raise Overflow else SOME i
                        | NONE   => NONE

  (* fromHexString does not allow leading "-" *)
  fun fromHexString s = StringCvt.scanString (Word32.scan StringCvt.HEX) s

  fun toString (w) =
      if neg w then "-" ^ Word32.fmt StringCvt.DEC (Word32.~(w))
      else Word32.fmt StringCvt.DEC w

  fun abs w = if neg w then (~w, true) else (w, false)
  fun xor (b1, b2) = (b1 andalso (not b2)) orelse ((not b1) andalso b2)
  fun mask w = Word.fromInt (Word32.toInt (Word32.andb (w, Word32.fromInt 31)))
  fun candiv (w1, w2) =
        not (w1 = TMIN andalso w2 = ~(Word32.fromInt 1)) andalso w2 <> ZERO

  val add_ = Word32.+
  val sub_ = Word32.-
  val and_ = Word32.andb
  val or_  = Word32.orb
  val xor_ = Word32.xorb
  val lsh_ = Word32.<<

  fun lsh_ (w1, w2) = Word32.<< (w1, mask w2)
  fun rsh_ (w1, w2) = Word32.~>> (w1, mask w2)

  fun eq_ ws = (Word32.compare ws = EQUAL)
  fun neq_ ws = (Word32.compare ws <> EQUAL)

  fun lt_ (w1, w2) = let
        val (w1', w1neg) = abs w1
        val (w2', w2neg) = abs w2
      in
        if xor (w1neg, w2neg) then w1neg (* they're different sign *)
        else if w1neg then w2 < w1 else w1 < w2
      end
  
  fun lte_ (w1, w2) = lt_ (w1, w2) orelse (w1 = w2)

  fun gt_ ws = not (lte_ ws)

  fun gte_ ws = not (lt_ ws)

  fun mul_ (w1, w2) = let
        val (w1', w1neg) = abs w1
        val (w2', w2neg) = abs w2
      in
        if xor (w1neg, w2neg) then ~(w1' * w2') else (w1' * w2')
      end
  
  fun div_ (w1, w2) = let
        val (w1', w1neg) = abs w1
        val (w2', w2neg) = abs w2
      in
        if xor (w1neg, w2neg) then ~(w1' div w2') else (w1' div w2')
      end

  fun mod_ (w1, w2) = let
        val (w1', w1neg) = abs w1
        val (w2', w2neg) = abs w2
      in
        if w1neg then ~(w1' mod w2') else (w1' mod w2')
      end

end
