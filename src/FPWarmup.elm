module FPWarmup
    exposing
        ( additivePersistence
        , digitalRoot
        , digitsOfInt
        , subsequences
        , take
        )

import List exposing (foldr, length)


digitsOfInt : Int -> List Int
digitsOfInt n =
    if n < 0 then
        []
    else if n < 10 then
        [ n ]
    else
        (digitsOfInt <| n // 10) ++ [ modBy n 10 ]


additivePersistence : Int -> Int
additivePersistence n =
    if n < 10 then
        0
    else
        1 + additivePersistence (sumDigits n)


digitalRoot : Int -> Int
digitalRoot n =
    if n < 0 then
        0
    else if n < 10 then
        n
    else
        digitalRoot (sumDigits n)


sumDigits : Int -> Int
sumDigits =
    foldr (+) 0 << digitsOfInt


subsequences : List a -> List (List a)
subsequences xs =
    case xs of
        [] ->
            [ [] ]

        h :: t ->
            (List.map ((::) h) <| subsequences t) ++ subsequences t


take : Int -> List a -> Result String (List a)
take k xs =
    if length xs < k then
        Err "not enough elements"
    else if k < 0 then
        Err "negative index"
    else
        Ok (List.take k xs)
