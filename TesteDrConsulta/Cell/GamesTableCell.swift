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
        imageLabel.downloadImage(from: game.box.small)
    }
    
}
