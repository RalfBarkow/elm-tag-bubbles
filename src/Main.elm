import Constants exposing (Id)
import UI
import MultiBubbles
import Bubble

import StartApp exposing (start)
import Dict exposing (Dict, empty, insert)
import Maybe exposing (Maybe(Nothing))
import Task exposing (Task)
import Effects exposing (none, Never)
import Signal

width = 800

height = 600

bubble1Model =
    { id = "us-news/us-news"
    , x = 340, y = 200
    , dx = 0, dy = 0
    , size = 180, label = "US News"
    , animation = Bubble.fadeInAnimation
    }

bubble2Model =
    { id = "uk/uk"
    , x = 300, y = 250
    ,  dx = 0, dy = 0
    , size = 100, label = "UK"
    , animation = Bubble.fadeInAnimation
    }

bubble3Model =
    { id = "society/doctors"
    , x = 480, y = 350
    , dx = 0, dy = 0
    , size = 80, label = "Doctors"
    , animation = Bubble.fadeInAnimation
    }

bubble4Model =
    { id = "football/fa-cup"
    , x = 400, y = 400
    , dx = 0, dy = 0
    , size = 120, label = "FA Cup"
    , animation = Bubble.fadeInAnimation
    }

multiBubbleModel =
    MultiBubbles.initialModel
        (width / 2)
        (height / 2)
        [ bubble1Model
        , bubble2Model
        , bubble3Model
        , bubble4Model
        ]

springs : Dict (Id, Id) Float
springs =
    Dict.empty
        |> insert ("us-news/us-news", "uk/uk") 100
        |> insert ("uk/uk", "us-news/us-news") 100
        |> insert ("us-news/us-news", "society/doctors") 150
        |> insert ("society/doctors", "us-news/us-news") 150
        |> insert ("us-news/us-news", "football/fa-cup")  75
        |> insert ("football/fa-cup", "us-news/us-news")  75
        |> insert ("uk/uk", "society/doctors") 125
        |> insert ("society/doctors", "uk/uk") 125
        |> insert ("uk/uk", "football/fa-cup") 175
        |> insert ("football/fa-cup", "uk/uk") 175
        |> insert ("society/doctors", "football/fa-cup") 200
        |> insert ("football/fa-cup", "society/doctors") 200

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

app =
    start
        { init = (model, UI.initialEffects)
        , update = UI.update
        , view = UI.view
        , inputs = UI.initialInputs
        }

main =
    app.html

port tasks : Signal (Task.Task Never())
port tasks =
    app.tasks

