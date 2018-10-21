//
//  PaymentCell.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/20/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

class PaymentCell: UICollectionViewCell {
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardTitle: UILabel!
    @IBOutlet weak var cardEnding: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    let imageAssets: [Card] = [Card(image: .visa, name: "Exp. 1/22"), Card(image: .visa, name: "Exp. 1/19"), Card(image: .visa, name: "Exp. 2/20"), Card(image: .visa, name: "Exp. 3/21")]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cardView.layer.cornerRadius = 8.0
        cardView.clipsToBounds = false
        cardView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 8)
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowRadius = 8.9
    }
    
    func setCard() {
        let number = Int.random(in: 1000 ... 9999)
        cardEnding.text = "**** \(number)"
        if let card = imageAssets.randomElement() {
            cardTitle.text = card.name
            cardImage.image = UIImage(assetIdentifier: card.image)
        }
    }
    
    func setVisa() {
        let number = Int.random(in: 1000 ... 9999)
        cardImage.image = UIImage(assetIdentifier: .visa)
        cardTitle.text = "4/19"
        cardEnding.text = "**** \(number)"
    }
}

struct Card {
    let image: UIImage.AssetIdentifier
    let name: String
}
