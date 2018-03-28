//
//  Constants.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 27/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import Foundation

typealias callback = (_ success: Bool) -> ()
let client_id = "38fpvmn9c12eceohdf0dcaf8x4huwj"
let GET_TWITCHBASE_URL = "https://api.twitch.tv/kraken"
let GET_TWITCHTOP_URL = "\(GET_TWITCHBASE_URL)/games/top?limit=\(LIMIT_DEFAULT)"
let GET_TWITCHSTREAMS_URL = "\(GET_TWITCHBASE_URL)/streams/?game="
let BASE_TWITCH_GAMES = "https://www.twitch.tv/directory/game"
let LIMIT_DEFAULT = "25"

