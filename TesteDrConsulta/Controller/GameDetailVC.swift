//
//  GameDetailVC.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 27/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit

class GameDetailVC: UIViewController {

    var game : Game?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var spectatorLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let game = game else {
            return
        }
        
        configureDetails(game: game)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configureDetails(game: Game) {
        self.titleLabel.text = game.name
        self.thumbnailImage.downloadImage(from: game.box.large)
        self.spectatorLabel.text = "\(game.viewers)"
        self.channelLabel.text = "\(game.channels)"
    }
    
    
}
