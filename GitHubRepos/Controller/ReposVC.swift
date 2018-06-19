//
//  ReposVC.swift
//  GitHubRepos
//
//  Created by admin on 17/06/2018.
//  Copyright © 2018 Aviv Eyal. All rights reserved.
//

import UIKit

class ReposVC: UIViewController, UITableViewDelegate , UITableViewDataSource,UISearchBarDelegate  {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var RepoTableView: UITableView!
    var repoList = [Repo]()
    var favoriteList = [Repo]()
    var currentRepoList = [Repo]()
    var needReload = true //incase using asyncronic get reqests
    //spinner and activity indicator initialize
    var activityIndicator :UIActivityIndicatorView = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var pageNumber : Int = 1 // hold the page number to load
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageNumber=1
        self.currentRepoList = self.repoList
        if(needReload){
        activityIndicator("Loading repositories") //start an activity indicator
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("reload"), object: nil, queue: nil) { notification in
            self.currentRepoList = self.repoList
            self.favoriteList = Repo.getAllReposFromLocalDb(database: ModelSql.instance?.database) //get all list from local db and check each repo if already favorited
            if(self.navigationItem.title == "Favorite")
            {
                self.repoList =  self.favoriteList // not only remove the star , remove all cell
                self.currentRepoList = self.repoList
            }
            self.RepoTableView?.reloadData() //reload table after data received
            self.activityIndicator.stopAnimating() //stop the activity insicator
            self.effectView.removeFromSuperview() // remove from view
            
        
    }
       
        
        
        RepoTableView.delegate = self
        RepoTableView.dataSource = self
        searchBar.delegate = self
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
         if let destinationVC = segue.destination as? RepoDetailsVC {
         if let indexPath = RepoTableView.indexPathForSelectedRow {
            
            destinationVC.repoNameSTR = self.currentRepoList[indexPath.row].repoName
            destinationVC.userNameSTR = self.currentRepoList[indexPath.row].userName
            destinationVC.descriptionSTR = self.currentRepoList[indexPath.row].description
            destinationVC.starsSTR = String(self.currentRepoList[indexPath.row].stars)
            destinationVC.forksSTR = String(self.currentRepoList[indexPath.row].forks)
            destinationVC.createdSTR = self.currentRepoList[indexPath.row].date
            destinationVC.urlSTR = self.currentRepoList[indexPath.row].link
            destinationVC.repoNameSTR = self.currentRepoList[indexPath.row].repoName
            destinationVC.avatarSTR = self.currentRepoList[indexPath.row].avatar
            destinationVC.languageSTR = self.currentRepoList[indexPath.row].language

            }
        }
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.currentRepoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == self.currentRepoList.count-7) { //load more repositories when you 7 from the last one
            pageNumber+=1
           switch(navigationItem.title) // to know which function to load
           {
           case "Last Week"?:
            GitHubAPI.instance.getLastWeek(pageNumber: pageNumber){ (repos) in
                self.repoList.append(contentsOf: repos)
                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
            }
           case "Last Day"?:
            GitHubAPI.instance.getLastDay(pageNumber: pageNumber){ (repos) in
                self.repoList.append(contentsOf: repos)
                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
            }
            
           case "Last Month"?:
            GitHubAPI.instance.getLastMonth(pageNumber: pageNumber){ (repos) in
                self.repoList.append(contentsOf: repos)
                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
            }
            
           default:
            break
           }
            
        }
        
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoViewCell") as! RepoViewCell
        
        //check if the repo exist on the favorite list
        if(self.favoriteList.count == 0)
        {
            cell.star.image = UIImage(named: "star")
        }
        
        for repo in favoriteList{
            if(self.currentRepoList[indexPath.row] == repo) //using comperable
            {
                //exist on favorite list
                
                cell.star.image = UIImage(named: "starY")
                break;
            }
            else
            {
                cell.star.image = UIImage(named: "star")
                
                
            }
            
        }
        
        cell.name.text = self.currentRepoList[indexPath.row].repoName
        cell.owner.text = self.currentRepoList[indexPath.row].userName
        cell.desc.text = self.currentRepoList[indexPath.row].description
        cell.stars.text = String(self.currentRepoList[indexPath.row].stars)
        
        AvatarDownload.instance.getImageForAvataer(urlStr: self.currentRepoList[indexPath.row].avatar, callback: { (image) in
            cell.avatar.image = image
        })
        cell.avatar.layer.cornerRadius = 10
        cell.avatar.clipsToBounds = true
        
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty)
        {
            currentRepoList = repoList
            self.RepoTableView?.reloadData()
            return
        }
        currentRepoList = repoList.filter({ Repo -> Bool  in
            if(Repo.repoName.lowercased().contains(searchText.lowercased()) || Repo.userName.lowercased().contains(searchText.lowercased()))
            {
                return true
            }
            return false
            
        })
        
        self.RepoTableView?.reloadData()
    }
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        self.searchBar.showsCancelButton = true
//    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder() // hides the keyboard.
        
    }
    
    // design of the activity indicator and start animating

    func activityIndicator(_ title: String) {
        
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 46))
        strLabel.text = title
        strLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 205, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        //UIApplication.shared.beginIgnoringInteractionEvents()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
   
}
