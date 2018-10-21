//
//  DatabaseManager.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/21/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import Firebase

class DatabaseManager {
    static let sharedInstance = DatabaseManager()
    
    var ref: DatabaseReference
    var mainKey: DatabaseReference?
    
    init(ref: DatabaseReference = Config.db) {
        self.ref = ref
    }
    
    func getDatabase() -> DatabaseReference {
        return ref
    }
    
    func send(assistance: [String: Any], completion: @escaping (Error?, DatabaseReference) -> Void) {
        let db = getDatabase()
        let assistanceDb = db.child("pool")
        let key = assistanceDb.childByAutoId()
        
        key.setValue(assistance, withCompletionBlock: { (error, ref) -> Void in
            completion(error, ref)
        })
        
        mainKey = key
    }
    
    func observe(completion: @escaping (Bool) -> Void) {
        let db = getDatabase()
        let assistanceDb = db.child("pool")
        assistanceDb.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    func remove() {
        let db = getDatabase()
        let assistanceDb = db.child("pool")
        assistanceDb.removeAllObservers()
        assistanceDb.removeValue()
    }
}
