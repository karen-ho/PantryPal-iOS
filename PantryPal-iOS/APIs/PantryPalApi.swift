//
//  PantryPalApi.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/20/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import Moya

enum PantryPalApi {
    // pools
    case getPools()
}

extension PantryPalApi {
    var baseURL: URL { return URL(string: "")! }
    
    var path: String {
        switch self {
        case .getPools:
            return "/pool"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPools:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPools:
            return .requestPlain
        }
    }
    
    var sampleDate: Data {
        switch self {
        case .getPools:
            return """
            """.data(using: String.Encoding.utf8)!
        }
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
