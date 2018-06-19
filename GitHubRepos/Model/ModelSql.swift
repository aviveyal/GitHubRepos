//
//  ModelSql.swift
//  GitHubRepos
//
//  Created by admin on 19/06/2018.
//  Copyright © 2018 Aviv Eyal. All rights reserved.
//

import Foundation
import SQLite3
extension String {
    public init?(validatingUTF8 cString: UnsafePointer<UInt8>) {
        if let (result, _) = String.decodeCString(cString, as: UTF8.self,
                                                  repairingInvalidCodeUnits: false) {
            self = result
        }
        else {
            return nil
        }
    }
}

class ModelSql{
    var database: OpaquePointer? = nil
    static let instance = ModelSql()
    init?(){
        let dbFileName = "database9.db"
        if let dir = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask).first{
            let path = dir.appendingPathComponent(dbFileName)
            
            if sqlite3_open(path.absoluteString, &database) != SQLITE_OK {
                print("Failed to open db file: \(path.absoluteString)")
                return nil
            }
            else
            {
                print("successfully to opened db file: \(path.absoluteString)")
            }
        }
        
        if Repo.createTable(database: database) == false{
            return nil
        }
        
    }
}
