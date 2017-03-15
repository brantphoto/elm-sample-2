import Html exposing (..)
import Keyboard
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)

type alias Model =
  { user: User
  , userForm: User}

type alias User =
  { firstName: String
  , lastName: String
  }

type Msg =
  KeyMsg Keyboard.KeyCode
  | ChangeFirstName String
  | ChangeLastName String
  | SubmitName

main : Program Never Model Msg
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


init : (Model, Cmd Msg)
init =
  (initModel, Cmd.none)

view : Model -> Html Msg
view model =
  div [style styleMainDiv] [
    div [style styleOuterCard] [
      div [style styleInnerCard] [
          label [style styleLabel, value model.userForm.firstName, onInput ChangeFirstName ] [
            text "First Name",
            input [style styleInput] []
          ],
          label [style styleLabel, value model.userForm.lastName, onInput ChangeLastName] [
            text "LastName",
            input [style styleInput] []
          ],
          button [style styleButton, onClick SubmitName ] [
            text "CHANGE NAME"
          ]
      ]
    ],
    div [style styleOuterCard] [
      div [style styleInnerCard] [
          h1 [] [text (model.user.firstName ++ " " ++ model.user.lastName)]
      ]
    ]
  ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    KeyMsg code ->
      (model, Cmd.none)
    ChangeFirstName fieldInput ->
      ({ model | userForm = User fieldInput model.userForm.lastName } , Cmd.none)
    ChangeLastName fieldInput ->
      ({ model | userForm = User model.userForm.firstName fieldInput } , Cmd.none)
    SubmitName ->
      ({ model | user = model.userForm } , Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Keyboard.downs KeyMsg

initModel : Model
initModel =
  { user = User "Brant" "Barger"
  , userForm = User "" ""}


styleMainDiv : List (String, String)
styleMainDiv =
  [ ("height", "100%")
  , ("width", "100%")
  , ("color", "#fff")
  , ("background-color", "#F3F8F2" )
  , ("display", "flex")
  , ("justify-content", "center")
  , ("align-items", "center")
  ]

styleOuterCard : List (String, String)
styleOuterCard =
  [ ("background-color", colorSecondary)
  , ("padding", "20px")
  , ("margin", "20px")
  , ("border-radius", "15px")
  ]

styleInnerCard: List (String, String)
styleInnerCard =
  [ ("background-color", colorPrimary)
  , ("padding", "40px")
  , ("border-radius", "3px")
  , ("display", "flex")
  , ("flex-direction", "column")
  ]


styleInput : List (String, String)
styleInput =
  [ ("background", "none")
  , ("color", "#fff")
  , ("font-size", "2em")
  , ("border", "2px solid #fff")
  , ("border-radius", "3px")
  ]

styleLabel : List (String, String)
styleLabel =
  [ ("display", "flex")
  , ("flex-direction", "column")
  , ("margin", "10px")
  ]

styleButton : List (String, String)
styleButton =
  [ ("background", "none")
  , ("border", "none")
  , ("background-color", "#fff")
  , ("color", "#000")
  , ("padding", "20px")
  , ("margin", "10px")
  , ("font-size", "1em")
  , ("border-radius", "3px")
  ]

colorPrimary : String
colorPrimary = "#3581B8"

colorSecondary : String
colorSecondary = "#3581B8"
