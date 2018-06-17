//
//  Repo.swift
//  GitHubRepos
//
//  Created by admin on 17/06/2018.
//  Copyright © 2018 Aviv Eyal. All rights reserved.
//

import Foundation

class Repo{
    var repoName: String
    var userName: String
    var language: String
    var stars: String
    var avatar: String?
    var forks: String
    var date: String
    var description: String?
    var link:String


    init(repoData:Repo){
        repoName = repoData.repoName
        userName = repoData.userName
        language = repoData.language
        stars = repoData.stars
        avatar = repoData.avatar
        forks = repoData.forks
        date = repoData.date
        description = repoData.description
        link = repoData.link
        
    }
    init(check:String){
        repoName = check
        userName = check
        language = check
        stars = check
        avatar = check
        forks = check
        date = check
        description = check
        link = check
        
    }
    
    
    
//    init(json:Dictionary<String,Any>){
//        sid = json["sid"] as! String
//        songName = json["name"] as! String
//        artistId =  json["artistId"] as! String
//        length = json["length"] as! String
//        album = json["album"] as! String
//        if let im = json["songImage"] as? String{
//            songImage = im
//        }
//        if let ts = json["lastUpdate"] as? Double{
//            self.lastUpdate = Date.fromFirebase(ts)
//        }
//    }
    
}

