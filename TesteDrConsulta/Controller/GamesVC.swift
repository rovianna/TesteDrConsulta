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
    private let refreshControl = UIRefreshControl()
    let myAttribute = [NSAttributedStringKey.foregroundColor : UIColor.white]
    
    @IBOutlet weak var gamesTV: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadNavigation(){
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "filter.png"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(newFilter(_:)), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        
        self.navigationItem.rightBarButtonItem = item1
        
        self.navigationItem.title = "Top Games"
    }
    
    
    
    func loadTwitchTops(){
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
        self.loadTwitchTops()
        self.loadNavigation()
        if #available(iOS 10.0, *){
            gamesTV.refreshControl = refreshControl
        } else {
            gamesTV.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshGameData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        refreshControl.attributedTitle = NSAttributedString(string: "Carregando Jogos", attributes: myAttribute)
    }
    
    @objc func newFilter(_ sender: UIButton) {
        let myFilter = FilterVC(frame: CGRect(x: 10, y: 100, width: 320, height: 224))
        self.view.addSubview(myFilter)
    }
    
    @objc func refreshGameData(_ sender: Any){
        dataService.getTwitchTopGames { (Success) in
            if Success {
                OperationQueue.main.addOperation {
                    self.gamesTV.reloadData()
                    self.refreshControl.endRefreshing()
                    self.activityIndicatorView.stopAnimating()
                }
            } else {
                
            }
        }
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
