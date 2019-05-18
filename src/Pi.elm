module Pi exposing (main)

-- Add/modify imports if you'd like. ---------------------------------

import Html exposing (Html)
import Random exposing (Generator, Seed)
import Time


----------------------------------------------------------------------


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Point =
    { x : Float, y : Float }


type alias Model =
    { hits : List Point
    , misses : List Point
    , hitCount : Int
    , missCount : Int
    , seed : Seed
    }


type Msg
    = Tick


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    Debug.crash "TODO"


subscriptions : Model -> Sub Msg
subscriptions model =
    Debug.crash "TODO"


pointGenerator : Generator Point
pointGenerator =
    Debug.crash "TODO"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    Debug.crash "TODO"


view : Model -> Html Msg
view model =
    Debug.crash "TODO"
