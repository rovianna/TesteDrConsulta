//
//  Streamer.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 28/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit

class Streamer {
    var id: Int = 0
    var game: String = ""
    var streamer: String = ""
    var viewers: Int = 0
    var box = Box()
    var link: String = ""
    var logo: String = ""
    
    //MARK: Streamer Parse 
    static func parseStreamerJSONData(data: Data) -> [Streamer] {
        var streamer_ = [Streamer]()
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if let streamDictionary = jsonResult as? Dictionary<String, AnyObject> {
                let streams = streamDictionary["streams"] as! [Dictionary<String, AnyObject>]
                for stream in streams {
                    let streamer = Streamer()
                    streamer.id = stream["_id"] as! Int
                    streamer.game = stream["game"] as! String
                    streamer.viewers = stream["viewers"] as! Int
                let preview = stream["preview"] as! Dictionary<String, AnyObject>
                    streamer.box.template = preview["template"] as! String
                    streamer.box.small = preview["small"] as! String
                    streamer.box.medium = preview["medium"] as! String
                    streamer.box.large = preview["large"] as! String
                let channel = stream["channel"] as! Dictionary<String,AnyObject>
                    streamer.streamer = channel["display_name"] as! String
                    streamer.link = channel["url"] as! String
                    streamer_.append(streamer)
                }
            }
        } catch let err {
            print(err)
        }
        return streamer_
    }
}
