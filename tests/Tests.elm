module Tests exposing (..)

import Html exposing (Html)
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (all, style, tag, text)
import View.Extra exposing (..)


suite : Test
suite =
    describe "The View Extra module"
        [ describe "View.Extra.viewIf"
            [ test "returns blank if condition is not met" <|
                \_ ->
                    viewIf (always viewStuff) False
                        |> Query.fromHtml
                        |> Query.hasNot [ text theStuff ]
            , test "returns the stuff if condition is met" <|
                \_ ->
                    viewIf (always viewStuff) True
                        |> Query.fromHtml
                        |> Query.has [ text theStuff ]
            ]
        , describe "View.Extra.viewHiddenIf"
            [ test "returns hidden stuff if condition is not met" <|
                \_ ->
                    viewHiddenIf viewStuff False
                        |> Query.fromHtml
                        |> Query.has [ all [ style [ ( "display", "none" ) ], text theStuff ] ]
            , test "returns hidden stuff if condition is met" <|
                \_ ->
                    viewHiddenIf viewStuff True
                        |> Query.fromHtml
                        |> Query.hasNot [ style [ ( "display", "none" ) ] ]
            ]
        , describe "View.Extra.viewJust"
            [ test "returns blank if Maybe is a Nothing" <|
                \_ ->
                    viewJust viewNumberStuff Nothing
                        |> Query.fromHtml
                        |> Query.hasNot [ text (theNumberStuff 1) ]
            , test "returns the stuff if Maybe is a Just" <|
                \_ ->
                    viewJust viewNumberStuff (Just 1)
                        |> Query.fromHtml
                        |> Query.has [ text (theNumberStuff 1) ]
            ]
        , describe "View.Extra.viewMaybe"
            [ test "returns nothing view if Maybe is a Nothing" <|
                \_ ->
                    viewMaybe viewNumberStuff (always viewNothingStuff) Nothing
                        |> Query.fromHtml
                        |> Query.has [ text nothing ]
            , test "returns just view if Maybe is a Just" <|
                \_ ->
                    viewMaybe viewNumberStuff (always viewNothingStuff) (Just 1)
                        |> Query.fromHtml
                        |> Query.has [ text (theNumberStuff 1) ]
            ]
        , describe "View.Extra.viewIfElements"
            [ test "returns blank if list is empty" <|
                \_ ->
                    viewIfElements (always viewStuff) []
                        |> Query.fromHtml
                        |> Query.hasNot [ text theStuff ]
            , test "returns the stuff if list has elements" <|
                \_ ->
                    viewIfElements (always viewStuff) [ "stuff" ]
                        |> Query.fromHtml
                        |> Query.has [ text theStuff ]
            ]
        ]



-- HELPERS


viewStuff : Html msg
viewStuff =
    Html.text theStuff


theStuff : String
theStuff =
    "the stuff"


viewNumberStuff : Int -> Html msg
viewNumberStuff number =
    Html.text <| theNumberStuff number


theNumberStuff : Int -> String
theNumberStuff number =
    "the stuff" ++ toString number


viewNothingStuff : Html msg
viewNothingStuff =
    Html.text nothing


nothing : String
nothing =
    "nothing"
