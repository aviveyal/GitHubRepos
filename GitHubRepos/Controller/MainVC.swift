//
//  MainVC.swift
//  GitHubRepos
//
//  Created by admin on 18/06/2018.
//  Copyright © 2018 Aviv Eyal. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GitHubAPI.instance.getLastDay()
        print("Main page")
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
