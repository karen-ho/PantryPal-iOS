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
    func proceed(quantity: Int)
}

class UpdateQuantityView: UIView {
    @IBOutlet weak var addQuantityButton: UIButton!
    @IBOutlet weak var minusQuantityButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var proceedButton: UIButton!
    
    var quantity: Int = 1
    var delegate: QuantityDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addQuantityButton.layer.cornerRadius = addQuantityButton.frame.height / 2.0
        minusQuantityButton.layer.cornerRadius = minusQuantityButton.frame.height / 2.0
        
        proceedButton.clipsToBounds = false
        proceedButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        proceedButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        proceedButton.layer.shadowOpacity = 1
        proceedButton.layer.shadowRadius = 8
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
    
    @IBAction func proceed(_ sender: UIButton) {
        delegate?.proceed(quantity: quantity)
    }
}
