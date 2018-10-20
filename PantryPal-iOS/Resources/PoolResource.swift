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
    let plu: String
    let latitude: Double
    let longitude: Double
    let userIds: [String]
    
    required init(object: MarshaledObject) throws {
        plu = try object.value(for: "plu")
        latitude = try object.value(for: "latitude")
        longitude = try object.value(for: "longitude")
        userIds = try object.value(for: "userIds")
    }
}
