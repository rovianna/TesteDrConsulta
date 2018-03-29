//
//  FilterVC.swift
//  TesteDrConsulta
//
//  Created by Rodrigo Vianna on 28/03/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

import UIKit

class FilterVC: UIView {
    
    //MARK: Outlets
    @IBOutlet var filterVC: UIView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var sharedTextButton: UIButton!
    @IBOutlet weak var sharedJsonButton: UIButton!
    @IBOutlet weak var orderSegmented: UISegmentedControl!
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    //MARK: Custom Init
    private func commonInit(){
        Bundle.main.loadNibNamed("Filter", owner: self, options: nil)
        addSubview(filterVC)
        filterVC.frame = self.bounds
        filterVC.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        if ORDER_BY == "POPULARIDADE" {
            orderSegmented.selectedSegmentIndex = 0
        } else {
            orderSegmented.selectedSegmentIndex = 1
        }
    }
    
    //MARK: Actions
    @IBAction func distanceFilter(_ sender: UISlider) {
        self.distanceLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func cancelFilter(_ sender: UIButton) {
        self.removeFromSuperview()
        SELECTABLE = true
    }
    
    @IBAction func filterOptions(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            ORDER_BY = "POPULARIDADE"
        case 1:
            ORDER_BY = "NOME"
        default:
            break
        }
    }
    
    
    
}
