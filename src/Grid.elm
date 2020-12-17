module Grid exposing (..)
import List

type alias Cell = Bool
type alias Grid = List (List Cell)

createGrid : Int -> Grid
createGrid sides = List.map (\x -> createRow sides) (List.range 1 sides)

createRow : Int -> List Bool
createRow sides = List.map (\x -> False) (List.range 1 sides)