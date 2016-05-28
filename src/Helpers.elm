module Helpers exposing (..)

import ParseInt exposing (toRadix')
import Date exposing (..)
import String exposing (..)

getMs : Float -> Int
getMs n =
  let
    d =
      fromTime n
    h =
      hour d * (60 * 60 * 1000)
    m =
      minute d * (60 * 1000)
    s =
      second d * 1000
    ms =
      Date.millisecond d
  in
    (h + m + s + ms)


timeList : Int -> Int -> List String
timeList r n =
  String.split "" <| toRadix' r n


fidiv = flip (//)
