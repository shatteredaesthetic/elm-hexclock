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

type alias Model = Time


init : (Model, Cmd Msg)
init =
  (0, Cmd.none)


-- UPDATE

type Msg
  = Tick Time


update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    Tick newTime ->
      (newTime, Cmd.none)



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
    styl =
      List.concat [ flexStyle, centerStyle, containerStyle ]
  in
    div
      [ class "container"
      , style styl
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
    styl =
      List.concat [ flexStyle, digitalClockStyle ]
    clock =
      List.map digitalCellView curr
  in
    div [ style styl ] <| clock


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
      List.map analogRowView
        <| chunksOfLeft 4
        <| List.map analogCellView curr
    styl =
      List.concat [ flexStyle, analogClockStyle ]
  in
    div [ style styl ] <| clock


analogCellView : String -> Html Msg
analogCellView ch =
  let
    cellState =
      if ch == "1" then cellOnStyle else cellOffStyle
    cStyl =
      List.concat [ flexStyle, centerStyle, analogCellStyle ]
    bStyl =
      List.concat [ flexStyle, buttonStyle, cellState ]
  in
    div
      [ class "analog-cell"
      , style cStyl
      ] [ div [ style bStyl ] [] ]


analogRowView : List (Html Msg) -> Html Msg
analogRowView xs =
  let
    styl =
      List.concat [ flexStyle, analogRowStyle ]
  in
    div
      [ class "analog-row"
      , style styl
      ]
      <| xs
