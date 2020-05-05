module Main exposing (..)

import Browser
import Browser.Events
import Init
import UI


main =
    Browser.element
        { init = Init.init
        , update = UI.update
        , subscriptions = subscriptions
        , view = UI.view
        }


subscriptions : UI.Model -> Sub UI.Msg
subscriptions model =
    Sub.batch
        [ Browser.Events.onAnimationFrame UI.Tick
        , Browser.Events.onResize UI.Resize
        ]
