port module Main exposing (..)

import Json.Decode as Decode exposing (Value)
import Platform exposing (program)


type Msg
    = ConvertUser Value
    | DoneConvertUser User
    | FailedConvertUser String


type alias Model =
    ()


type alias User =
    { name : String
    , tags : List Int
    }


userDecoder : Decode.Decoder User
userDecoder =
    Decode.map2 User
        (Decode.field "name" Decode.string)
        (Decode.field "tags" <| Decode.list Decode.int)


port convertUser : (Value -> msg) -> Sub msg


port doneConvertUser : User -> Cmd msg


port failedConvertUser : String -> Cmd msg


init : ( Model, Cmd Msg )
init =
    () ! []


subscriptions : Model -> Sub Msg
subscriptions _ =
    convertUser ConvertUser


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ConvertUser value ->
            let
                userResult =
                    Decode.decodeValue Decode.string value
                        |> Result.andThen (Decode.decodeString userDecoder)
            in
                case userResult of
                    Ok user ->
                        model ! [ doneConvertUser user ]

                    Err error ->
                        model ! [ failedConvertUser error ]

        _ ->
            model ! []


main : Program Never Model Msg
main =
    program
        { init = init
        , subscriptions = subscriptions
        , update = update
        }
