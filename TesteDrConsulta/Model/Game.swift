//
//  Game.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 27/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import Foundation

let url = Bundle.main.url(forResource: "data", withExtension: "json")

class Game {
    var name: String = ""
    var popularity: Int = 0
    var id: Int = 0
    var giantbomb_id: Int = 0
    var box = Box()
    var logo = Logo()
    var links : [String] = []
    var localized_name: String = ""
    var locale: String = ""
    var viewers: Int = 0
    var channels: Int = 0
    var position: Int = 0
    
    static func parseGameJSONData(data: Data) -> [Game] {
        var games_ = [Game]()
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if let gamesDictionary = jsonResult as? Dictionary<String, AnyObject> {
                var position = 1
                let games = gamesDictionary["top"] as! [Dictionary<String,AnyObject>]
                for game in games {
                    let game_ = Game()
                    let viewers = game["viewers"] as! Int
                    game_.viewers = viewers
                    let channels = game["channels"] as! Int
                    game_.channels = channels
                    let topGames = game["game"] as! Dictionary<String, AnyObject>
                    game_.name = topGames["name"] as! String
                    game_.popularity = topGames["popularity"] as! Int
                    game_.id = topGames["_id"] as! Int
                    let boxImg = topGames["box"] as! Dictionary<String, AnyObject>
                    game_.box.large = boxImg["large"] as! String
                    game_.box.medium = boxImg["medium"] as! String
                    game_.box.small = boxImg["small"] as! String
                    let logoImg = topGames["logo"] as! Dictionary<String, AnyObject>
                    game_.logo.large = logoImg["large"] as! String
                    game_.logo.medium = logoImg["medium"] as! String
                    game_.logo.small = logoImg["small"] as! String
                    game_.giantbomb_id = topGames["giantbomb_id"] as! Int
                    game_.position = position
                    games_.append(game_)
                    position += 1
                }
            }
        } catch let err {
            print(err)
        }
        return games_
    }
    
    static func sortGameArrayData(game: [Game], order_by: String) -> [Game]{
        var games_ = game
        
        if order_by == "POPULARIDADE"{
            games_ = games_.sorted(by: {$0.viewers > $1.viewers})
        } else {
            games_ = games_.sorted(by: {$0.name < $1.name})
        }
        
        return games_
    }

    
}
