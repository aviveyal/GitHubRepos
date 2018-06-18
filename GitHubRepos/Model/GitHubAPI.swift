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
    
    var date = Date()
    let formatter = DateFormatter()
    let url = "https://api.github.com/search/repositories" // API URL
    static let instance = GitHubAPI()
        
    func getLastDay()
    {
        print("date")
        date = date.yesterday //get last day
        formatter.dateFormat = "yyyy-MM-dd" //set the format accordint to GitHub API
        let result = formatter.string(from: date)
        
        print(result)
        
        let url = "https://api.github.com/search/repositories"

        let request = Alamofire.request(url,parameters : ["sort":"stars","order":"desc", "q":"created"+">"+result]).responseJSON{ response in
                        print(response.request as Any)  // original URL request
//                        print(response.response as Any) // HTTP URL response
//                        print(response.data as Any)     // server data
//                        print(response.result as Any)   // result of response serialization
            print(response)
    }
        
    func getLastWeek()
        
    {
            date = date.lastWeek //get last day
            formatter.dateFormat = "yyyy-MM-dd" //set the format accordint to GitHub API
            let result = formatter.string(from: date)
            
            print(result)
            
            let url = "https://api.github.com/search/repositories"
            
            let request = Alamofire.request(url,parameters : ["sort":"stars","order":"desc", "q":"created"+">"+result]).responseJSON{ response in
                print(response.request as Any)  // original URL request
                //                        print(response.response as Any) // HTTP URL response
                //                        print(response.data as Any)     // server data
                //                        print(response.result as Any)   // result of response serialization
                print(response)
        }
    
     }
        
        func getLastMonth()
        {
            
            date = date.lastMonth //get last day
            formatter.dateFormat = "yyyy-MM-dd" //set the format accordint to GitHub API
            let result = formatter.string(from: date)
            
            
            let request = Alamofire.request(url,parameters : ["sort":"stars","order":"desc", "q":"created"+">"+result]).responseJSON{ response in
                print(response.request as Any)  // original URL request
                //                        print(response.response as Any) // HTTP URL response
                //                        print(response.data as Any)     // server data
                //                        print(response.result as Any)   // result of response serialization
                print(response)
            }
        }
}
}
