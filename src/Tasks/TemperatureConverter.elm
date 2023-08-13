module Tasks.TemperatureConverter exposing (..)

import Browser
import Html exposing (Html, div, input, label, span, text)
import Html.Attributes exposing (id, type_, value)
import Html.Events exposing (onInput)
import String


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { celsius : String, fahrenheit : String }


init : Model
init =
    { celsius = "", fahrenheit = "" }


type Msg
    = SetCelsius String
    | SetFahrenheit String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetCelsius value ->
            { model
                | celsius = value
                , fahrenheit = String.toFloat value |> toFahrenheit model.fahrenheit
            }

        SetFahrenheit value ->
            { model
                | celsius = String.toFloat value |> toCelsius model.celsius
                , fahrenheit = value
            }


view : Model -> Html Msg
view model =
    div []
        [ label []
            [ input [ id "celcius", type_ "text", value model.celsius, onInput SetCelsius ] []
            , span [] [ text "Celcius" ]
            ]
        , span [] [ text "=" ]
        , label []
            [ input [ id "fahrenheit", type_ "text", value model.fahrenheit, onInput SetFahrenheit ] []
            , span [] [ text "Fahrenheit" ]
            ]
        ]


toCelsius : String -> Maybe Float -> String
toCelsius default value =
    case value of
        Nothing ->
            default

        Just fahrenheit ->
            (fahrenheit - 32) * (5 / 9) |> roundTemp


toFahrenheit : String -> Maybe Float -> String
toFahrenheit default value =
    case value of
        Nothing ->
            default

        Just celsius ->
            celsius * (9 / 5) + 32 |> roundTemp


roundTemp : Float -> String
roundTemp t =
    t
        * 10
        |> round
        |> toFloat
        |> (\x -> x / 10)
        |> String.fromFloat
