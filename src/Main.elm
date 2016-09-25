module Main exposing (..)

import String exposing (..)
import List exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class, style)
import Html.App as App
import Time exposing (Time)
import List.Split exposing (chunksOfLeft)
import Styles exposing (..)
import Helpers exposing (..)


main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    Time


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- UPDATE


type Msg
    = Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        Tick newTime ->
            ( newTime, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every (1318 * Time.millisecond) Tick



-- VIEW


view : Model -> Html Msg
view model =
    let
        curr =
            fidiv 1318 <| getMs model

        style' =
            List.concat [ flexStyle, centerStyle, containerStyle ]
    in
        div
            [ class "container"
            , style style'
            ]
            [ digitalView curr
            , analogView curr
            ]



-- DIGITAL


digitalView : Int -> Html Msg
digitalView t =
    let
        curr =
            timeList 16 t

        style' =
            List.concat [ flexStyle, digitalClockStyle ]

        clock =
            List.map digitalCellView curr
    in
        div [ style style' ] <| clock


digitalCellView : String -> Html Msg
digitalCellView ch =
    div
        [ class "digital-cell"
        , style <| List.concat [ flexStyle, centerStyle, digitalCellStyle ]
        ]
        [ div [ style digitalInnerStyle ] [ text ch ]
        ]



-- ANALOG


analogView : Int -> Html Msg
analogView t =
    let
        curr =
            timeList 2 t

        clock =
            List.map analogRowView <|
                chunksOfLeft 4 <|
                    List.map analogCellView curr

        style' =
            List.concat [ flexStyle, analogClockStyle ]
    in
        div [ style style' ] <| clock


analogCellView : String -> Html Msg
analogCellView ch =
    let
        cellState =
            if ch == "1" then
                cellOnStyle
            else
                cellOffStyle

        cStyle =
            List.concat [ flexStyle, centerStyle, analogCellStyle ]

        bStyle =
            List.concat [ flexStyle, buttonStyle, cellState ]
    in
        div
            [ class "analog-cell"
            , style cStyle
            ]
            [ div [ style bStyle ] [] ]


analogRowView : List (Html Msg) -> Html Msg
analogRowView xs =
    let
        style' =
            List.concat [ flexStyle, analogRowStyle ]
    in
        div
            [ class "analog-row"
            , style style'
            ]
        <|
            xs
