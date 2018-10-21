//
//  TierResource.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/20/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import Marshal

class TierResource: Unmarshaling {
    let price: Double
    let threshold: Int
    
    required init(object: MarshaledObject) throws {
        price = try object.value(for: "price")
        threshold = try object.value(for: "threshold")
    }
}
