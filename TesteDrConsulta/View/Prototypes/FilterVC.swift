//
//  FilterVC.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 28/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit

class FilterVC: UIView {

    @IBOutlet var filterVC: UIView!
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("Filter", owner: self, options: nil)
        addSubview(filterVC)
        filterVC.frame = self.bounds
        filterVC.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func distanceFilter(_ sender: UISlider) {
        self.distanceLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func saveFilteredOptions(_ sender: UIButton) {
        print("OK")
    }
    
    @IBAction func cancelFilter(_ sender: UIButton) {
       self.removeFromSuperview()
    }
    
    @IBAction func filterOptions(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
        print("Teste")
        case 1:
        print("Teste 2")
        default:
        break
        }
    }
    
    
    
}
