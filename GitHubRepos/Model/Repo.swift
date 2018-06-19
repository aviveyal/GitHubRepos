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
    var stars: Int
    var avatar: String
    var forks: Int
    var date: String
    var description: String
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
    init(repoName:String,userName:String,language:String,stars:Int,avatar:String,forks:Int,date:String,description:String,link:String){
        self.repoName = repoName
        self.userName = userName
        self.language = language
        self.stars = stars
        self.avatar = avatar
        self.forks = forks
        self.date = date
        self.description = description
        self.link = link
        
    }
    

    
}

