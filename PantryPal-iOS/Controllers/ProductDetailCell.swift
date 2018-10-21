//
//  ProductDetailCell.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/20/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var purchasedLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    @IBOutlet weak var regularPriceLabel: UILabel!
    @IBOutlet weak var middleDiscountLabel: UILabel!
    @IBOutlet weak var middlePriceLabel: UILabel!
    @IBOutlet weak var topPriceLabel: UILabel!
    @IBOutlet weak var topDiscountLabel: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setProduct(pool: PoolResource) {
        let url = URL(string: pool.pluImage)
        productImage.kf.setImage(with: url)
        productNameLabel.text = pool.pluName
        purchasedLabel.text = "\(pool.totalUnits) purchased"
//        pluDefaultPriceLabel.text = pool.getDefaultPrice().asLocaleCurrency
        
        let tiers = pool.tiers.sorted(by: {$0.threshold < $1.threshold})
        
        let tier1 = tiers[0]
        let tier2 = tiers[1]
        let tier3 = tiers[2]
        
//        let currentTier = 
        
        regularPriceLabel.text = tier1.price.asLocaleCurrency
        middlePriceLabel.text = tier2.price.asLocaleCurrency
        topPriceLabel.text = tier3.price.asLocaleCurrency
        
        let middleDiscount = (tier1.price - tier2.price) / tier1.price * 100
        middleDiscountLabel.text = String(format: "%.2f", middleDiscount) + "% Off"
        
        let topDiscount = (tier1.price - tier3.price) / tier1.price * 100
        topDiscountLabel.text = String(format: "%.2f", topDiscount) + "% Off"
    }
}
