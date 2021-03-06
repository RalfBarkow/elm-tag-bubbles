module PairCounter exposing
  ( Counter
  , emptyCounter, countOf, inc, incPair, set, size
  , topN
  , allPairs
  , maxCount, minCount
  , missingPairs, includeMissingPairs
  , toDict
  )

import Constants exposing (Idable)
import List exposing (append, reverse, take, filter, sortBy, member, foldl)
import Maybe exposing (withDefault)
import Dict exposing (Dict, empty, get, insert, toList, fromList)


-- Something that tracks counts of pairs of records which have a String id.
-- The order of pairs doesn't matter, so setting or getting x,y is the
-- same as that operation on y,x.

type Counter = Counter (Dict (String, String) Int)


emptyDict : Dict (String, String) Int
emptyDict = empty


emptyCounter : Counter
emptyCounter = Counter emptyDict


-- Return the count of the given pair

countOf : Idable a -> Idable a -> Counter -> Int
countOf x y (Counter dict) =
  dict |> get (x.id, y.id) |> withDefault 0


-- Increment a counter.
-- Incrementing x,y will also increment y,x

inc : Idable a -> Idable a -> Counter -> Counter
inc x y counter =
  counter
  |> inc_ x y
  |> inc_ y x


inc_ : Idable a -> Idable a -> Counter -> Counter
inc_ x y (Counter dict as counter) =
  dict
  |> insert (x.id, y.id) (countOf x y counter + 1)
  |> Counter


-- Increment a counter using one pair.
-- Incrementing x,y will also increment y,x

incPair : (Idable a, Idable a) -> Counter -> Counter
incPair pair counter =
  inc (Tuple.first pair) (Tuple.second pair) counter


-- Set a count for a particular pair.

set : Idable a -> Idable a -> Int -> Counter -> Counter
set x y val counter =
  set_ x.id y.id val counter


set_ : String -> String -> Int -> Counter -> Counter
set_ x y val counter =
  counter
  |> set__ x y val
  |> set__ y x val


set__ : String -> String -> Int -> Counter -> Counter
set__ x y val (Counter dict) =
  dict
  |> insert (x, y) val
  |> Counter


-- Find the number of pairs (ignoring symmetry) in the counter.

size : Counter -> Int
size (Counter dict) =
  Dict.size dict // 2


-- Find all the pairs whose elements are represented in the counter
-- which which don't have a count associated with them

missingPairs : Counter -> List (String, String)
missingPairs (Counter dict) =
  let
      keys = Dict.keys dict
      elts = compileElements keys
      pairs = allPairs elts
  in
      filter (\e -> not(member e keys)) pairs


compileElements : List (a, a) -> List a
compileElements pairs =
  addUniquely pairs []


addUniquely : List (a, a) -> List a -> List a
addUniquely pairs accum =
  case pairs of
    head :: tail ->
        addOneUniquely (Tuple.first head) accum
            |> addOneUniquely (Tuple.second head)
            |> addUniquely tail

    [] ->
      reverse accum


addOneUniquely : a -> List a -> List a
addOneUniquely elt list =
  if (member elt list) then
    list
  else
    elt :: list


-- Include in a counter all the missing pairs (and give them a count of zero).

includeMissingPairs : Counter -> Counter
includeMissingPairs dict =
  let
      missing = missingPairs dict
      include pair dict_ = set_ (Tuple.first pair) (Tuple.second pair) 0 dict_
  in
      foldl (\pair dict_ -> include pair dict_) dict missing


-- Reduce this counter to one of at most `n` pairs, including only
-- the pairs with largest counts.

topN : Int -> Counter -> Counter
topN n (Counter dict) =
  dict
  |> toList
  |> filter (\((x,y),i) -> x < y)
  |> sortBy (\((x,y),i) -> -i)
  |> take n
  |> mirror []
  |> fromList
  |> Counter


-- Go from [ ((x,y),i), ... ]
--      to [ ((x,y),i), ((y,x),i), ... ]

type alias PairCount = ((String, String), Int)


mirror : List PairCount -> List PairCount -> List PairCount
mirror countsOut countsIn =
  case countsIn of
    ((x,y),i) :: tl ->
      mirror ( ((x,y),i) :: ((y,x),i) :: countsOut ) tl

    [] ->
      countsOut


-- Get all pairs (ignoring symmetry) of elements of a list.
-- It comes out in a predictable order (the order the numbers appear in
-- the original list) but that's implemented only for the convenience
-- of testing.

allPairs: List a -> List (a, a)
allPairs list =
  allPairs_ (reverse list) [] []


allPairs_ : List a -> List a -> List (a, a) -> List (a, a)
allPairs_ next done accum =
  case next of
    hd :: tl ->
      allPairs_ tl (hd :: done) (append (distribute hd done) accum)

    [] ->
      accum


-- Distribute a seed across others to create pairs.
-- E.g. distribute 7 [1,2,3] == [(7,1), (7,2), (7,3)]

distribute : a -> List a -> List (a, a)
distribute seed others =
  List.map (\other -> (seed, other)) others


{-| Get the greatest count of all the pairs, or 0 if there are none.
-}

maxCount : Counter -> Int
maxCount (Counter dict) =
  Dict.values dict |> List.maximum |> withDefault 0


{-| Get the least count of all the pairs, or 0 if there are none.
-}

minCount : Counter -> Int
minCount (Counter dict) =
  Dict.values dict |> List.minimum |> withDefault 0


{-| Convert the counter to a dictionary. Each key is an id (string) pair;
    each value is its count. Each id pair is represented twice - with the
    ids both ways round.
-}

toDict : Counter -> Dict (String, String) Int
toDict (Counter dict) =
  dict


