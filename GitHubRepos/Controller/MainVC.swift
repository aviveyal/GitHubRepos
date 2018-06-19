//
//  MainVC.swift
//  GitHubRepos
//
//  Created by admin on 18/06/2018.
//  Copyright © 2018 Aviv Eyal. All rights reserved.
//

import UIKit

class MainVC: UIViewController  {
  
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lastWeek"{
            if let destinationVC = segue.destination as? ReposVC {
                GitHubAPI.instance.getLastWeek(){ (repos) in
                    destinationVC.repoList = repos
                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                        destinationVC.navigationItem.title = "Last Week"
                       // print(repos)
                }
                
            }
        }
        else if segue.identifier == "lastDay"{
            if let destinationVC = segue.destination as? ReposVC {
                GitHubAPI.instance.getLastDay(){ (repos) in
                    destinationVC.repoList = repos
                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                    destinationVC.navigationItem.title = "Last Day"
                   // print(repos)
                }
        }
        }
        else if segue.identifier == "lastMonth"{
           if let destinationVC = segue.destination as? ReposVC {
                    GitHubAPI.instance.getLastMonth(){ (repos) in
                        destinationVC.repoList = repos
                        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                        destinationVC.navigationItem.title = "Last Month"
                      //  print(repos)
                 }
           }
    }
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
