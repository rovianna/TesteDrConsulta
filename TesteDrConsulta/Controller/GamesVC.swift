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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailLoadSegue" {
            let instanceDesc = segue.destination as! GameDetailVC
            instanceDesc.game = sender as? Game
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gamesTV.delegate = self
        self.gamesTV.dataSource = self
        self.navigationController?.title = "Top Games"
    }
}

extension GamesVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = Bundle.main.loadNibNamed("GamesTableCell", owner: self, options: nil)?.first as! GamesTableCell
        cell.configureCell(game: dataService.games[indexPath.row])
        cell.positionLabel.text = "#\(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = Bundle.main.loadNibNamed("GamesTableCell", owner: self, options: nil)?.first as! GamesTableCell
        return cell.frame.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailLoadSegue", sender: dataService.games[indexPath.row])
    }
    
    
}
