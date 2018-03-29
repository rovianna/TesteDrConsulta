//
//  GamesOffVC.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 29/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit
import SDStateTableView

class GamesOffVC: UIViewController {

    @IBOutlet weak var gamesVC: SDStateTableView!
    
    let defaults = UserDefaults.standard
    var myOffGames: [[String:Any]] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let myNewGames = defaults.array(forKey: "myGames") as? [[String: Any]]
        guard let myGames = myNewGames else {
            return
        }
        myOffGames = myGames
        self.gamesVC.reloadData()
        if !(myOffGames.isEmpty) {
            self.gamesVC.setState(.dataAvailable)
        } else {
            self.gamesVC.setState(.withImage(image: "error.png", title: "Vazio!", message: "Você ainda não tem nenhuma lista atualizada!"))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gamesVC.delegate = self
        self.gamesVC.dataSource = self
    }
    
    func getGames(completion: @escaping callback){
        self.gamesVC.setState(.loading(message: "Carregando Jogos"))
        
    }
    
}

extension GamesOffVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myOffGames.count == 0 {
            self.gamesVC.separatorStyle = .none
        } else {
            self.gamesVC.separatorStyle = .singleLine
        }
        
        return myOffGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("GamesTableCell", owner: self, options: nil)?.first as! GamesTableCell
        cell.configureOffCell(game: myOffGames[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = Bundle.main.loadNibNamed("GamesTableCell", owner: self, options: nil)?.first as! GamesTableCell
        return cell.frame.height
    }
    
    
}
