//
//  PoolCell.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/20/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

protocol PoolDelegate {
    func goToOrder(pool: PoolResource, quantity: Int)
}

class PoolCell: UITableViewCell {
    @IBOutlet weak var pluNameLabel: UILabel!
    @IBOutlet weak var pluImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var regularPriceLabel: UILabel!
    @IBOutlet weak var savingsView: UIView!
    @IBOutlet weak var savingsLabel: UILabel!
    @IBOutlet weak var orderDetailsButton: UIButton!
    @IBOutlet weak var cancelOrderButton: UIButton!
    @IBOutlet weak var pickUpImage: UIImageView!
    @IBOutlet weak var pickUpLabel: UILabel!
    
    var delegate: PoolDelegate?
    var pool: PoolResource?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        savingsView.layer.cornerRadius = 4.0
        orderDetailsButton.layer.cornerRadius = 4.0
        cancelOrderButton.layer.cornerRadius = 4.0
        cancelOrderButton.layer.borderColor = UIColor.fadeGray.cgColor
        cancelOrderButton.layer.borderWidth = 1.0
    }
    
    func setPool(_ pool: PoolResource, index: Int) {
        pluNameLabel.text = pool.pluName
        let url = URL(string: pool.pluImage)
        pluImage.kf.setImage(with: url)
        priceLabel.text = pool.getPrice().asLocaleCurrency
        
        self.pool = pool
        
        regularPriceLabel.text =
            "Reg. \(pool.getDefaultPrice().asLocaleCurrency)"
        
        if index == 0 {
            savingsLabel.text = "20% Savings Unlocked"
            pickUpImage.image = UIImage(assetIdentifier: .oneDay)
            
            if COUNT == 0 {
                pickUpLabel.text = "Pick up in 1 Day"
                orderDetailsButton.setTitle("Order Details", for: .normal)
                orderDetailsButton.backgroundColor = UIColor.pantryBlue
            } else {
                pickUpLabel.text = "Pick up Today"
                orderDetailsButton.setTitle("Pickup QR Code", for: .normal)
                orderDetailsButton.backgroundColor = UIColor.greenOutline
            }
        } else {
            savingsView.isHidden = true
            pickUpImage.image = UIImage(assetIdentifier: .twoDays)
            if COUNT == 0 {
                pickUpLabel.text = "Pick up in 2 Days"
            } else {
                pickUpLabel.text = "Pick up in 1 Day"
            }
        }
    }
    
    @IBAction func goToOrder(_ sender: UIButton) {
        if let pool = pool {
            delegate?.goToOrder(pool: pool, quantity: 1)
        }
    }
}
