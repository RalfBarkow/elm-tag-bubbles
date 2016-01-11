module UI where

-- Bubble forms captured as Html

import Constants exposing (TagsResult)
import Context exposing (CountedClick (NoClick, SingleClick, DoubleClick))
import World
import TagFetcher

import Html exposing (Html, div, text)
import Svg exposing (svg)
import Svg.Attributes exposing (width, height, viewBox)
import Signal exposing (forwardTo)
import Effects exposing (Effects)

type alias Model =
    { width : Int
    , height : Int
    , world : World.Model
    , newTags : TagsResult
    }

type Action
    = Resize (Int, Int)
        | Direct World.Action
        | Tick
        | NewTags TagsResult
        | Click CountedClick

initialEffects : Effects Action
initialEffects =
    Effects.none

countedClicks : Signal Action
countedClicks =
    Context.mappedCountedClicks Click

update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
        Resize (w, h) ->
            ({ model | width = w, height = h }
             , Effects.none
            )
        Direct act ->
            ({ model | world = World.update act model.world }
             , Effects.none
            )
        Tick ->
            ({ model | world = World.update World.Tick model.world }
             , Effects.none
            )
        NewTags tags ->
            ({ model | newTags = tags }
             , Effects.none
            )
        Click clicker ->
            case clicker of
                NoClick ->
                    ( model, Effects.none )
                SingleClick _ ->
                    ( model, Effects.none )
                DoubleClick tag ->
                    ( model
                    , Effects.map NewTags (TagFetcher.getTags tag)
                    )

view : Signal.Address Action -> Model -> Html
view address model =
    div []
    [ svgView address model
    , text (toString model.newTags)
    ]

svgView : Signal.Address Action -> Model -> Html
svgView address model =
    let
        context = Context.create (Signal.forwardTo address Direct)
    in
        svg
            [ width (toString model.width)
            , height (toString model.height)
            ]
            (World.view context model.world)

