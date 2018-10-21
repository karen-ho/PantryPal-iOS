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
    case getPools(latitude: Double, longitude: Double)
    case getPool(id: String)
    case joinPool(id: String, userId: String, unit: Int)
    case leavePool(id: String, userId: String, unit: Int)
}

extension PantryPalApi: TargetType {
    var baseURL: URL { return URL(string: "https://pantrypal2018.herokuapp.com")! }
    
    var path: String {
        switch self {
        case .getPools:
            return "/pool"
        case .getPool(let id):
            return "/pool/\(id)"
        case .joinPool(let id, let userId, _):
            return "/pool/\(id)/user/\(userId)"
        case .leavePool(let id, let userId, _):
            return "/pool/\(id)/user/\(userId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPools:
            return .get
        case .getPool:
            return .get
        case .joinPool:
            return .post
        case .leavePool:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .getPools(let latitude, let longitude):
            return .requestParameters(parameters: ["latitude": latitude, "longitude": longitude], encoding: URLEncoding.queryString)
        case .getPool:
            return .requestPlain
        case .joinPool(_, _, let unit):
            return .requestParameters(parameters: ["unit": unit], encoding: JSONEncoding.default)
        case .leavePool(_, _, let unit):
            return .requestParameters(parameters: ["unit": unit], encoding: JSONEncoding.default)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getPools:
            return """
            [{
                "id": "123",
                "pluId": "3434",
                "lat": 32.2243,
                "long": -117.2453,
                "tiers": [{"id": "123", "price": 2.33, "threshold": 3}],
                "totalUnits": 3,
                "start": 135343232,
                "end": 232323232
            }, {
                "id": "124",
                "pluId": "34324",
                "lat": 32.2243,
                "long": -117.2453,
                "tiers": [{"id": "123", "price": 2.33, "threshold": 3}],
                "totalUnits": 23,
                "start": 135343232,
                "end": 232323232
            }]
            """.data(using: String.Encoding.utf8)!
        case .getPool:
            return """
            """.data(using: String.Encoding.utf8)!
        case .joinPool:
            return """
            """.data(using: String.Encoding.utf8)!
        case .leavePool:
            return """
            """.data(using: String.Encoding.utf8)!  
        }
    }
    
    var headers: [String : String]? {
        return nil
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
