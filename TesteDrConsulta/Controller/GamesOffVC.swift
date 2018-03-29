//
//  GamesOffVC.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 29/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit
import SDStateTableView

/*
 Classe para a lista offline.
 Será gerada a ultima lista salva em UserDefaults.
 Caso não tenha, será mostrado a informação na tela.
 */

class GamesOffVC: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var gamesVC: SDStateTableView!
    
    //MARK: Properties
    let defaults = UserDefaults.standard
    var myOffGames: [[String:Any]] = []
    
    //MARK: View Loads
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getGames { (Success) in
            if Success {
                OperationQueue.main.addOperation {
                    self.gamesVC.setState(.dataAvailable)
                }
            } else {
                OperationQueue.main.addOperation {
                    self.gamesVC.setState(.withImage(image: "error.png", title: "Vazio!", message: "Você ainda não tem uma lista!"))
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gamesVC.delegate = self
        self.gamesVC.dataSource = self
    }
    
    //MARK: Own Methods
    func getGames(completion: @escaping callback){
        self.gamesVC.setState(.loading(message: "Carregando Jogos"))
        let myNewGames = defaults.array(forKey: "myGames") as? [[String:Any]]
        guard let myGames = myNewGames else {
            completion(false)
            return
        }
        myOffGames = myGames
        if !(myOffGames.isEmpty){
            self.gamesVC.reloadData()
            completion(true)
        } else {
            self.gamesVC.reloadData()
            completion(false)
        }
    }
    
}

//MARK: Extension Table View
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
