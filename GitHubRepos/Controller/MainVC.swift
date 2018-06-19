//
//  MainVC.swift
//  GitHubRepos
//
//  Created by admin on 18/06/2018.
//  Copyright © 2018 Aviv Eyal. All rights reserved.
//

import UIKit
import Alamofire

class MainVC: UIViewController  {
  
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var pageNumber = 1 //load the first page
        
        if segue.identifier == "favorite"{
            if let destinationVC = segue.destination as? ReposVC {
                destinationVC.repoList = Repo.getAllReposFromLocalDb(database: ModelSql.instance?.database)
                destinationVC.favoriteList = destinationVC.repoList
                destinationVC.navigationItem.title = "Favorite"
                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                destinationVC.needReload = false
                
            }
        }
        
        else if(isConnectedToInternet()){
        if segue.identifier == "lastWeek"{
            if let destinationVC = segue.destination as? ReposVC {
                GitHubAPI.instance.getLastWeek(pageNumber: pageNumber){ (repos) in
                    destinationVC.repoList = repos
                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                        destinationVC.navigationItem.title = "Last Week"
                    destinationVC.needReload = true
                       
                }
                
            }
        }
        else if segue.identifier == "lastDay"{
            if let destinationVC = segue.destination as? ReposVC {
                GitHubAPI.instance.getLastDay(pageNumber: pageNumber){ (repos) in
                    destinationVC.repoList = repos
                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                    destinationVC.navigationItem.title = "Last Day"
                    destinationVC.needReload = true
                   
                }
        }
        }
        else if segue.identifier == "lastMonth"{
           if let destinationVC = segue.destination as? ReposVC {
            GitHubAPI.instance.getLastMonth(pageNumber: pageNumber){ (repos) in
                        destinationVC.repoList = repos
                        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                        destinationVC.navigationItem.title = "Last Month"
                        destinationVC.needReload = true
                      
                 }
           }
            }
        }
        else
        {
            //alert user that he is offlie and cant search repositories
            let alert = UIAlertController(title: "You are offline!", message: "Please connect to the internet before searching repositories", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
       
    }
    
    
    //check for internet connection - if not cant search repositories
    func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
