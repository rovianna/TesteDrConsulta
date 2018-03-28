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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.streamTV.delegate = self
        self.streamTV.dataSource = self
    }
}


extension StreamsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
