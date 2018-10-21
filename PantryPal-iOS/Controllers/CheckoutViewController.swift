//
//  CheckoutViewController.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/20/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

class CheckoutViewController: UIViewController {
    
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var paypalView: UIView!
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var productTotalLabel: UILabel!
    
    @IBOutlet weak var paymentCollectionView: UICollectionView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var savingsLabel: UILabel!
    @IBOutlet weak var savingsUnlockView: UIView!
    @IBOutlet weak var savingsUnlockLabel: UILabel!
    
    var pool: PoolResource!
    var quantity: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paypalView.clipsToBounds = false
        paypalView.layer.cornerRadius = 8.0
        paypalView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        paypalView.layer.shadowOffset = CGSize(width: 0, height: 8)
        paypalView.layer.shadowOpacity = 1
        paypalView.layer.shadowRadius = 8
        
        productView.layer.cornerRadius = 8.0
        
        let url = URL(string: pool.pluImage)
        productImage.kf.setImage(with: url)
        productNameLabel.text = pool.pluName
        productPriceLabel.text = "\(pool.getPrice().asLocaleCurrency) each"
        productQuantityLabel.text = "Qty: \(quantity)"
        let finalPrice = pool.getPrice() * Double(quantity)
        productTotalLabel.text = finalPrice.asLocaleCurrency
        
        let paymentNib = UINib(nibName: "PaymentCell", bundle: Bundle(for: self.classForCoder))
        paymentCollectionView.register(paymentNib, forCellWithReuseIdentifier: "payment")
        paymentCollectionView.clipsToBounds = false
        
        let text = "123 Main St."
        let textRange = NSMakeRange(0, text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        // Add other attributes if needed
        self.addressLabel.attributedText = attributedText
        
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
        
        if currentTier == 2 {
            let middleDiscount = (tier1.price - tier2.price) * Double(quantity)
            let middle = (tier1.price - tier2.price) / tier1.price * 100
            let middleOff = String(format: "%.0f", middle) + "%"
            savingsLabel.text = "You saved \(middleDiscount.asLocaleCurrency) with this pool"
            savingsUnlockLabel.text = "\(middleOff) Savings Unlocked"
        } else if currentTier == 3 {
            let topDiscount = (tier1.price - tier3.price) * Double(quantity)
            let top = (tier1.price - tier3.price) / tier1.price * 100
            let topOff = String(format: "%.0f", top) + "%"
            savingsLabel.text = "You saved \(topDiscount.asLocaleCurrency) with this pool"
            savingsUnlockLabel.text = "\(topOff) Max Savings Unlocked"
        } else {
            savingsLabel.text = ""
            savingsUnlockLabel.text = "Savings Might Unlock!"
        }
        
        savingsUnlockView.layer.cornerRadius = 4.0
    }
    
    func showNavigationBar() {
        navigationController?.navigationBar.layer.zPosition = 1
        navigationController?.navigationBar.isUserInteractionEnabled = true
        navigationController?.navigationBar.isTranslucent = false
    }
}

// MARK: - UICollectionViewDelegate
extension CheckoutViewController: UICollectionViewDelegate {
    
}

// MARK: -
extension CheckoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 140.0)
    }
}

// MARK: - UICollectionViewDataSource
extension CheckoutViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "payment", for: indexPath) as! PaymentCell
        if indexPath.row == 0 {
            cell.setVisa()
        } else {
            cell.setCard()
        }
        cell.clipsToBounds = false
        
        return cell
    }
    
    
}
