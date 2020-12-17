module Grid exposing (..)
import Array as A
import List

type alias Cell = Bool
type alias Grid = A.Array (A.Array Cell)

--creation functions

createGrid : Int -> Grid
createGrid sides = A.repeat sides (createRow sides)

createRow : Int -> A.Array Cell
createRow sides = A.repeat sides False

--read functions
getCell : (Int, Int) -> Grid -> Maybe Cell
getCell (x,y) g = 
    case A.get y g of
        Just row ->
            case A.get x row of
                Just cell -> Just cell
                Nothing -> Nothing
        Nothing -> Nothing

--returns the grid unchanged if (x,y) can't be found
switchCell : (Int, Int) -> Grid -> Grid
switchCell (x,y) g =
    case A.get y g of
        Just row -> case A.get x row of
            Just cell -> A.set y (A.set x (not cell) row) g
            Nothing -> g
        Nothing -> g