//
//  StreamTableCell.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 28/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit

class StreamTableCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var streamerLabel: UILabel!
    @IBOutlet weak var viewersLabel: UILabel!
    
    //MARK: Configuration
    func configureCell(stream: Streamer){
        thumbImage.downloadImage(from: stream.box.small)
        streamerLabel.text = stream.streamer
        viewersLabel.text = "\(stream.viewers)"
    }
    
}
