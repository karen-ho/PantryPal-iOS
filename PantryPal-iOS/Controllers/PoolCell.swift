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

class PoolCell: UITableViewCell {
    @IBOutlet weak var pluNameLabel: UILabel!
    @IBOutlet weak var pluImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setPool(_ pool: PoolResource) {
        pluNameLabel.text = pool.pluName
        let url = URL(string: pool.pluImage)
        pluImage.kf.setImage(with: url)
        priceLabel.text = pool.getPrice().asLocaleCurrency
    }
}
