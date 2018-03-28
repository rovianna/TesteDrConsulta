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
let GET_TWITCHTOP_URL = "https://api.twitch.tv/kraken/games/top?limit=\(LIMIT_DEFAULT)"
let LIMIT_DEFAULT = "25"
let BASE_TWITCH_GAMES = "https://www.twitch.tv/directory/game"
