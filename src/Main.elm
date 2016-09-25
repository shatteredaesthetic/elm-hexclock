module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, style)
import Html.App as App
import Time exposing (Time)
import Date exposing (fromTime, hour, minute, second)
import List
import String
import List.Split exposing (chunksOfLeft)
import ParseInt exposing (toRadix')
import Styles exposing (..)


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subs
        }


subs : Model -> Sub Msg
subs model =
    Time.every (1318 * Time.millisecond) Tick


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )


type Msg
    = Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            let
                curr =
                    getMs newTime
                        |> fidiv 1318
            in
                ( curr, Cmd.none )


view : Model -> Html Msg
view model =
    let
        body =
            if model == 0 then
                [ h1 [ styleList [] ] [ text "Loading..." ]
                , h3 [] [ text "Your time will be available shortly" ]
                ]
            else
                [ digitalView model
                , analogView model
                ]
    in
        body
            |> div
                [ class "container"
                , styleList [ flexStyle, centerStyle, containerStyle ]
                ]


digitalView : Int -> Html Msg
digitalView t =
    timeList 16 t
        |> List.map digitalCellView
        |> div
            [ class "digtal-clock"
            , styleList [ flexStyle, digitalClockStyle ]
            ]


digitalCellView : String -> Html Msg
digitalCellView ch =
    div
        [ class "digital-cell"
        , styleList [ flexStyle, centerStyle, digitalCellStyle ]
        ]
        [ div [ style digitalInnerStyle ] [ text ch ] ]


analogView : Int -> Html Msg
analogView t =
    timeList 2 t
        |> List.map analogCellView
        |> chunksOfLeft 4
        |> List.map analogRowView
        |> div
            [ class "analog-clock"
            , styleList [ flexStyle, analogClockStyle ]
            ]


analogCellView : String -> Html Msg
analogCellView ch =
    let
        cellState =
            if ch == "1" then
                cellOnStyle
            else
                cellOffStyle
    in
        div
            [ class "analog-cell"
            , styleList [ flexStyle, centerStyle, analogCellStyle ]
            ]
            [ div [ styleList [ flexStyle, buttonStyle, cellState ] ] [] ]


analogRowView : List (Html Msg) -> Html Msg
analogRowView xs =
    xs
        |> div
            [ class "analog-row"
            , styleList [ flexStyle, analogRowStyle ]
            ]


styleList : List (List Attr) -> Attribute Msg
styleList lists =
    style <| List.concat lists


fidiv : Int -> Int -> Int
fidiv =
    flip (//)


timeList : Int -> Int -> List String
timeList r n =
    String.split "" <| toRadix' r n


(.::.) : List a -> a -> List a
(.::.) =
    flip (::)


getMs : Float -> Int
getMs n =
    let
        f =
            List.foldl (*) 1

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
