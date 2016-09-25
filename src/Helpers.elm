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
        f =
            List.foldl (*) 0

        d =
            fromTime n

        h =
            hour d
                |> (.::.) [ 60, 60, 1000 ]
                |> f

        m =
            minute d
                |> (.::.) [ 60, 1000 ]
                |> f

        s =
            second d
                |> (.::.) [ 1000 ]
                |> f

        ms =
            Date.millisecond d
    in
        (h + m + s + ms)


timeList : Int -> Int -> List String
timeList r n =
    String.split "" <| toRadix' r n


fidiv =
    flip (//)
