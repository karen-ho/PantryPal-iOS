//
//  Response+Marshal.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/20/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import Moya
import Marshal

extension Response {
    public func map<T: Unmarshaling>(of type: T.Type) throws -> T {
        guard let response = try mapJSON() as? MarshaledObject else {
            throw MoyaError.jsonMapping(self)
        }
        
        return try T.init(object: response)
    }
    
    public func mapArray<T: Unmarshaling>(of type: T.Type) throws -> [T] {
        guard let array = try mapJSON() as? [MarshaledObject] else {
            throw MoyaError.jsonMapping(self)
        }
        
        return try array.map { try T.init(object: $0) }
    }
}
