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
    case joinPool(id: String, userId: String, unit: Int, paymentType: String)
    case leavePool(id: String, userId: String, unit: Int, paymentType: String)
    case searchPool(searchTerm: String)
}

extension PantryPalApi: TargetType {
    var baseURL: URL { return URL(string: "https://pantrypal2018.herokuapp.com/api/v1")! }
    
    var path: String {
        switch self {
        case .getPools:
            return "/pools"
        case .getPool(let id):
            return "/pools/\(id)"
        case .joinPool(let id, let userId, _, _):
            return "/pools/\(id)/users/\(userId)"
        case .leavePool(let id, let userId, _, _):
            return "/pools/\(id)/users/\(userId)"
        case .searchPool:
            return "/pools/search"
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
        case .searchPool:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPools(let latitude, let longitude):
            return .requestParameters(parameters: ["latitude": latitude, "longitude": longitude], encoding: URLEncoding.queryString)
        case .getPool:
            return .requestPlain
        case .joinPool(_, _, let unit, let paymentType):
            return .requestParameters(parameters: ["units": unit, "paymentType": paymentType], encoding: JSONEncoding.default)
        case .leavePool(_, _, let unit, let paymentType):
            return .requestParameters(parameters: ["units": unit, "paymentType": paymentType], encoding: JSONEncoding.default)
        case .searchPool(let searchTerm):
            return .requestParameters(parameters: ["term": searchTerm], encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getPools:
            return """
            [{"_id":"5bcc04a0baad40b0ebffe963","id":"1","pluId":"10","lat":36.1394508,"long":-115.1720574,"storeName":"CVS","pluImage":"https://images-na.ssl-images-amazon.com/images/I/81v5CQmnjiL._SL1500_.jpg","pluName":"Huggies Little Snugglers Diapers - Size 1 - 216 ct","start":1540089714,"end":1540262514,"location":{"type":"Point","coordinates":[-115.1720574,36.1394508]},"tiers":[{"_id":"5bcc04a1baad40b0ebffe96d","price":2,"threshold":12,"poolId":"1"},{"_id":"5bcc04a1baad40b0ebffe96c","price":4,"threshold":4,"poolId":"1"},{"_id":"5bcc04a1baad40b0ebffe96b","price":5,"threshold":0,"poolId":"1"}],"totalUnits":6},{"_id":"5bcc04a0baad40b0ebffe964","id":"2","pluId":"10","lat":36.1394508,"long":-115.1720574,"storeName":"CVS","pluImage":"https://images-na.ssl-images-amazon.com/images/I/91yRL7SfvrL._SX522_.jpg","pluName":"Charmin Ultra Soft Toilet Paper, 24 Count","start":1540089714,"end":1540262514,"location":{"type":"Point","coordinates":[-115.1720574,36.1394508]},"tiers":[{"_id":"5bcc04a1baad40b0ebffe96a","price":2,"threshold":12,"poolId":"2"},{"_id":"5bcc04a1baad40b0ebffe969","price":4,"threshold":4,"poolId":"2"},{"_id":"5bcc04a1baad40b0ebffe968","price":5,"threshold":0,"poolId":"2"}],"totalUnits":0},{"_id":"5bcc04a0baad40b0ebffe965","id":"3","pluId":"10","lat":36.1394508,"long":-115.1720574,"storeName":"CVS","pluImage":"https://images-na.ssl-images-amazon.com/images/I/81dJyNjVJXL._SL1500_.jpg","pluName":"Tampax Radiant Plastic Tampons, Pack of 4","start":1540089714,"end":1540262514,"location":{"type":"Point","coordinates":[-115.1720574,36.1394508]},"tiers":[{"_id":"5bcc04a1baad40b0ebffe976","price":2,"threshold":12,"poolId":"3"},{"_id":"5bcc04a1baad40b0ebffe975","price":4,"threshold":4,"poolId":"3"},{"_id":"5bcc04a1baad40b0ebffe974","price":5,"threshold":0,"poolId":"3"}],"totalUnits":0},{"_id":"5bcc04a0baad40b0ebffe966","id":"4","pluId":"10","lat":36.1394508,"long":-115.1720574,"storeName":"CVS","pluImage":"https://images-na.ssl-images-amazon.com/images/I/81pAWrTt6-L._SX522_.jpg","pluName":"Kleenex Ultra Soft Facial Tissues, Flat Box, 130 Tissues per Flat Box","start":1540089714,"end":1540262514,"location":{"type":"Point","coordinates":[-115.1720574,36.1394508]},"tiers":[{"_id":"5bcc04a1baad40b0ebffe973","price":2,"threshold":12,"poolId":"4"},{"_id":"5bcc04a1baad40b0ebffe972","price":4,"threshold":4,"poolId":"4"},{"_id":"5bcc04a1baad40b0ebffe971","price":5,"threshold":0,"poolId":"4"}],"totalUnits":0},{"_id":"5bcc04a0baad40b0ebffe967","id":"5","pluId":"10","lat":36.1394508,"long":-115.1720574,"storeName":"CVS","pluImage":"https://images-na.ssl-images-amazon.com/images/I/51jAfIY-wZL.jpg","pluName":"Colgate Total Whitening Toothpaste Twin Pack - 6 ounce","start":1540089714,"end":1540262514,"location":{"type":"Point","coordinates":[-115.1720574,36.1394508]},"tiers":[{"_id":"5bcc04a1baad40b0ebffe970","price":2,"threshold":12,"poolId":"5"},{"_id":"5bcc04a1baad40b0ebffe96f","price":4,"threshold":4,"poolId":"5"},{"_id":"5bcc04a1baad40b0ebffe96e","price":5,"threshold":0,"poolId":"5"}],"totalUnits":0}]
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
        case .searchPool:
            return """
            [{"_id":"5bcc04a0baad40b0ebffe963","id":"1","pluId":"10","lat":36.1394508,"long":-115.1720574,"storeName":"CVS","pluImage":"https://images-na.ssl-images-amazon.com/images/I/81v5CQmnjiL._SL1500_.jpg","pluName":"Huggies Little Snugglers Diapers - Size 1 - 216 ct","start":1540089714,"end":1540262514,"location":{"type":"Point","coordinates":[-115.1720574,36.1394508]},"tiers":[{"_id":"5bcc04a1baad40b0ebffe96d","price":3.22,"threshold":12,"poolId":"1"},{"_id":"5bcc04a1baad40b0ebffe96c","price":4.32,"threshold":4,"poolId":"1"},{"_id":"5bcc04a1baad40b0ebffe96b","price":6.13,"threshold":0,"poolId":"1"}],"totalUnits":6},{"_id":"5bcc04a0baad40b0ebffe963","id":"1","pluId":"10","lat":36.1394508,"long":-115.1720574,"storeName":"CVS","pluImage":"https://images-na.ssl-images-amazon.com/images/I/818pBhFyExL._SX522_.jpg","pluName":"Pampers Swaddlers Disposable Diapers Size 2","start":1540089714,"end":1540262514,"location":{"type":"Point","coordinates":[-115.1720574,36.1394508]},"tiers":[{"_id":"5bcc04a1baad40b0ebffe96d","price":3.19,"threshold":12,"poolId":"1"},{"_id":"5bcc04a1baad40b0ebffe96c","price":4.33,"threshold":4,"poolId":"1"},{"_id":"5bcc04a1baad40b0ebffe96b","price":5.423,"threshold":0,"poolId":"1"}],"totalUnits":6},{"_id":"5bcc04a0baad40b0ebffe963","id":"1","pluId":"10","lat":36.1394508,"long":-115.1720574,"storeName":"CVS","pluImage":"https://images-na.ssl-images-amazon.com/images/I/816GdjlNqeL._SX522_.jpg","pluName":"Pampers Swaddlers Sensitive Disposable Diapers Newborn Size 0","start":1540089714,"end":1540262514,"location":{"type":"Point","coordinates":[-115.1720574,36.1394508]},"tiers":[{"_id":"5bcc04a1baad40b0ebffe96d","price":3.22,"threshold":12,"poolId":"1"},{"_id":"5bcc04a1baad40b0ebffe96c","price":3.77,"threshold":4,"poolId":"1"},{"_id":"5bcc04a1baad40b0ebffe96b","price":4.22,"threshold":0,"poolId":"1"}],"totalUnits":6}]
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
