module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { count : Int
    , content : String
    , name : String
    , password : String
    , passwordAgain: String
    }


init : Model
init =
    {
    count = 0
    , content = ""
    , name = ""
    , password = ""
    , passwordAgain = ""
    }



-- UPDATE


type Msg
    = Increment
    | Decrement
    | Reset
    | Change String
    | Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }

        Reset ->
            Model 0 "" "" "" ""

        Change newContent ->
            { model | content = newContent }

        Name name ->
            { model | name = name }

        Password pass ->
            { model | password = pass}

        PasswordAgain passAgain ->
            { model | passwordAgain = passAgain}


-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div []
              [ button [ onClick Decrement ] [ text "-" ]
              , div [] [ text (String.fromInt model.count) ]
              , button [ onClick Increment ] [ text "+" ]
              , button [ onClick Reset ] [ text "reset" ]
              , input [ placeholder "Text to reverse", value model.content, onInput Change ] []
              , div [] [ text (String.reverse model.content) ]
              ]
          , div []
              [ viewInput "text" "Name" model.name Name
              , viewInput "password" "Password" model.password Password
              , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
              , viewValidation model
              ]
        ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []

viewValidation : Model -> Html msg
viewValidation model =
  if model.password == model.passwordAgain then
    div [ style "color" "green" ] [ text "OK" ]
  else
    div [ style "color" "red" ] [ text "Passwords do not match!" ]
