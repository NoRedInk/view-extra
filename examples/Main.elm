module Main exposing (main)

import Html exposing (..)
import View exposing (..)

justStuff : Maybe Int
justStuff =
  Just 3


nothingStuff : Maybe Int
nothingStuff =
  Nothing


main : Html msg
main =
  div []
    [ viewJust (toString >> text) justStuff
    , viewIf (text "hey") True
    , viewMaybe viewValue viewError nothingStuff
    ]


viewValue : Int -> Html msg
viewValue value =
  text <| "value" ++ toString value


viewError : Html msg
viewError =
  text "Error"
