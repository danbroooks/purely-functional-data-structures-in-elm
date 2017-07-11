module FPWarmup exposing
  ( digitsOfInt
  , additivePersistence, digitalRoot
  , subsequences
  , take
  )

import List exposing (foldr)

digitsOfInt : Int -> List Int
digitsOfInt n =
  if n < 0 then []
  else if n < 10 then [n]
  else (digitsOfInt <| n // 10) ++ [n % 10]

additivePersistence : Int -> Int
additivePersistence n =
  if n < 10 then 0
  else 1 + (additivePersistence (sumDigits n))

digitalRoot : Int -> Int
digitalRoot n =
  if n < 0 then 0
  else if n < 10 then n
  else digitalRoot (sumDigits n)

sumDigits : Int -> Int
sumDigits = foldr (+) 0 << digitsOfInt

subsequences : List a -> List (List a)
subsequences xs =
  case xs of
    [] -> [[]]
    (h :: t) -> (List.map ((::) h) <| subsequences t) ++ (subsequences t)

take : Int -> List a -> Result String (List a)
take k xs =
  if k > 0 then
    case xs of
      [] -> Err "not enough elements"
      (h :: t) -> case (take (k - 1) t) of
        Ok ys -> Ok (h :: ys)
        x -> x
  else if k < 0 then
    Err "negative index"
  else
    Ok []
