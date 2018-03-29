//
//  SplashVC.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 29/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit
import RevealingSplashView

class SplashVC: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "twitch_logo")!, iconInitialSize: CGSize(width: 288, height: 200), backgroundColor: twitch_purple)
        self.view.addSubview(revealingSplashView)
        revealingSplashView.startAnimation(){
            if Reachability.isConnectedToNetwork() {
                self.performSegue(withIdentifier: "hasConnectionSegue", sender: nil)
            } else {
                self.performSegue(withIdentifier: "noConnectionSegue", sender: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
