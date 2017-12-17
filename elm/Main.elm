port module Main
    exposing
        ( Model
        , Msg(Convert)
        , Done
        , failed
        , init
        , mainBuilder
        , subscriptions
        )

import Json.Decode as Decode exposing (Decoder, Value)
import Platform exposing (program)


type alias Model =
    ()


type Msg
    = Convert Value


type alias Done a msg =
    a -> Cmd msg


port convert : (Value -> msg) -> Sub msg


port failed : String -> Cmd msg


subscriptions : Model -> Sub Msg
subscriptions _ =
    convert Convert


init : ( Model, Cmd Msg )
init =
    () ! []


update : Done a Msg -> Decoder a -> Msg -> Model -> ( Model, Cmd Msg )
update done decoder msg model =
    let
        (Convert value) =
            msg

        userResult =
            Decode.decodeValue Decode.string value
                |> Result.andThen (Decode.decodeString decoder)
    in
        case userResult of
            Ok user ->
                model ! [ done user ]

            Err error ->
                model ! [ failed error ]


mainBuilder : Done a Msg -> Decoder a -> Program Never Model Msg
mainBuilder done decoder =
    program
        { init = init
        , subscriptions = subscriptions
        , update = update done decoder
        }
