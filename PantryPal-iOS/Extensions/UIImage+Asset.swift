//
//  UIImage+Asset.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/20/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    enum AssetIdentifier: String {
        case home
        case search
        case setting
        case visa
        case mastercard
        case discover
        case americanexpress
    }
    
    convenience init!(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)
    }
}
