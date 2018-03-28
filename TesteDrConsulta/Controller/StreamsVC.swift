//
//  StreamsVCViewController.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 28/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit

class StreamsVC: UIViewController {

    @IBOutlet weak var streamTV: UITableView!
    
    var gameName: String?
    var dataService = DataService.instance
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
