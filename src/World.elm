module World exposing
  ( Model
  , Msg (..)
  , ViewBox
  , size, viewBox, viewBoxToString
  , update, view
  )


import Constants exposing
  ( Id, Tags
  , maxBubbles
  , minBubbleSize, maxBubbleSize
  , minSpringLength, maxSpringLength
  , springStrength)
import MultiBubbles as MB
import Bubble exposing (fadeInAnimation)
import Springs exposing (toCounter, acceleration, accelDict)
import Sizes
import TagFetcher
import Out
import Util

import String
import Dict exposing (Dict)
import Html exposing (Html)
import Html.Attributes exposing (id)
import Svg exposing (svg)
import Svg.Attributes as SVGA exposing (width, height, viewBox)
import Time exposing (Posix)


type alias Model =
  { bubbles : MB.Model
  , springs : Dict (Id,Id) Float
  -- Maybe the system has told us our dimensions
  , dimensions : Maybe (Int, Int)
  , scale : Float
  }


type Msg
  = ToMultiBubbles MB.Msg
  | Tick Posix
  | NewTags (List Tags)
  | Recentre
  | Resize Int Int
  | Scale Float


type alias ViewBox =
  { minX : Float
  , minY : Float
  , width : Float
  , height : Float
  }


update : Msg -> Model -> (Model, Out.Msg)
update action model =
  case action of
    ToMultiBubbles act ->
      let
          (bubsMod, outMsg) = MB.update act model.bubbles
      in
          ( { model | bubbles = bubsMod }
          , outMsg
          )

    Tick time ->
      let
          strength = springStrength
          accelFn = acceleration strength model.springs
          bubbles = model.bubbles
          accels = accelDict bubbles accelFn
          (bubsMod, _) = MB.update (MB.AdjustVelocities accels) bubbles
          model_ = { model | bubbles = bubsMod }
      in
          update (ToMultiBubbles (MB.Tick time)) model_

    NewTags listListTag ->
      case model.dimensions of
        Just dimensions ->
          ( newTags listListTag dimensions model
          , Out.None
          )

        Nothing ->
          (model, Out.None)

    Recentre ->
      case model.dimensions of
        Just dims ->
          ( { model | bubbles = MB.recentre model.bubbles dims }
          , Out.None
          )

        Nothing ->
          (model, Out.None)

    Resize width height ->
      let
          newDims = size width height
          newBubbles =
            case model.dimensions of
              Just oldDims ->
                MB.forNewDimensions oldDims newDims model.bubbles
              Nothing ->
                MB.recentre model.bubbles newDims
      in
          ( { model
            | dimensions = Just newDims
            , bubbles = newBubbles
            }
          , Out.None
          )

    Scale factor ->
      ( { model | scale = factor }
      , Out.None
      )


-- Introduce new tags to the model

newTags : List Tags -> (Int, Int) -> Model -> Model
newTags listListTag (width, height) model =
  let
      listListTag_ =
        listListTag
        |> Sizes.topN maxBubbles
        |> Sizes.filter listListTag
      springs =
        Springs.toCounter listListTag_
        |> Springs.toDictWithZeros minSpringLength maxSpringLength
      tags = Sizes.idDict listListTag_ |> Dict.values
      bubbles =
        Sizes.toDict listListTag_
        |> Sizes.rescale minBubbleSize maxBubbleSize
        |> MB.make tags
  in
      { model
      | bubbles =
          MB.initialArrangement (toFloat width / 2) (toFloat height / 2) model.bubbles bubbles
      , springs = springs
      }
 

-- Work out the size of the world based on the window's dimensions

size : Int -> Int -> (Int, Int)
size winWidth winHeight =
  let
      -- World's width with borders
      fullyBorderedWidth = winWidth - 2 * Constants.sideBorderWidth
      -- Reduced borders if less than the preferred min width
      idealWidth = max fullyBorderedWidth Constants.minWorldWidth
      -- Constrained to window width
      width = min winWidth idealWidth
      height = winHeight - Constants.navHeight - Constants.statusBarHeight
  in
      (width, height)


-- Calculating values for an svg view box

viewBox : (Int, Int) -> Float -> ViewBox
viewBox dims scale =
  let
      winWidth = Tuple.first dims |> toFloat
      winHeight = Tuple.second dims |> toFloat
      minX = 0.5 * (winWidth - winWidth / scale)
      minY = 0.5 * (winHeight - winHeight / scale)
      width = winWidth / scale
      height = winHeight / scale
  in
      ViewBox minX minY width height


viewBoxToString : ViewBox -> String
viewBoxToString vb =
  String.fromFloat vb.minX ++ " " ++
  String.fromFloat vb.minY ++ " " ++
  String.fromFloat vb.width ++ " " ++
  String.fromFloat vb.height


-- The view
-- The world might not yet have got its dimensions, so we have two cases

view : Model -> Html Msg
view model =
  case model.dimensions of
    Just dims -> viewWithDimensions dims model
    Nothing -> viewNoDimensions


viewNoDimensions : Html Msg
viewNoDimensions =
  svg [] []


viewWithDimensions : (Int, Int) -> Model -> Html Msg
viewWithDimensions (wdth, hght) model =
  svg
    [ id "world"
    , width (wdth |> String.fromInt)
    , height (hght |> String.fromInt)
    , SVGA.viewBox (viewBox (wdth, hght) model.scale |> viewBoxToString)
    ]
    -- (MB.view (forwardTo context ToMultiBubbles) model.bubbles)
    (MB.view model.bubbles |> List.map (Svg.map ToMultiBubbles))

