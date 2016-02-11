module Bubble
    ( Model
    , Action (Animate)
    , noAnimation, fadeInAnimation, setToFadeIn, setToFadeOut, isFadedOut
    , setOpacity
    , setToResize, cancelFinishedResize
    , targetSize
    , make
    , update, view
    ) where

import Constants exposing
    ( Tag
    , maxBubbleOpacity
    , transitionDuration
    )
import Context exposing (Context)
import Colours exposing (pickBaseColour, pickTextColour)
import Label
import Status exposing (Action(Overlay, NoOverlay))

import Time exposing (Time)
import Maybe exposing (withDefault)
import Svg exposing 
    ( Svg
    , circle, text, text', foreignObject, g
    )
import Svg.Attributes exposing
    ( cx, cy, r, fill, opacity
    , x, y, textAnchor, alignmentBaseline, fontSize
    )
import Html
import Html.Attributes
import Html.Events
import Svg.Events exposing (onClick, onMouseOver, onMouseOut)
import Signal exposing (message)
import Easing exposing (ease, linear, float)

type alias Model =
    { id : String
    , x : Float
    , y : Float
    , dx : Float
    , dy : Float
    , size : Float
    , label : String
    , animation : Animation
    }

type alias Animation =
    { fadeStart : Maybe Time  -- Time if the fading has started
    , fading : Fading         -- How it's fading, if it is to fade
    , opacity : Float         -- Current opacity
    , resizeStart : Maybe Time  -- Time if resizing has started
    , resizing : Resizing       -- How it's resizing, if it is to resize
    }

-- Fading from and to an opacity, or not fading

type Fading = Fading Float Float | NotFading

type Resizing = Resizing Float Float | NotResizing

type Action = Animate Time

type SubAction
    = Move
        | Fade Time
        | Resize Time

-- Fading functions

noAnimation : Animation
noAnimation =
    { fadeStart = Nothing
    , fading = NotFading
    , opacity = maxBubbleOpacity
    , resizeStart = Nothing
    , resizing = NotResizing
    }

fadeInAnimation : Animation
fadeInAnimation =
    { fadeStart = Nothing
    , fading = Fading 0.0 maxBubbleOpacity
    , opacity = 0.0
    , resizeStart = Nothing
    , resizing = NotResizing
    }

setToFadeIn : Model -> Model
setToFadeIn model =
    let
        animation = model.animation
        fromOpacity =
            case animation.fading of
                Fading from to -> animation.opacity
                NotFading -> 0.0
    in
        { model
        | animation =
            { animation
            | fadeStart = Nothing
            , fading = Fading fromOpacity maxBubbleOpacity
            }
        }

setToFadeOut : Model -> Model
setToFadeOut model =
    let
        animation = model.animation
        fromOpacity =
            case animation.fading of
                Fading from to -> animation.opacity
                NotFading -> maxBubbleOpacity
    in
        { model
        | animation =
            { animation
            | fadeStart = Nothing
            , fading = Fading fromOpacity 0.0
            }
        }

isFadedOut : Model -> Bool
isFadedOut model =
    case model.animation.fading of
        Fading from to ->
            (to == 0.0) && (model.animation.opacity == 0.0)
        NotFading ->
            False

setOpacity : Float -> Model -> Model
setOpacity opacity model =
    let
        animation = model.animation
    in
        { model
        | animation =
            { animation
            | opacity = opacity
            }
        }

-- Resizing functions

setToResize : Float -> Model -> Model
setToResize size model =
    let
        animation = model.animation
    in
        { model
        | animation = { animation | resizing = Resizing model.size size }
        }

cancelFinishedResize : Model -> Model
cancelFinishedResize model =
    let
        animation = model.animation
        resizing = animation.resizing
        cancel =
            case resizing of
                NotResizing -> False
                Resizing from to -> to == model.size
    in
        if cancel then
            { model
            | animation =
                { animation
                | resizeStart = Nothing
                , resizing = NotResizing
                }
            }
        else
            model

-- What size should a bubble be?

targetSize : Model -> Float
targetSize model =
    case model.animation.resizing of
        NotResizing -> model.size
        Resizing from to -> to

-- Making a basic bubble

make : Tag -> Float -> Model
make tag size =
    { id = tag.id
    , x = 0.0 , y = 0.0
    , dx = 0.0 , dy = 0.0
    , size = size
    , label = tag.webTitle
    , animation = noAnimation
    }

-- Update the model

update : Action -> Model -> Model
update (Animate time) model =
    model
        |> subUpdate Move
        |> subUpdate (Fade time)
        |> subUpdate (Resize time)
 
subUpdate : SubAction -> Model -> Model
subUpdate subAction model =
    case subAction of
        Move ->
            { model | x = model.x + model.dx, y = model.y + model.dy }
        Fade time ->
            { model
            | animation = updateFade model.animation time
            }
        Resize time ->
            updateResize model time

updateFade : Animation -> Time -> Animation
updateFade animation time =
    case animation.fading of
        NotFading -> animation
        Fading from to ->
            let
                fadeStart = animation.fadeStart |> withDefault time
                elapsed = time - fadeStart
                opacity = ease linear float from to transitionDuration elapsed
            in
                { animation
                | fadeStart = Just fadeStart
                , opacity = opacity
                }

updateResize : Model -> Time -> Model
updateResize model time =
    case model.animation.resizing of
        NotResizing -> model
        Resizing from to ->
            let
                animation = model.animation
                resizeStart = animation.resizeStart |> withDefault time
                elapsed = time - resizeStart
                size = ease linear float from to transitionDuration elapsed
            in
                { model
                | size = size
                , animation = { animation | resizeStart = Just resizeStart }
                }

view : Context Action -> Model -> Svg
view context model =
    let
        tag = Tag model.id model.label
        workaroundForChromeTextClick =
            Html.Events.onClick context.click tag
        onClickAttr = onClick (message context.click tag)
        onMouseOutAttr =
            onMouseOut (message context.status NoOverlay)
        onMouseOverAttr =
            onMouseOver (message context.status (Overlay tag.webTitle))
        labelHalfWidth = model.size * 0.85
        labelHalfHeight = model.size * 0.50
        labelCharWidth = 2 * labelHalfWidth |> Label.pixelsToChars
        fontPercent = Label.fontScaling model.label labelCharWidth
            |> Label.toPercent
        textDiv =
            Html.div
            [ Html.Attributes.style
                [ ("position", "relative")
                , ("top", "50%")
                , ("transform", "translateY(-50%)")
                , ("text-align", "center")
                , ("color", (pickTextColour model.label))
                , ("font-family", "Arial, Helvetica, sans-serif")
                , ("font-size", fontPercent)
                , ("opacity", (model.animation.opacity |> toString))
                ]
            , workaroundForChromeTextClick
            ]
            [ text model.label ]
        foreignObjectAttrs =
            [ Svg.Attributes.x (toString (model.x - labelHalfWidth))
            , Svg.Attributes.y (toString (model.y - labelHalfHeight))
            , Svg.Attributes.width  (toString (2 * labelHalfWidth))
            , Svg.Attributes.height (toString (2 * labelHalfHeight))
            -- Required here as a foreign object doesn't pick up the SVG events
            , onClickAttr
            , onMouseOverAttr
            , onMouseOutAttr
            ]
        baseCircleAttrs =
            [ cx (toString model.x)
            , cy (toString model.y)
            , r (toString model.size)
            , fill (pickBaseColour model.label)
            , opacity (model.animation.opacity |> toString)
            ]
        coveringCircleAttrs' =
            [ cx (toString model.x)
            , cy (toString model.y)
            , r (toString model.size)
            , opacity "0"
            , onClickAttr
            , onMouseOverAttr
            , onMouseOutAttr
            ]
    in
        g []
        [ circle baseCircleAttrs []
        , foreignObject foreignObjectAttrs [ textDiv ]
        , circle coveringCircleAttrs' []
        ]

