module Squares exposing (main)

import Browser
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Color exposing (Color) 
import Html exposing (Html)
import Html.Attributes exposing (style)

view : Html msg
view =
    let
        width = 500
        height = 300
    in
        Canvas.toHtml (width, height)
            []
            [ shapes [ fill Color.black ] [ rect (0, 0) width height ]
            , renderSquare Color.blue (10,10) 25
            ]


renderSquare color ((x,y) as topLeftCorner) sideLength =
    shapes [ fill color ]
        [ rect topLeftCorner sideLength sideLength ]

main = view