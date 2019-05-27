module ListsAndTrees
    exposing
        ( Tree(..)
        , almostCompleteTrees
        , balancedTree
        , balancedTrees
        , completeTrees
        , fullTree
        , mem
        , suffixes
        )

------------------------------------------------------------------------------
-- Problem 1
------------------------------------------------------------------------------


suffixes : List a -> List (List a)
suffixes xs =
    case xs of
        _ :: t ->
            xs :: suffixes t

        [] ->
            [ xs ]



------------------------------------------------------------------------------
-- Problem 2
------------------------------------------------------------------------------


type Tree a
    = Empty
    | Node a (Tree a) (Tree a)


mem : comparable -> Tree comparable -> Bool
mem x t =
    case t of
        Node a left right ->
            case compare a x of
                EQ ->
                    True

                GT ->
                    mem x left

                LT ->
                    mem x right

        Empty ->
            False


fullTree : a -> Int -> Tree a
fullTree _ _ =
    Empty


balancedTree : a -> Int -> Tree a
balancedTree _ _ =
    Empty


create2 : a -> Int -> ( Tree a, Tree a )
create2 _ _ =
    ( Empty, Empty )


balancedTrees : a -> Int -> List (Tree a)
balancedTrees _ _ =
    []


completeTrees : a -> Int -> List (Tree a)
completeTrees _ _ =
    []


almostCompleteTrees : a -> Int -> List (Tree a)
almostCompleteTrees _ _ =
    []
