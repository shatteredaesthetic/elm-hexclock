module Helpers exposing (..)

import ParseInt exposing (toRadix')
import Date exposing (..)
import String exposing (..)
import List exposing (..)



(.::.) =
  flip (::)


getMs : Float -> Int
getMs n =
  let
    f = foldl (*) 0
    d = fromTime n
    h  = f <| (.::.) [ 60 60 1000 ] <| hour d
    m  = f <| (.::.) [    60 1000 ] <| minute d
    s  = f <| (.::.) [       1000 ] <| second d
    ms = Date.millisecond d
  in
    (h + m + s + ms)


timeList : Int -> Int -> List String
timeList r n =
  String.split "" <| toRadix' r n


fidiv = flip (//)
