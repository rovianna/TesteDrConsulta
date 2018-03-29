//
//  Constants.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 27/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit

typealias callback = (_ success: Bool) -> ()
let client_id = "38fpvmn9c12eceohdf0dcaf8x4huwj"
let GET_TWITCHBASE_URL = "https://api.twitch.tv/kraken"
let GET_TWITCHTOP_URL = "\(GET_TWITCHBASE_URL)/games/top?limit="
let GET_TWITCHSTREAMS_URL = "\(GET_TWITCHBASE_URL)/streams/?game="
let BASE_TWITCH_GAMES = "https://www.twitch.tv/directory/game"
var LIMIT_DEFAULT = "25"
var ORDER_BY = "POPULARIDADE"
let twitch_purple = UIColor(red: 97/255, green: 63/255, blue: 161/255, alpha: 1.0)
