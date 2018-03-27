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
    
    @IBOutlet weak var gamesTV: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        dataService.getTwitchTopGames { (Success) in
            if Success {
                OperationQueue.main.addOperation {
                    self.gamesTV.reloadData()
                }
            } else {
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gamesTV.delegate = self
        self.gamesTV.dataSource = self
    }
}

extension GamesVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = Bundle.main.loadNibNamed("GamesTableCell", owner: self, options: nil)?.first as! GamesTableCell
        cell.configureCell(game: dataService.games[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = Bundle.main.loadNibNamed("GamesTableCell", owner: self, options: nil)?.first as! GamesTableCell
        return cell.frame.height
    }
    
    
}
