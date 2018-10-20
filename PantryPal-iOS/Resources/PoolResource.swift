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
    let plu: String
    let latitude: Double
    let longitude: Double
    let userIds: [String]
    let tiers: [TierResource]
    let start: Int64
    let end: Int64
    
    required init(object: MarshaledObject) throws {
        id = try object.value(for: "id")
        plu = try object.value(for: "pluId")
        latitude = try object.value(for: "lat")
        longitude = try object.value(for: "long")
        userIds = try object.value(for: "userIds")
        tiers = try object.value(for: "tiers")
        start = try object.value(for: "start")
        end = try object.value(for: "end")
    }
}
