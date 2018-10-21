//
//  Config.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/20/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import Moya

struct Config {
    static var provider: MoyaProvider<PantryPalApi> {
        get {
            return MoyaProvider<PantryPalApi>(stubClosure: MoyaProvider.immediatelyStub)
//            let manager = MoyaProvider<PantryPalApi>.defaultAlamofireManager()
//            manager.session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
//            return MoyaProvider<PantryPalApi>(manager: manager, plugins: [NetworkLoggerPlugin()])
        }
    }
}

