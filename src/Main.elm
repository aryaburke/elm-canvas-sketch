module Main exposing (main)

import Browser
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Color exposing (Color) 
import Html exposing (Html)
import Html.Attributes exposing (style)
import Html exposing (div)
import Html.Attributes exposing (form)
import List
import Grid

divSides = 500
gridDimensions = 9 --x by x squares
sideLength = gridDimensions / divSides
grid = Grid.createGrid gridDimensions

offColor = Color.red

view : Html msg
view = 
    div
    [ style "display" "flex"
    , style "justify-content" "center"
    , style "align-items" "center"
    ]
    [ Canvas.toHtml 
        (divSides, divSides)
        []
        [ clearBackground
        , renderGrid
        ]
    ]

clearBackground = 
    renderSquare Color.white (0,0)

renderGrid = 
    List.map renderRow (floatList (List.range 0 gridDimensions))

renderRow rowNum =
    List.foldl (\i -> renderSquare offColor (i * sideLength, rowNum * sideLength)) (floatList (List.range 0 gridDimensions))

renderSquare color ((x,y) as topLeftCorner) =
    shapes [ fill color ] [ rect topLeftCorner sideLength sideLength ]

floatList : List (Int) -> List (Float)
floatList xs = List.map toFloat xs

main = view