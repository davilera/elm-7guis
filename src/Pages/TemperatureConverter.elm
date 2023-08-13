module Pages.TemperatureConverter exposing (Model, Msg, page)

import Gen.Params.TemperatureConverter exposing (Params)
import Page
import Request
import Shared
import Tasks.TemperatureConverter as Task
import View exposing (View)


type alias Model =
    Task.Model


type alias Msg =
    Task.Msg


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page _ _ =
    Page.sandbox
        { init = Task.init
        , update = Task.update
        , view = view
        }


view : Model -> View Msg
view model =
    { title = "Temperature Converter"
    , body = [ Task.view model ]
    }
