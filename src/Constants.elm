module Constants
    ( Id, Idable
    , Tag, Tags, TagsResult
    , maxBubbles, bubbleLabelFontSize
    , minBubbleSize, maxBubbleSize
    , minSpringLength, maxSpringLength
    , maxBubbleOpacity, transitionDuration
    , springStrength, airDragFactor, minimumVelocity
    ) where

import Http exposing (Error)
import Time exposing (Time)
import Signal

type alias Id = String

type alias Idable a = { a | id : String }

type alias Tag = { id : Id, webTitle : String }

type alias Tags = List Tag

type alias TagsResult = Result Http.Error (List Tags)

maxBubbles : Int
maxBubbles = 10

bubbleLabelFontSize : String
bubbleLabelFontSize = "25pt"

minBubbleSize : Float
minBubbleSize = 50.0

maxBubbleSize : Float
maxBubbleSize = 150.0

minSpringLength : Float
minSpringLength = 150.0

maxSpringLength : Float
maxSpringLength = 350.0

maxBubbleOpacity : Float
maxBubbleOpacity = 0.75

transitionDuration : Time
transitionDuration = Time.second

springStrength : Float
springStrength = 25.0

airDragFactor : Float
airDragFactor = 0.04

minimumVelocity : Float
minimumVelocity = 0.1

