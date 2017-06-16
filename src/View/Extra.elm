module View.Extra exposing (viewHiddenIf, viewIf, viewIfElements, viewJust, viewMaybe)

{-|


# Conditional views

@docs viewIf, viewHiddenIf, viewJust, viewMaybe, viewIfElements

-}

import Html exposing (Html, span, text)
import Html.Attributes exposing (style)


{-| View only if condition is met.
-}
viewIf : (() -> Html msg) -> Bool -> Html msg
viewIf view condition =
    if condition then
        view ()
    else
        text ""


{-| Add `display: none` to view if condition is _not_ met.
-}
viewHiddenIf : Html msg -> Bool -> Html msg
viewHiddenIf view condition =
    if condition then
        span [] [ view ]
    else
        span [ style [ ( "display", "none" ) ] ] [ view ]


{-| View value of if `Maybe` is a `Just`, otherwise show nothing.
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
            , viewMaybe viewFeedback viewPlaceholder feedback
            ]

-}
viewMaybe : (a -> Html msg) -> (() -> Html msg) -> Maybe a -> Html msg
viewMaybe viewValue viewError maybe =
    case maybe of
        Just whatever ->
            viewValue whatever

        Nothing ->
            viewError ()


{-| View if resulting list has elements.
-}
viewIfElements : (() -> Html msg) -> List b -> Html msg
viewIfElements view list =
    if List.isEmpty list then
        text ""
    else
        view ()
