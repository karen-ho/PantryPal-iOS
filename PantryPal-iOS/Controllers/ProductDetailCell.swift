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
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var tier1View: UIView!
    @IBOutlet weak var tier2View: UIView!
    @IBOutlet weak var tier3View: UIView!
    
    @IBOutlet weak var barWidth: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setProduct(pool: PoolResource) {
        let url = URL(string: pool.pluImage)
        productImage.kf.setImage(with: url)
        productNameLabel.text = pool.pluName
        purchasedLabel.text = "\(pool.totalUnits) purchased"
        
        let tiers = pool.tiers.sorted(by: {$0.threshold < $1.threshold})
        
        let tier1 = tiers[0]
        let tier2 = tiers[1]
        let tier3 = tiers[2]
        
        var currentTier = 1
        
        if tier2.threshold < pool.totalUnits {
            currentTier = 2
        } else if tier3.threshold <= pool.totalUnits {
            currentTier = 3
        }
        
        tier1View.layer.cornerRadius = tier1View.frame.height / 2.0
        tier2View.layer.cornerRadius = tier2View.frame.height / 2.0
        tier3View.layer.cornerRadius = tier3View.frame.height / 2.0
        
        
        let diff = Double(tier3.threshold - pool.totalUnits) / Double(tier3.threshold)
        let fullWidth: CGFloat = UIScreen.main.bounds.width * CGFloat(diff)
        barWidth.constant = fullWidth
        
        regularPriceLabel.text = tier1.price.asLocaleCurrency
        middlePriceLabel.text = tier2.price.asLocaleCurrency
        topPriceLabel.text = tier3.price.asLocaleCurrency
        
        let middleDiscount = (tier1.price - tier2.price) / tier1.price * 100
        let middleOff = String(format: "%.2f", middleDiscount) + "% Off"
        middleDiscountLabel.text = middleOff
        
        let topDiscount = (tier1.price - tier3.price) / tier1.price * 100
        let topOff = String(format: "%.2f", topDiscount) + "% Off"
        topDiscountLabel.text = topOff
        
        if pool.pluName.contains("Diapers") {
            descriptionLabel.text = """
            -One pack of HUGGIES Little Snugglers Baby Diapers, Size 1 (up to 14 lb.), 216 diapers total
            -Unscented, hypoallergenic diapers
            -GentleAbsorb Liner provides a cushiony layer of protection between your baby's skin and the mess, and pocketed-back waistband helps stop leaks
            """
        } else if pool.pluName.contains("Toilet") {
            descriptionLabel.text = """
            -1 Charmin Family Mega Roll = 5+ Regular Rolls based on number of sheets in Charmin Regular Roll bath tissue
            -Charmin's irresistibly soft Family Mega Roll Toilet paper with a unique cushiony touch
            -More absorbent so you can use less vs. the leading bargain brand
            """
        } else if pool.pluName.contains("Tampax") {
            descriptionLabel.text = """
            -Tampax Radiant super plastic tampons provide up to 100% leak & odor-free period protection
            -Comes with our quietest CleanSeal re-sealable wrapper for quick and easy discreet tampon disposal
            -CleanGrip applicator designed for incredibly comfortable tampon insertion
            """
        } else if pool.pluName.contains("Tissues") {
            descriptionLabel.text = """
            -The softest ultra tissue* (among national brands)
            -Compact facial tissue box for living rooms, bathrooms, kitchens, offices and more
            -Facial tissue flat box in a variety of colors and designs (may vary from image shown)
            """
        } else if pool.pluName.contains("Toothpaste") {
            descriptionLabel.text = """
            -Whitening Toothpaste Helps Prevent Stains
            -Fights Germs for 12 Hours
            -Helps Prevent Cavities, Gingivitis, Plaque
            """
        }
        
        
        switch currentTier {
        case 2:
            tier1View.layer.borderColor = UIColor.greenOutline.cgColor
            tier1View.layer.borderWidth = 5.0
            tier1View.backgroundColor = UIColor.greenFill
            regularPriceLabel.textColor = UIColor.soybean
            
            tier2View.backgroundColor = UIColor.greenOutline
            tier2View.layer.borderColor = UIColor.greenOutline.cgColor
            tier2View.layer.borderWidth = 5.0
            middlePriceLabel.textColor = UIColor.white
            middleDiscountLabel.textColor = UIColor.white
            
            tier3View.layer.borderColor = UIColor.fadeGray.cgColor
            tier3View.layer.borderWidth = 5.0
            
            let unitsMore = tier3.threshold - pool.totalUnits
            discountLabel.text = "\(unitsMore) More for \(topOff)"
        case 3:
            tier1View.layer.borderColor = UIColor.greenOutline.cgColor
            tier1View.layer.borderWidth = 5.0
            tier1View.backgroundColor = UIColor.greenOutline
            regularPriceLabel.textColor = UIColor.soybean
            
            tier2View.backgroundColor = UIColor.greenFill
            tier2View.layer.borderColor = UIColor.greenOutline.cgColor
            tier2View.layer.borderWidth = 5.0
            middlePriceLabel.textColor = UIColor.soybean
            
            tier3View.backgroundColor = UIColor.greenOutline
            tier3View.layer.borderColor = UIColor.greenOutline.cgColor
            tier3View.layer.borderWidth = 5.0
            topPriceLabel.textColor = UIColor.white
            topDiscountLabel.textColor = UIColor.white
            
            discountLabel.text = "Pool filled!"
        default:
            tier1View.layer.borderColor = UIColor.greenOutline.cgColor
            tier1View.layer.borderWidth = 5.0
            
            tier2View.layer.borderColor = UIColor.fadeGray.cgColor
            tier2View.layer.borderWidth = 5.0
            
            tier3View.layer.borderColor = UIColor.fadeGray.cgColor
            tier3View.layer.borderWidth = 5.0
            
            let unitsMore = tier2.threshold - pool.totalUnits
            discountLabel.text = "\(unitsMore) More for \(middleOff)"
        }
    }
}
