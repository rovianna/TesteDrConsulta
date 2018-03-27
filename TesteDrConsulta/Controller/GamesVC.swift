//
//  GamesVC.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 27/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit

class GamesVC: UIViewController {
    
    var dataService = DataService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataService.getTwitchTopGames { (Success) in
            if Success {
                OperationQueue.main.addOperation {
                    print("DEV: \(self.dataService.games.count)")
                }
            } else {
                
            }
        }
        
    }
}
