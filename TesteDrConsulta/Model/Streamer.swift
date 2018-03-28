//
//  Streamer.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 28/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit

class Streamer {
    var id: String = ""
    var game: String = ""
    var viewers: Int = 0
    var box = Box()
    var link: String = ""
    var logo: String = ""
    
    static func parseStreamerJSONData(data: Data) -> [Streamer] {
        var streamer_ = [Streamer]()
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if let streamDictionary = jsonResult as? Dictionary<String, AnyObject> {
                let streams = streamDictionary["streams"] as! [Dictionary<String, AnyObject>]
                for stream in streams {
                let channel = stream["channel"] as! Dictionary<String,AnyObject>
                print("CHANNEL: \(channel)")
                //URL && LOGO && PROFILE_BANNER
                }
            }
        } catch let err {
            print(err)
        }
        return streamer_
    }
}
