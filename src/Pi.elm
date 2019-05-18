module Pi exposing (main)

-- Add/modify imports if you'd like. ---------------------------------

import Browser exposing (Document)
import Html exposing (..)
import Json.Decode as Decode exposing (Value)
import Random exposing (Generator, Seed, float, initialSeed, map2)
import String exposing (fromInt)
import Time exposing (every)
import Url exposing (Url)


----------------------------------------------------------------------


main : Program Value Model Msg
main =
    Browser.document
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


init : flags -> ( Model, Cmd Msg )
init _ =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { hits = []
    , misses = []
    , hitCount = 0
    , missCount = 0
    , seed = initialSeed 3333
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    every 1000 (always Tick)


pointGenerator : Generator Point
pointGenerator =
    map2 Point (float 0 20) (float 0 20)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick ->
            ( { model | hitCount = model.hitCount + 1 }, Cmd.none )


body : Model -> List (Html Msg)
body model =
    [ text "Pi: ", text (fromInt model.hitCount) ]


view : Model -> Document Msg
view model =
    { title = "Pi"
    , body = body model
    }
