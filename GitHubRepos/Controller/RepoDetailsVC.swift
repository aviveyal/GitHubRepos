//
//  RepoDetailsVC.swift
//  GitHubRepos
//
//  Created by admin on 19/06/2018.
//  Copyright © 2018 Aviv Eyal. All rights reserved.
//

import UIKit

class RepoDetailsVC: UIViewController {

    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var decription: UILabel!
    @IBOutlet weak var forks: UILabel!
    @IBOutlet weak var created: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var url: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    var repoNameSTR: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.repoName.text = repoNameSTR
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
