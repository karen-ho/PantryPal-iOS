//
//  PoolApi.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/20/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import Moya

class PoolApi {
    static let sharedInstance = PoolApi()
    
    var provider: MoyaProvider<PantryPalApi>!
    
    init(provider: MoyaProvider<PantryPalApi> = Config.provider) {
        self.provider = provider
    }
    
    func getPools() {
        
    }
}
