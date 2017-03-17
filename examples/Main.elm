module Main exposing (main)

import Html exposing (..)
import View.Utils exposing (..)

justStuff : Maybe Int
justStuff =
  Just 3


nothingStuff : Maybe Int
nothingStuff =
  Nothing


main : Html msg
main =
  div []
    [ div [] [ viewJust viewValue justStuff ]
    , div [] [ viewIf (text "is true") True ]
    , div [] [ viewMaybe viewValue viewError nothingStuff ]
    ]


viewValue : Int -> Html msg
viewValue value =
  text <| "value: " ++ toString value


viewError : Html msg
viewError =
  text "is error"
