module Grid exposing (..)
import Array as A
import List
import Canvas exposing (Renderable)

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