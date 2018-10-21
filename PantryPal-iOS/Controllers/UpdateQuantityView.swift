//
//  UpdateQuantityView.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/20/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

class UpdateQuantityView: UIView {
    @IBOutlet weak var addQuantityButton: UIButton!
    @IBOutlet weak var minusQuantityButton: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addQuantityButton.layer.cornerRadius = addQuantityButton.frame.height / 2.0
        minusQuantityButton.layer.cornerRadius = minusQuantityButton.frame.height / 2.0
    }
}
