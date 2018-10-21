//
//  OrderViewController.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/21/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

class OrderViewController: UIViewController {
    @IBOutlet weak var confirmationNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var qrImage: UIImageView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var unitPriceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var savingsView: UIView!
    @IBOutlet weak var savingsLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalSavedLabel: UILabel!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var returnButton: UIButton!
    
    var number: Int = Int.random(in: 10000 ... 99999)
    var pool: PoolResource!
    var quantity: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmationNumberLabel.text = "#\(number)"
        
        let text = "123 Main St."
        let textRange = NSMakeRange(0, text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        // Add other attributes if needed
        self.addressLabel.attributedText = attributedText
        
        setQRImage()
        
        let url = URL(string: pool.pluImage)
        productImage.kf.setImage(with: url)
        productNameLabel.text = pool.pluName
        unitPriceLabel.text = "\(pool.getPrice().asLocaleCurrency) each"
        quantityLabel.text = "Qty: \(quantity)"
        let finalPrice = pool.getPrice() * Double(quantity)
        totalLabel.text = finalPrice.asLocaleCurrency
        
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
            totalSavedLabel.text = "You saved \(middleDiscount.asLocaleCurrency) with this pool"
            savingsLabel.text = "\(middleOff) Savings Unlocked"
        } else if currentTier == 3 {
            let topDiscount = (tier1.price - tier3.price) * Double(quantity)
            let top = (tier1.price - tier3.price) / tier1.price * 100
            let topOff = String(format: "%.0f", top) + "%"
            totalSavedLabel.text = "You saved \(topDiscount.asLocaleCurrency) with this pool"
            savingsLabel.text = "\(topOff) Max Savings Unlocked"
        } else {
            totalSavedLabel.text = ""
            savingsLabel.text = "Savings Might Unlock!"
        }
        
        savingsView.layer.cornerRadius = 4.0
        
        productView.layer.cornerRadius = 8.0
        
        productView.clipsToBounds = false
        productView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        productView.layer.shadowOffset = CGSize(width: 0, height: 8)
        productView.layer.shadowOpacity = 1
        productView.layer.shadowRadius = 8
        
        returnButton.clipsToBounds = false
        returnButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        returnButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        returnButton.layer.shadowOpacity = 1
        returnButton.layer.shadowRadius = 8
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setQRImage() {
        let qrData = """
        {
        "orderId": "\(number)",
        "userName": "\(number)",
        }
        """
        let data = qrData.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        
        let filterOutputImage = filter?.outputImage
        
        if let qrCode = filterOutputImage {
            let scaleX = qrImage.frame.size.width / qrCode.extent.size.width
            let scaleY = qrImage.frame.size.height / qrCode.extent.size.height
            
            let transformedImage = qrCode.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
            qrImage.image = UIImage(ciImage: transformedImage)
        }
    }
    
    @IBAction func viewPools(_ sender: UIButton) {
        goToTabBar()
    }
}
