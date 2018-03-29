//
//  GamesVC.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 27/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit
import SDStateTableView

class GamesVC: UIViewController {
    
    var dataService = DataService.instance
    private let refreshControl = UIRefreshControl()
    let myAttribute = [NSAttributedStringKey.foregroundColor : UIColor.white]
    
    @IBOutlet weak var gamesTV: SDStateTableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let index = self.gamesTV.indexPathForSelectedRow {
            self.gamesTV.deselectRow(at: index, animated: true)
        }
        self.loadTwitchTops()
        self.loadNavigation()
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
        self.gamesTV.setState(.loading(message: "Carregando Jogos"))
        dataService.getTwitchTopGames(limit: LIMIT_DEFAULT) { (Success) in
            if Success {
                OperationQueue.main.addOperation {
                    if self.dataService.games.count > 0 {
                    self.gamesTV.setState(.dataAvailable)
                    self.gamesTV.reloadData()
                    self.refreshControl.endRefreshing()
                    self.activityIndicatorView.stopAnimating()
                    } else {
                        self.gamesTV.setState(.withButton(errorImage: "error.png", title: "Vazio!", message: "Não foi encontrado nenhum jogo", buttonTitle: "Tentar Novamente", buttonConfig: { (button) in
                            self.refreshControl.endRefreshing()
                            self.activityIndicatorView.stopAnimating()
                        }, retryAction: {
                            self.loadTwitchTops()
                        }))
                    }
                }
            } else {
                OperationQueue.main.addOperation {
                    self.gamesTV.setState(.withButton(errorImage: "error.png", title: "Oh não!", message: "Houve um erro inesperado. Tente novamente mais tarde.", buttonTitle: "Tentar Novamente", buttonConfig: { (button) in
                        
                    }, retryAction: {
                        self.loadTwitchTops()
                    }))
                }
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
        if dataService.games.count == 0 {
            self.gamesTV.setState(.withButton(errorImage: "error.png", title: "Vazio!", message: "Não foi encontrado nenhum jogo", buttonTitle: "Tentar Novamente", buttonConfig: { (button) in
                
            }, retryAction: {
                self.loadTwitchTops()
            }))
        }
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
        let myFilter = FilterVC(frame: CGRect(x: 10, y: 100, width: 300, height: 276))
        myFilter.distanceLabel.text = LIMIT_DEFAULT
        myFilter.distanceSlider.value = Float(LIMIT_DEFAULT)!
        self.view.addSubview(myFilter)
    }
    
    @objc func refreshGameData(_ sender: Any){
       loadTwitchTops()
    }
}

extension GamesVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataService.games.count > 0 {
            self.gamesTV.separatorStyle = .singleLine
        } else {
            self.gamesTV.separatorStyle = .none
        }
        return dataService.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("GamesTableCell", owner: self, options: nil)?.first as! GamesTableCell
        if ORDER_BY == "POPULARIDADE" {
            cell.configureCell(game: dataService.games[indexPath.row])
        } else {
            cell.configureCell(game: dataService.games[indexPath.row])
        }
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
