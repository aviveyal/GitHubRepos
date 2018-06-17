//
//  ReposVC.swift
//  GitHubRepos
//
//  Created by admin on 17/06/2018.
//  Copyright © 2018 Aviv Eyal. All rights reserved.
//

import UIKit

class ReposVC: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    
    
    @IBOutlet weak var RepoTableView: UITableView!
    var repoList = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        self.repoList.append("hey1");
        self.repoList.append("hey2");
        self.repoList.append("hey3");
        
        RepoTableView.delegate = self
        RepoTableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.repoList.count)
        return self.repoList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoViewCell") as! RepoViewCell
        
        cell.name.text = self.repoList[indexPath.row]
        
        
        return cell
    }
    // MARK: - Table view data source

   
}
