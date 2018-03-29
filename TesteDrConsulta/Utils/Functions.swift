//
//  Functions.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 29/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit

/*
 Função para salvar a lista de Games localmente.
 */
func saveUserDefaults(){
    let dataService = DataService.instance
    let defaults = UserDefaults.standard
    
    let games = dataService.games
    var myGames : [[String : Any]] = []
    for game in games {
        myGames.append(["id": game.id, "name": game.name, "viewers": game.viewers, "position": game.position, "channels": game.channels, "popularity": game.popularity, "small_logo": game.logo.small, "small_box": game.box.small, "large_logo": game.logo.large])
    }
    defaults.set(myGames, forKey: "myGames")
}
