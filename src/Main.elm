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
import Array as A
import Grid
import Html exposing (a)

divSides = 500
gridDimensions = 9 --x by x squares
sideLength = gridDimensions / divSides
offColor = Color.red
onColor = Color.green
grid = Grid.createGrid gridDimensions

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
        (List.append (flatten renderGrid) [ clearBackground ])
    ]

clearBackground = 
    renderSquare Color.white (0,0)

renderGrid = 
    List.map renderRow (floatList (List.range 0 gridDimensions))

renderRow rowNum =
    List.foldl (\i -> renderSquare offColor (i * sideLength, rowNum * sideLength)) [] (floatList (List.range 0 gridDimensions))

renderSquare color ((x,y) as topLeftCorner) =
    shapes [ fill color ] [ rect topLeftCorner sideLength sideLength ]

floatList : List (Int) -> List (Float)
floatList xs = List.map toFloat xs

flatten : List (List a) -> List a
flatten xs = List.foldl List.append [] xs

main = view

type alias Cell = (Bool, Renderable)
type alias Grid = A.Array (A.Array Cell)

--creation functions

createGrid : Int -> Renderable -> Grid
createGrid sides start = A.repeat sides (createRow sides start)

createRow : Int -> Renderable -> A.Array Cell
createRow sides start = A.repeat sides (False, start)

--returns Maybe True if cell is on, Maybe False if functions
cellStatus : (Int, Int) -> Grid -> Maybe Bool
cellStatus (x,y) g = 
    case A.get y g of
        Just row ->
            case A.get x row of
                Just (bool, render) -> Just bool
                Nothing -> Nothing
        Nothing -> Nothing

--returns the grid unchanged if (x,y) can't be found
setCell : (Int, Int) -> Cell -> Grid -> Grid
setCell (x,y) val g =
    case A.get y g of
        Just row -> case A.get x row of
            Just cell -> A.set y (A.set x val row) g
            Nothing -> g
        Nothing -> g