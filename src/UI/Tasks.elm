module UI.Tasks (address, updates, tasks) where

import UI

import Task exposing (Task)
import Signal exposing (Signal)
import Signal.Extra exposing (foldp')

-- Mailbox for tasks run by the containing system

taskBox : Signal.Mailbox UI.Action
taskBox =
    Signal.mailbox UI.NoOp

address : Signal.Address UI.Action
address =
    taskBox.address

-- A combination of external task results and our designated inputs

actionSignals : Signal UI.Action
actionSignals =
    let
        singleInputs : Signal UI.Action
        singleInputs = Signal.mergeMany UI.inputs
    in
        Signal.merge singleInputs taskBox.signal

-- A signal of updates: both the model and the tasks going out

updates : (UI.Model, UI.TaskOut) -> Signal (UI.Model, UI.TaskOut)
updates init =
    let
        updateOne : UI.Action -> (UI.Model, UI.TaskOut) -> (UI.Model, UI.TaskOut)
        updateOne action (model, _) =
            UI.update action model

        initFn : UI.Action -> (UI.Model, UI.TaskOut)
        initFn action =
            UI.update action (fst init)
    in
        foldp' updateOne initFn actionSignals

-- A signal of tasks sent out to be run

tasks : Signal UI.TaskOut -> Signal (Task () ())
tasks out =
    let
        send : Task () UI.Action -> Task () ()
        send t =
            Task.andThen t (Signal.send taskBox.address)
        get mTask =
            case mTask of
                Just task -> task
                Nothing -> Task.fail ()
    in
        out
            |> Signal.filter (\m -> m /= Nothing) Nothing
            |> Signal.map get
            |> Signal.map (Task.map UI.NewTags)
            |> Signal.map send