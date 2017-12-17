port module Converters.User exposing (..)

import Main
    exposing
        ( Model
        , Msg
        , Done
        , init
        , mainBuilder
        )
import Json.Decode as Decode


type alias User =
    { name : String
    , tags : List Int
    }


port done : Done User msg


main : Program Never Model Msg
main =
    mainBuilder done <|
        Decode.map2
            User
            (Decode.field "name" Decode.string)
            (Decode.field "tags" <| Decode.list Decode.int)
