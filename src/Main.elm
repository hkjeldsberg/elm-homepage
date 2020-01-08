module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Url



---- MODEL ----


type alias Model =
    { value : Int
    , key : Nav.Key
    , url : Url.Url
    }


initialModel : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
initialModel flags url key =
    ( Model 0 key url, Cmd.none )



---- UPDATE ----


type Msg
    = Increment
    | Decrement
    | Home
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | value = model.value + 1 }, Cmd.none )

        Decrement ->
            ( { model | value = model.value - 1 }, Cmd.none )

        LinkClicked _ ->
            ( { model | value = model.value - 1 }, Cmd.none )

        UrlChanged _ ->
            ( { model | value = model.value - 1 }, Cmd.none )

        Home ->
            ( model, Nav.load "/" )



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    { title = "Homepage"
    , body =
        [ header [ class "header" ]
            [ h1 [ onClick Home ] [ text "Henrik Kjeldsberg" ]
            , div [] [ text ("Number is " ++ String.fromInt model.value) ]
            , div []
                [ button [ onClick Decrement ] [ text "-" ]
                , text (String.fromInt model.value)
                , button [ onClick Increment ] [ text "+" ]
                ]
            ]
        , div [ class "container" ] []
        , footer [ class "footer" ] []
        ]
    }



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.application
        { init = initialModel
        , view = view
        , update = update
        , subscriptions = \model -> Sub.none
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }
