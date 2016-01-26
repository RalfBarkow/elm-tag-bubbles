module UI.Setup (model, effects) where

import Constants exposing
    ( Id, Tag
    , minBubbleSize, maxBubbleSize
    , minSpringLength, maxSpringLength
    )
import UI
import MultiBubbles
import PairCounter exposing (emptyCounter, incPair)
import Springs
import Bubble

import Dict exposing (Dict, empty, insert)
import Effects exposing (Effects)

-- Initial model

width = 800

height = 600

tags =
    [ Tag "uk/uk" "UK"
    , Tag "world/world" "World"
    , Tag "politics/politics" "Politics"
    , Tag "sport/sport" "Sport"
    , Tag "football/football" "Football"
    , Tag "culture/culture" "Culture"
    , Tag "business/business" "Business"
    , Tag "lifeandstyle/lifeandstyle" "Life and style"
    , Tag "environment/environment" "Environment"
    , Tag "technology/technology" "Technology"
    , Tag "travel/travel" "Travel"
    ]

size = (minBubbleSize + maxBubbleSize) / 2

multiBubbleModel : MultiBubbles.Model
multiBubbleModel =
    tags
        |> List.map (\bubble -> Bubble.make bubble size)
        |> List.map (Bubble.setOpacity 0.0)
        |> List.map Bubble.setToFadeIn
        |> MultiBubbles.arrangeCentre (width/2) (height/2)

allPairs : List (Tag, Tag)
allPairs = PairCounter.allPairs tags

springs : Dict (Id, Id) Float
springs =
    List.foldl incPair emptyCounter allPairs
        |> Springs.toDictWithZeros minSpringLength maxSpringLength

model : UI.Model
model =
    { width = width
    , height = height
    , world =
        { bubbles = multiBubbleModel
        , springs = springs
        }
    , status = "Welcome"
    }

-- Initial effects

effects : Effects UI.Action
effects =
    Effects.none
