module Bubble exposing
  ( Model
  , Message (..)
  , noAnimation, fadeInAnimation, setToFadeIn, setToFadeOut, isFadedOut
  , setOpacity
  , setToResize, cancelFinishedResize
  , targetSize
  , make
  , linearEase
  , update, view
  )

import Constants exposing
  ( maxBubbleOpacity
  , transitionDuration
  )
import Out
import Colours exposing (pickBaseColour)
import Label
import Status
import Util

import Time exposing (Posix)
import Maybe exposing (withDefault)
import Svg exposing 
  ( Svg
  , circle, text, foreignObject, g
  )
import Svg.Attributes exposing (cx, cy, r, fill, opacity)
import Svg.Events exposing (onClick, onMouseOver, onMouseOut)


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
  { fadeStart : Maybe Posix  -- Time that fading starting, if the fading has started
  , fading : Fading         -- How it's fading, if it is to fade
  , opacity : Float         -- Current opacity
  , resizeStart : Maybe Posix  -- Time that resizing started, if resizing has started
  , resizing : Resizing       -- How it's resizing, if it is to resize
  }


-- Fading from and to an opacity, or not fading

type Fading = Fading Float Float | NotFading


type Resizing = Resizing Float Float | NotResizing


type Message
  = Animate Posix
  | StatusMsg Status.Msg
  | RequestTag Constants.Tag


type SubAction
  = Move
  | Fade Posix
  | Resize Posix


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

make : Constants.Tag -> Float -> Model
make tag size =
  { id = tag.id
  , x = 0.0 , y = 0.0
  , dx = 0.0 , dy = 0.0
  , size = size
  , label = tag.webTitle
  , animation = noAnimation
  }


-- Update the model

update : Message -> Model -> (Model, Out.Msg)
update msg model =
  case msg of
    Animate time ->
      model
      |> subUpdate Move
      |> subUpdate (Fade time)
      |> subUpdate (Resize time)
      |> Util.pairWith Out.None

    StatusMsg sMsg ->
      (model, Out.StatusMsg sMsg)

    RequestTag tag ->
      (model, Out.RequestTag tag)
 
 
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

-- Calculate a point on a linear scale.
-- 'from' and 'to' are our start and end points.
-- Our input is the 'now' value, in the range 0 to 'max_'.
-- Our output is the appropriate point in the from-to range.

linearEase : Float -> Float -> Float -> Float -> Float
linearEase from to max_ now =
  (now / max_) * (to - from) + from
  |> min (max from to)
  |> max (min from to)


updateFade : Animation -> Posix -> Animation
updateFade animation time =
  case animation.fading of
    NotFading ->
      animation

    Fading from to ->
      let
          fadeStart = animation.fadeStart |> withDefault time
          elapsed = (Time.posixToMillis time) - (Time.posixToMillis fadeStart) |> toFloat
          opacity = linearEase from to transitionDuration elapsed
      in
          { animation
          | fadeStart = Just fadeStart
          , opacity = opacity
          }


updateResize : Model -> Posix -> Model
updateResize model time =
  case model.animation.resizing of
    NotResizing ->
      model

    Resizing from to ->
      let
          animation = model.animation
          resizeStart = animation.resizeStart |> withDefault time
          elapsed = (Time.posixToMillis time) - (Time.posixToMillis resizeStart) |> toFloat
          size = linearEase from to transitionDuration elapsed
      in
          { model
          | size = size
          , animation = { animation | resizeStart = Just resizeStart }
          }


view : Model -> Svg Message
view model =
  let
      x = model.x
      y = model.y
      tag = Constants.Tag model.id model.label
      -- onClickAttr = onClick (message context.click tag)
      labelWidth = 2 * model.size * 0.85
      textDiv =
        Label.view model.label x y labelWidth model.animation.opacity
      baseCircleAttrs =
        [ cx (String.fromFloat x)
        , cy (String.fromFloat y)
        , r (String.fromFloat model.size)
        , fill (pickBaseColour model.label)
        , opacity (model.animation.opacity |> String.fromFloat)
        ]
      coveringCircleAttrs =
        [ cx (String.fromFloat x)
        , cy (String.fromFloat y)
        , r (String.fromFloat model.size)
        , opacity "0"
        , onClick (RequestTag tag)
        , onMouseOver (StatusMsg (Status.Rollover tag.webTitle))
        , onMouseOut (StatusMsg Status.NoRollover)
        ]
  in
      g
      [ Svg.Attributes.class "bubble" ]
      [ circle baseCircleAttrs []
      , textDiv
      , circle coveringCircleAttrs []
      ]


