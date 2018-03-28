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
    
    
    @IBAction func openTwitch(_ sender: UIButton) {
        self.configureOpen(game: game!)
    }
    
    func configureOpen(game : Game){
        let game_ = game.name.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: "\(BASE_TWITCH_GAMES)/\(game_)") else {
            return
        }
        print(url)
        
        if #available(iOS 10.0, *){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    
    func configureDetails(game: Game) {
        self.titleLabel.text = game.name
        self.thumbnailImage.downloadImage(from: game.box.large)
        self.spectatorLabel.text = "\(game.viewers)"
        self.channelLabel.text = "\(game.channels)"
    }
    
    
}
