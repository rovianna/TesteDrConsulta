//
//  StreamsVCViewController.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 28/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit
import SDStateTableView

class StreamsVC: UIViewController {

    @IBOutlet weak var streamTV: SDStateTableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var gameName: String?
    var dataService = DataService.instance
    
    private let refreshControl = UIRefreshControl()
    let myAttribute = [NSAttributedStringKey.foregroundColor : UIColor.white]
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let index = self.streamTV.indexPathForSelectedRow {
            self.streamTV.deselectRow(at: index, animated: true)
        }
        
        guard var game = gameName else {
            return
        }
        
        game = game.replacingOccurrences(of: " ", with: "%20")
        
        dataService.getTwitchStreamers(game: game) { (Success) in
            if Success {
                OperationQueue.main.addOperation {
                    self.streamTV.reloadData()
                }
            } else {
                
            }
        }

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
    
    @objc func refreshStreamerData(_ sender: Any){
        guard var game = gameName else {
            return
        }
        game = game.replacingOccurrences(of: " ", with: "%20")
        dataService.getTwitchStreamers(game: game) { (Success) in
            if Success {
                OperationQueue.main.addOperation {
                    self.streamTV.reloadData()
                    self.refreshControl.endRefreshing()
                    self.activityIndicator.stopAnimating()
                }
            } else {
                
            }
        }
    }
    
    
    
    
    
}


extension StreamsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    
}
