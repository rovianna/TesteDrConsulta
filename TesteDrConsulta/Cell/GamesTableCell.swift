//
//  GamesTableCell.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 27/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit

class GamesTableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var viewersLabel: UILabel!
    
    func configureCell(game: Game) {
        titleLabel.text = game.name
        viewersLabel.text = "\(game.viewers)"
        positionLabel.text = "#\(game.position)"
        imageLabel.downloadImage(from: game.box.small)
    }
    
    func configureOffCell(game: [String:Any]){
        let name = game["name"] as! String
        let viewers = game["viewers"] as! Int
        let position = game["position"] as! Int
        imageView?.isHidden = true
        titleLabel.text = name
        positionLabel.text = "#\(position)"
        viewersLabel.text = "\(viewers)"
    }
    
}
