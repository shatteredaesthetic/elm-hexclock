module Styles exposing (..)


type alias Attr =
    ( String, String )


(=>) =
    (,)


containerStyle : List Attr
containerStyle =
    [ "width" => "100vw"
    , "height" => "100vh"
    , "background" => "#b5b5b7"
    , "flex-direction" => "column"
    , "border-box" => "none"
    ]


analogClockStyle : List Attr
analogClockStyle =
    [ "background" => "#677077"
    , "width" => "70vh"
    , "height" => "70vh"
    , "margin-top" => "5px"
    ]


analogRowStyle : List Attr
analogRowStyle =
    [ "flex" => "1 0 auto"
    , "flex-direction" => "column"
    ]


analogCellStyle : List Attr
analogCellStyle =
    [ "flex" => "1 0 auto" ]


buttonStyle : List Attr
buttonStyle =
    [ "border-radius" => "50%"
    , "width" => "80%"
    , "height" => "80%"
    ]


cellOnStyle : List Attr
cellOnStyle =
    [ "background" => "#f2b632"
    , "box-shadow" => "inset 1px -1px 2px #b5b5b7"
    ]


cellOffStyle : List Attr
cellOffStyle =
    [ "background" => "#252839"
    , "box-shadow" => "inset -1px 1px 2px #b5b5b7"
    ]


digitalCellStyle : List Attr
digitalCellStyle =
    [ "background" => "#e3e3e3"
    , "flex" => "1 0 auto"
    , "box-shadow" => "inset -2px 2px 2px #252839"
    ]


digitalInnerStyle : List Attr
digitalInnerStyle =
    [ "font-family" => "Arial Black"
    , "font-size" => "7em"
    , "color" => "#252839"
    , "text-shadow" => "2px -2px 2px #b5b5b7"
    ]


digitalClockStyle : List Attr
digitalClockStyle =
    [ "width" => "70vh"
    , "height" => "20vh"
    , "border" => "1px solid #333"
    , "margin-bottom" => "5px"
    ]


flexStyle : List Attr
flexStyle =
    [ "display" => "flex"
    ]


centerStyle : List Attr
centerStyle =
    [ "justify-content" => "center"
    , "align-items" => "center"
    ]
