//
//  UpdateQuantityView.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/20/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

protocol QuantityDelegate {
    func close()
}

class UpdateQuantityView: UIView {
    @IBOutlet weak var addQuantityButton: UIButton!
    @IBOutlet weak var minusQuantityButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    
    var quantity: Int = 1
    var delegate: QuantityDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addQuantityButton.layer.cornerRadius = addQuantityButton.frame.height / 2.0
        minusQuantityButton.layer.cornerRadius = minusQuantityButton.frame.height / 2.0
    }
    
    @IBAction func addQuantity(_ sender: UIButton) {
        quantity = quantity + 1
        quantityLabel.text = "\(quantity)"
    }
    
    @IBAction func removeQuantity(_ sender: UIButton) {
        if quantity > 1 {
            quantity = quantity - 1
            quantityLabel.text = "\(quantity)"
        }
    }
    
    @IBAction func close(_ sender: UIButton) {
        delegate?.close()
    }
}
