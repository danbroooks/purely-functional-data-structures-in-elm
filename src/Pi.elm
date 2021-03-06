module Pi exposing (main)

-- Add/modify imports if you'd like. ---------------------------------

import Browser exposing (Document)
import Collage exposing (Collage, Shape, circle, filled, square, uniform)
import Collage.Layout exposing (at, empty, impose, topLeft)
import Collage.Render exposing (svg)
import Color exposing (Color, green, red, white)
import Html exposing (..)
import Json.Decode as Decode exposing (Value)
import List exposing (length)
import Random exposing (Generator, Seed, generate, initialSeed, int, map, map2)
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


multiplyPoint : Float -> Point -> Point
multiplyPoint n pt =
    { x = pt.x * n, y = pt.y * n }


type alias Model =
    { hits : List Point
    , misses : List Point
    , hitCount : Int
    , missCount : Int
    , seed : Seed
    }


size : Float
size =
    200


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
    every 10 (always Tick)


pointGenerator : Generator Point
pointGenerator =
    let
        s =
            floor (size / 5)

        genNum =
            int -s s
                |> map toFloat
    in
    map2 Point genNum genNum
        |> map (multiplyPoint 5)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick ->
            ( model, Cmd.batch [ generate FirePoint pointGenerator ] )

        FirePoint pt ->
            if pointSeen pt model then
                ( model, Cmd.batch [ generate FirePoint pointGenerator ] )
            else if pointHit pt then
                ( addHit model pt, Cmd.none )
            else
                ( addMiss model pt, Cmd.none )


pointSeen : Point -> Model -> Bool
pointSeen pt model =
    List.member pt model.hits || List.member pt model.misses


pointHit : Point -> Bool
pointHit pt =
    let
        xSq =
            abs pt.x ^ 2

        ySq =
            abs pt.y ^ 2
    in
    size > sqrt (xSq + ySq)


addHit : Model -> Point -> Model
addHit model pt =
    { model | hits = insertNew pt model.hits }


addMiss : Model -> Point -> Model
addMiss model pt =
    { model | misses = insertNew pt model.misses }


insertNew : a -> List a -> List a
insertNew x xs =
    if List.member x xs then
        xs
    else
        x :: xs


body : Model -> List (Html Msg)
body model =
    [ svg (collage model) ]


collage : Model -> Collage msg
collage model =
    board
        |> renderPoints green model.hits
        |> renderPoints red model.misses


renderPoints : Color -> List Point -> Collage msg -> Collage msg
renderPoints color pts col =
    List.foldr (renderPoint color) col pts


renderPoint : Color -> Point -> Collage msg -> Collage msg
renderPoint c pt =
    at (\_ -> ( pt.x, pt.y )) (dot c)


board : Collage msg
board =
    filled (uniform white) <| square (size * 2)


dot : Color -> Collage msg
dot c =
    filled (uniform c) (circle 3)


view : Model -> Document Msg
view model =
    { title = "Pi"
    , body = body model
    }
