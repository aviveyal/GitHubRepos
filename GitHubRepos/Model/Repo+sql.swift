//
//  Repo+sql.swift
//  GitHubRepos
//
//  Created by admin on 17/06/2018.
//  Copyright © 2018 Aviv Eyal. All rights reserved.
//

import Foundation
import SQLite3

extension Repo{
// var repoName: String
//    var userName: String
//    var language: String?
//    var stars: Int
//    var avatar: String
//    var forks: Int
//    var date: String
//    var description: String
//    var link:String
    
    static let FAVORITE_TABLE = "FAVORITE"
    static let REPO_NAME = "REPO_NAME"
    static let USER_NAME = "USER_NAME"
    static let LANGUAGE = "LANGUAGE"
    static let STARS = "STARS"
    static let AVATAR = "AVATAR"
    static let FORKS = "FORKS"
    static let DATE = "DATE"
    static let DESCRIPTION = "DESCRIPTION"
    static let LINK = "LINK"

    
    
    static func createTable(database:OpaquePointer?)->Bool{
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        
        let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS " + FAVORITE_TABLE + " ( " + USER_NAME+"_"+REPO_NAME + " TEXT PRIMARY KEY, "
            + LANGUAGE + " TEXT, "
            + STARS + " TEXT, "
            + AVATAR + " TEXT, "
            + FORKS + " TEXT, "
            + DATE + " TEXT, "
            + DESCRIPTION + " TEXT, "
            + LINK + " TEXT)", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return false
        }
        
        return true
    }
    
    func addRepoToLocalDb(database:OpaquePointer?) -> Bool{
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO " + Repo.FAVORITE_TABLE
            + "(" + Repo.USER_NAME+"_"+Repo.REPO_NAME + ","
            + Repo.LANGUAGE + ","
            + Repo.STARS + ","
            + Repo.AVATAR + ","
            + Repo.FORKS + ","
            + Repo.DATE + ","
            + Repo.DESCRIPTION + ","
            + Repo.LINK + ") VALUES (?,?,?,?,?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            
            var repoNameAndUserName = ""
            repoNameAndUserName.append(self.repoName)
            repoNameAndUserName.append("_")
            repoNameAndUserName.append(self.userName)
            
            let nameAndUser = repoNameAndUserName.cString(using: .utf8)
            //let user = self.userName.cString(using: .utf8)
            let language = self.language.cString(using: .utf8)
            let stars = String(self.stars).cString(using: .utf8)
            let avatar = self.avatar.cString(using: .utf8)
            let forks = String(self.forks).cString(using: .utf8)
            let date = self.date.cString(using: .utf8)
            let description = self.description.cString(using: .utf8)
            let link = self.link.cString(using: .utf8)
            
            
          

            sqlite3_bind_text(sqlite3_stmt, 1, nameAndUser,-1,nil);
            //sqlite3_bind_text(sqlite3_stmt, 2, user,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, language,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, stars,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 4, avatar,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 5, forks,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 6, date,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 7, description,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 8, link,-1,nil);
            
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new favorive row added succefully to local sql lite DB")
                sqlite3_finalize(sqlite3_stmt)
                return true

            }
            else{
                sqlite3_finalize(sqlite3_stmt)
                return false
            }

        }
        else{
            return false
        }
        
    }
    
    static func getAllReposFromLocalDb(database:OpaquePointer?)->[Repo]{
        var favoriteList = [Repo]()
        print("starting get from local")
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"SELECT * from FAVORITE;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let repoNameAndUserName =  String(validatingUTF8: sqlite3_column_text(sqlite3_stmt,0))?.split(separator: "_")
                var repoName = ""
                repoName.append(String(repoNameAndUserName![0]))
                var userName = ""
                userName.append(String(repoNameAndUserName![1]))
                let language =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,1))
                let stars =  Int(String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,2))!)
                let avatar =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,3))
                let forks =  Int(String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,4))!)
                let date =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,5))
                let description =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,6))
                let link =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,7))
                let newRepo = Repo(repoName: repoName, userName: userName, language: language!, stars: stars!, avatar: avatar!, forks: forks!, date: date!, description: description!, link: link!)
                
                favoriteList.append(newRepo)
            }
        }
        sqlite3_finalize(sqlite3_stmt)
      
        return favoriteList
    }
    
    
    
}
