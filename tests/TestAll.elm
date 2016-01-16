module TestAll where

import TagFetcherTest exposing (all)
import PairCounterTest exposing (all)
import SpringsTest exposing (all)
import SizesTest exposing (all)
import WorldTest exposing (all)

import Graphics.Element exposing (Element)
import ElmTest exposing (elementRunner, suite)


main : Element
main = 
    elementRunner
        (suite "All tests"
            [ TagFetcherTest.all
            , PairCounterTest.all
            , SpringsTest.all
            , SizesTest.all
            , WorldTest.all
            ]
        )
