module BubbleTest exposing (all)

import Bubble exposing (..)

import Test exposing (..)
import Expect exposing (..)


all : Test
all =
    describe "BubbleTest suite"
    [ linearEaseTest
    ]


expectCloseEnough : Float -> Float -> Expectation
expectCloseEnough =
  Expect.within (Relative 0.01)


linearEaseTest : Test
linearEaseTest =
    describe "linearEaseTest"

    [ test "Mid forward: Output range 5-10, input 0-100, if we're at 50 we should output 7.5" <|
      \_ ->
        expectCloseEnough
        7.5
        (linearEase 5 10 100 50)

    , test "Mid backward: Output range 10-5, input 0-100, if we're at 50 we should output 7.5" <|
      \_ ->
        expectCloseEnough
        7.5
        (linearEase 10 5 100 50)

    , test "Start forward: Output range 2-21, input 0-30, if we're at 0 we should output 2" <|
      \_ ->
        expectCloseEnough
        2.0
        (linearEase 2 21 30 0)

    , test "Start, backward: Output range 21-2, input 0-30, if we're at 0 we should output 21" <|
      \_ ->
        expectCloseEnough
        21.0
        (linearEase 21 2 30 0)

    , test "End forward: Output range 100-101, input 0-1, if we're at 1 we should output 101" <|
      \_ ->
        expectCloseEnough
        101.0
        (linearEase 100 101 1 1)

    , test "End backward: Output range 101-100, input 0-1, if we're at 1 we should output 100" <|
      \_ ->
        expectCloseEnough
        100.0
        (linearEase 101 100 1 1)

    , test "If we go beyond the end of a forward range we should only get to the end" <|
      \_ ->
        expectCloseEnough
        20
        (linearEase 15 20 5 6)

    , test "If we are before the start of a forward range we should only be at the start" <|
      \_ ->
        expectCloseEnough
        10
        (linearEase 10 30 5 -0.5)

    , test "If we go beyond the end of a backwards range we should only get to the (lower) end" <|
      \_ ->
        expectCloseEnough
        15
        (linearEase 20 15 5 6)

    , test "If we are before the start of a backwards range we should only be at the (higher) start" <|
      \_ ->
        expectCloseEnough
        30
        (linearEase 30 10 5 -0.5)

    ]


