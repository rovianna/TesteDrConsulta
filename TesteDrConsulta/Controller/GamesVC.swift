//
//  GamesVC.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 27/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit
import SDStateTableView

/* Classe Principal
 API com os jogos mais visualizados no momento.
 Filtro para quantidade de jogos, mínimo de 10 (com base na documentação),
 máximo de 100 jogos, limitado pela documentação.
 Ao escolher um dos jogos, seguirá para uma descrição.
 */

class GamesVC: UIViewController {
    
    //MARK: Variables
    var dataService = DataService.instance
    private let refreshControl = UIRefreshControl()
    let myAttribute = [NSAttributedStringKey.foregroundColor : UIColor.white]
    let myFilter = FilterVC(frame: CGRect(x: 10, y: 100, width: 300, height: 310))
    
    //MARK: Outlets
    @IBOutlet weak var gamesTV: SDStateTableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    //MARK: View Loads
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let index = self.gamesTV.indexPathForSelectedRow {
            self.gamesTV.deselectRow(at: index, animated: true)
        }
        self.loadTwitchTops()
        self.loadNavigation()
        saveUserDefaults()
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
    
    
    //MARK: Load Custom Navigation Options
    func loadNavigation(){
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "filter.png"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(newFilter(_:)), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        
        self.navigationItem.rightBarButtonItem = item1
        
        self.navigationItem.title = "Top Games"
    }
    
    //MARK: Own Methods
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
    
    //MARK: Segue Prep
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailLoadSegue" {
            let instanceDesc = segue.destination as! GameDetailVC
            instanceDesc.game = sender as? Game
        }
    }
    
    //MARK: Filter View Options
    @objc func newFilter(_ sender: UIButton) {
        myFilter.addShadow()
        myFilter.distanceLabel.text = LIMIT_DEFAULT
        myFilter.distanceSlider.value = Float(LIMIT_DEFAULT)!
        myFilter.saveButton.addTarget(self, action: #selector(updateFilter(_:)), for: .touchUpInside)
        myFilter.sharedTextButton.addTarget(self, action: #selector(shareTextAction(_:)), for: .touchUpInside)
        myFilter.sharedJsonButton.addTarget(self, action: #selector(shareJSONAction(_:)), for: .touchUpInside)
        self.view.addSubview(myFilter)
        myFilter.translatesAutoresizingMaskIntoConstraints = false
        let centerHorizontally = NSLayoutConstraint(item: myFilter, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerVertically = NSLayoutConstraint(item: myFilter, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activate([centerVertically, centerHorizontally])
        NSLayoutConstraint(item: myFilter, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 300).isActive = true
        NSLayoutConstraint(item: myFilter, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 310).isActive = true

        SELECTABLE = false
    }
    
    //MARK: Share Methods
    //MARK: - Share Text
    func modelToText(games: [Game]) -> [String] {
        var game_: [String] = []
        for game in games {
            var gamesString: String = ""
            gamesString += "Jogo: \(game.name), Posição: \(game.position), Espectadores: \(game.viewers). \n"
            game_.append(gamesString)
        }
        return game_
    }
    @objc func shareTextAction(_ sender: UIButton){
        let shareText = modelToText(games: dataService.games)
        let activityViewController = UIActivityViewController(activityItems: shareText, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    //MARK: - Share JSON
    @objc func shareJSONAction(_ sender: UIButton){
        print("OK Share JSON")
    }
    
    //MARK: - Update Filter
    @objc func updateFilter(_ sender: UIButton){
        LIMIT_DEFAULT = "\(Int(myFilter.distanceSlider.value))"
        myFilter.removeFromSuperview()
        self.loadTwitchTops()
        SELECTABLE = true
    }
    
    //MARK: - Pull to Refresh
    @objc func refreshGameData(_ sender: Any){
        loadTwitchTops()
    }
}

//MARK: Table View Extension
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
        if SELECTABLE {
            performSegue(withIdentifier: "detailLoadSegue", sender: dataService.games[indexPath.row])
        }
    }
    
    
}
