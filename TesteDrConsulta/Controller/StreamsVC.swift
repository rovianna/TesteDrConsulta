//
//  StreamsVCViewController.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 28/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit
import SDStateTableView

/* Classe listando os Streamers com mais visualização no jogo selecionado */

class StreamsVC: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var streamTV: SDStateTableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Variables
    var gameName: String?
    var dataService = DataService.instance
    
    private let refreshControl = UIRefreshControl()
    let myAttribute = [NSAttributedStringKey.foregroundColor : UIColor.white]
    
    //MARK: View Load
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let index = self.streamTV.indexPathForSelectedRow {
            self.streamTV.deselectRow(at: index, animated: true)
        }
        self.loadStreamers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.streamTV.delegate = self
        self.streamTV.dataSource = self
        if #available(iOS 10.0, *){
            streamTV.refreshControl = refreshControl
        } else {
            streamTV.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshStreamerData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        refreshControl.attributedTitle = NSAttributedString(string: "Carregando Streamers", attributes: myAttribute)
        self.navigationItem.backBarButtonItem?.title = " "
        self.navigationItem.title = "Streamers"
        
    }
    
    //MARK: Own Methods
    func loadStreamers() {
        self.streamTV.setState(.loading(message: "Carregando Streamers"))
        guard var game = gameName else {
            return
        }
        game = game.replacingOccurrences(of: " ", with: "%20")
        dataService.getTwitchStreamers(game: game) { (Success) in
            if Success {
                OperationQueue.main.addOperation {
                    if self.dataService.streamers.count > 0 {
                        self.streamTV.setState(.dataAvailable)
                        self.streamTV.reloadData()
                        self.refreshControl.endRefreshing()
                        self.activityIndicator.stopAnimating()
                    } else {
                        self.streamTV.setState(.withButton(errorImage: "error.png", title: "Vazio!", message: "Não foi encontrado nenhum Streamer", buttonTitle: "Tentar Novamente", buttonConfig: { (button) in
                            
                        }, retryAction: {
                            self.loadStreamers()
                        }))
                    }
                }
            } else {
                OperationQueue.main.addOperation {
                    self.streamTV.setState(.withButton(errorImage: "error.png", title: "Oh não!", message: "Houve um erro inesperado. Tente novamente mais tarde.", buttonTitle: "Tentar Novamente", buttonConfig: { (button) in
                        
                    }, retryAction: {
                        self.loadStreamers()
                    }))
                }
            }
        }
    }
    
    //MARK: Pull To Refresh
    @objc func refreshStreamerData(_ sender: Any){
        loadStreamers()
    }
}

//MARK: Extension Table View
extension StreamsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataService.streamers.count == 0 {
            self.streamTV.separatorStyle = .none
        } else {
            self.streamTV.separatorStyle = .singleLine
        }
        return dataService.streamers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("StreamTableCell", owner: self, options: nil)?.first as! StreamTableCell
        cell.configureCell(stream: dataService.streamers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = Bundle.main.loadNibNamed("StreamTableCell", owner: self, options: nil)?.first as! StreamTableCell
        return cell.frame.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
