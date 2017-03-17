module View.Utils exposing (viewIf, viewJust, viewMaybe, viewElementByPosition, Position(..))

{-|

# Conditional views
@docs viewIf, viewJust, viewMaybe

# Patterned views
@docs Position, viewElementByPosition

-}

import Html exposing (Html, span, text)
import Html.Attributes exposing (style)


{-| View only if condition is met.
-}
viewIf : Html msg -> Bool -> Html msg
viewIf view condition =
  if condition then
    view
  else
    text ""


{-| Hide with `display: none` if condition is not met.
-}
hideIf : Html msg -> Bool -> Html msg
hideIf view condition =
  if condition then
    span [] [ view ]
  else
    span [ style [ ( "display", "none" ) ] ] [ view ]


{-| View only if `Maybe` is a `Just`.
-}
viewJust : (a -> Html msg) -> Maybe a -> Html msg
viewJust view maybe =
  case maybe of
    Just whatever ->
      view whatever

    Nothing ->
      text ""


{-| Use a view based on the `Maybe` value.

  view : Maybe Feedback -> Html msg
  view feedback =
    div []
      [ h1 [] [ text "Feedback" ]
      , viewMaybe viewFeedback viewNoFeedbackYet feedback
      ]

-}
viewMaybe : (a -> Html msg) -> Html msg ->  Maybe a -> Html msg
viewMaybe viewValue viewError maybe =
  case maybe of
    Just whatever ->
      viewValue whatever

    Nothing ->
      viewError



-- VIEW FROM PATTERN


{-| -}
type Position
  = Singleton
  | First
  | Middle
  | Last


{-| View the first, middle and last element differently and seperately if only containing one element.
-}
viewElementByPosition : (Position -> a -> Html msg) -> List a -> List (Html msg)
viewElementByPosition viewFromPosition list =
  case list of
    [ singleton ] ->
      List.singleton (viewFromPosition Singleton singleton)

    _ ->
      let
        viewElement index element =
          if index == 0 then
            viewFromPosition First element
          else if index == List.length list - 1 then
            viewFromPosition Last element
          else
            viewFromPosition Middle element
      in
        List.indexedMap viewElement list
