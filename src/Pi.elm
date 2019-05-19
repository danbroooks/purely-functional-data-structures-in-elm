module Pi exposing (main)

-- Add/modify imports if you'd like. ---------------------------------

import Browser exposing (Document)
import Collage exposing (Collage, Shape, circle, filled, rectangle, uniform)
import Collage.Layout exposing (at, empty, impose, topLeft)
import Collage.Render exposing (svg)
import Color exposing (Color, green, red, white)
import Html exposing (..)
import Json.Decode as Decode exposing (Value)
import List exposing (length)
import Random exposing (Generator, Seed, float, generate, initialSeed, map2)
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
    | FirePoint Point


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
            ( model, Cmd.batch [ generate FirePoint pointGenerator ] )

        FirePoint pt ->
            ( { model | hits = pt :: model.hits }, Cmd.none )


width : Float
width =
    400


height : Float
height =
    400


body : Model -> List (Html Msg)
body model =
    [ svg (collage model) ]


collage : Model -> Collage msg
collage model =
    box
        |> draw (dot green) 0 10
        |> draw (dot red) 0 0
        |> draw (dot green) 20 15


draw : Collage msg -> Float -> Float -> Collage msg -> Collage msg
draw shape x y =
    at (\_ -> ( x - (width / 2), -y + (height / 2) )) shape


box : Collage msg
box =
    filled (uniform white) (rectangle width height)


dot : Color -> Collage msg
dot c =
    filled (uniform c) (circle 3)


view : Model -> Document Msg
view model =
    { title = "Pi"
    , body = body model
    }
