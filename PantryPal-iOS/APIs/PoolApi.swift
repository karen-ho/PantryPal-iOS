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
    
    func getPools(latitude: Double, longitude: Double, completion: @escaping ([PoolResource])  -> Void) {
        provider.request(.getPools(latitude: latitude, longitude: longitude)) { result in
            switch result {
            case let .success(response):
            do {
                let result = try response.mapArray(of: PoolResource.self)
                completion(result)
            } catch {
                print("ERROR: \(error)")
                completion([])
            }
            case let .failure(error):
                print("ERROR: \(error)")
                completion([])
            }
        }
    }
    
    func getPool(id: String, completion: @escaping (PoolResource?) -> Void) {
        provider.request(.getPool(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let result = try response.map(of: PoolResource.self)
                    completion(result)
                } catch {
                    print("ERROR: \(error)")
                    completion(nil)
                }
            case let .failure(error):
                print("ERROR: \(error)")
                completion(nil)
            }
        }
    }
    
    func joinPool(id: String, userId: String, completion: @escaping (Bool) -> Void) {
        provider.request(.joinPool(id: id, userId: userId)) { result in
            switch result {
            case .success:
                completion(true)
            case let .failure(error):
                print("ERROR: \(error)")
                completion(false)
            }
        }
    }
    
    func leavePool(id: String, userId: String, completion: @escaping (Bool) -> Void) {
        provider.request(.leavePool(id: id, userId: userId)) { result in
            switch result {
            case .success:
                completion(true)
            case let .failure(error):
                print("ERROR: \(error)")
                completion(false)
            }
        }
    }
}
