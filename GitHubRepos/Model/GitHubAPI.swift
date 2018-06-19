//
//  GitHubAPI.swift
//  GitHubRepos
//
//  Created by admin on 17/06/2018.
//  Copyright © 2018 Aviv Eyal. All rights reserved.
//
import Foundation
import Alamofire
class GitHubAPI{
    
    
    let formatter = DateFormatter()
    let url = "https://api.github.com/search/repositories" // API URL
    static let instance = GitHubAPI()
        
    func getLastDay(pageNumber :Int ,completion: @escaping ([Repo]) -> ()) {
        
        var date = Date()
        date = date.yesterday //get last day
        print(date)
        formatter.dateFormat = "yyyy-MM-dd" //set the format accordint to GitHub API
        let result = formatter.string(from: date)
        
        Alamofire.request(url,parameters : ["sort":"stars","order":"desc", "q":"created"+":>"+result,"page":String(pageNumber)]).responseJSON{ response in
             print(response.request as Any)  // original URL request

           completion(self.initRepoList(response: response.result.value as! NSDictionary))
            
            
    }
    }
        
    func getLastWeek(pageNumber :Int ,completion: @escaping ([Repo]) -> ())
        
    {
        var date = Date()
            date = date.lastWeek //get last day
        print(date)
            formatter.dateFormat = "yyyy-MM-dd" //set the format accordint to GitHub API
            let result = formatter.string(from: date)
        
            
        Alamofire.request(url,parameters : ["sort":"stars","order":"desc", "q":"created"+":>"+result,"page":String(pageNumber)]).responseJSON{ response in
                print(response.request as Any)  // original URL request
                completion(self.initRepoList(response: response.result.value as! NSDictionary))
        }
    
     }

        
        func getLastMonth(pageNumber :Int ,completion: @escaping ([Repo]) -> ())
        {
            var date = Date()
            date = date.lastMonth //get last month
            print(date)
            formatter.dateFormat = "yyyy-MM-dd" //set the format accordint to GitHub API
            let result = formatter.string(from: date)
            Alamofire.request(url,parameters : ["sort":"stars","order":"desc", "q":"created"+":>"+result,"page":String(pageNumber)]).responseJSON{ response in
                print(response.request as Any)  // original URL request
                completion(self.initRepoList(response: response.result.value as! NSDictionary))
            }
        }


        func initRepoList(response: NSDictionary) -> [Repo]{
            var repoList = [Repo]()
     
            if let items = response["items"] as? [[String : Any]] {
                for item in items {
                    var userName : String = " "
                    let repoName = item["name"] as? String
                    let stars = item["stargazers_count"] as? Int
                    let date = String((item["created_at"] as? String)!.split(separator: "T")[0])
                    let forks = item["forks"] as? Int
                    let link = item["html_url"] as? String
                    
                    var language = " "
                    if(item["language"] as? String != nil){
                        language = (item["language"] as? String)!
                    }
                    var description = " "
                    if(item["description"] as? String != nil){
                        description = (item["description"] as? String)!
                    }
                    
                    var avatar = " "
                    if let owner = item["owner"] as? [String : Any]{
                        if(owner["avatar_url"] as? String != nil)
                        {
                            avatar = (owner["avatar_url"] as? String)!
                        }
                        userName = (owner["login"] as? String)!
                        
                    }
                   
                    
                    repoList.append(Repo(repoName: repoName!, userName: userName, language: language, stars: stars!, avatar: avatar, forks: forks!, date: date, description: description, link: link!))
                    
            }
            }
            
            return repoList
        }
}

