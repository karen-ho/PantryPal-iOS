//
//  PoolFilledView.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/21/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

protocol PoolFilledDelegate {
    func closeFilled()
}

class PoolFilledView: UIView {
    @IBOutlet weak var niceButton: UIButton!
    @IBOutlet weak var poolView: UIView!
    
    var delegate: PoolFilledDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        niceButton.layer.cornerRadius = 4.0
        poolView.layer.cornerRadius = 4.0
    }
    
    @IBAction func close(_ sender: UIButton) {
        delegate?.closeFilled()
    }
}
