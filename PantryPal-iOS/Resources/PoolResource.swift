//
//  PoolResource.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/20/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import Marshal

class PoolResource: Unmarshaling {
    let id: String
    let pluName: String
    let latitude: Double
    let longitude: Double
    let totalUnits: Int
    let tiers: [TierResource]
//    let start: Int64
//    let end: Int64
    let storeName: String
    let pluImage: String
    
    required init(object: MarshaledObject) throws {
        id = try object.value(for: "id")
        pluName = try object.value(for: "pluName")
        latitude = try object.value(for: "lat")
        longitude = try object.value(for: "long")
        totalUnits = try object.value(for: "totalUnits")
        tiers = try object.value(for: "tiers")
//        start = try object.value(for: "start")
//        end = try object.value(for: "end")
        storeName = try object.value(for: "storeName")
        pluImage = try object.value(for: "pluImage")
    }
    
    func getPrice() -> Double {
        var price = 0.0
        for tier in tiers {
            price = tier.price
            if tier.threshold > totalUnits {
                return price
            }
        }
        
        return price
    }
    
    func getDefaultPrice() -> Double {
        if let price = tiers.first?.price {
            return price
        }
        return 0.0
    }
}
