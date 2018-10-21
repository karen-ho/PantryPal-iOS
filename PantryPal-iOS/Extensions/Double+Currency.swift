//
//  Double+Currency.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/20/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation

extension Double {
    var asLocaleCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.init(identifier: "en_US")
        let value = NSNumber(value: self)
        return formatter.string(from: value) ?? ""
    }
}
