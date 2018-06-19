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
    @IBOutlet weak var url: UITextView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var language: UIImageView!
    @IBOutlet weak var star: UIImageView!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    //init string for each label (help init label from segue)
    var repoNameSTR: String = ""
    var userNameSTR: String = ""
    var descriptionSTR: String = ""
    var forksSTR: String = ""
    var createdSTR: String = ""
    var languageSTR: String = ""
    var urlSTR: String = ""
    var avatarSTR: String = ""
    var starsSTR : String = ""
    var favoriteList = [Repo]()
    var newRepo : Repo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.repoName.text = repoNameSTR
        self.userName.text = userNameSTR
        self.decription.text = descriptionSTR
        self.forks.text = forksSTR
        self.created.text = createdSTR
        self.url.text = urlSTR
        self.stars.text = starsSTR
        
        AvatarDownload.instance.getImageForAvataer(urlStr: avatarSTR, callback: { (image) in
            self.avatar.image = image
        })
        
        //init Repo
        newRepo = Repo(repoName: repoNameSTR, userName: userNameSTR, language: languageSTR, stars: Int(starsSTR)!, avatar: avatarSTR, forks: Int(forksSTR)!, date: createdSTR, description: descriptionSTR, link: urlSTR)
        
        self.favoriteList = Repo.getAllReposFromLocalDb(database: ModelSql.instance?.database) //get all list from local db and check if this repo already favorited
        
        //check if the repo exist on the favorite list
        for repo in favoriteList{
            if(newRepo == repo) //using comperable
            {
                //exist on favorite list
                star.image = UIImage(named: "starY")
                favoriteBtn.setTitle("Delete From Favorite", for: .normal)
                break;
            }
            else
            {
                star.image = UIImage(named: "star")
                
            }
            
        }
        
        
        switch(languageSTR)
        {
        case "C":
            self.language.image = UIImage(named: "C")
        case "C#":
            self.language.image = UIImage(named: "C#")
        case "HTML":
            self.language.image = UIImage(named: "HTML")
        case "JavaScript":
            self.language.image = UIImage(named: "JavaScript")
        case "Java":
            self.language.image = UIImage(named: "Java")
        case "Python":
            self.language.image = UIImage(named: "Python")
        case "CSS":
            self.language.image = UIImage(named: "CSS")
            //........
            
            
        default:
            break;
            //no image
        }
        avatar.layer.cornerRadius = 10
        avatar.clipsToBounds = true
        
        
    }
    
    @IBAction func addFavorite(_ sender: Any) {
        
        if(favoriteBtn.currentTitle == "Add To Favorite")
        {
            if(self.newRepo?.addRepoToLocalDb(database: ModelSql.instance?.database))!{
                //update the star to yellow
                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
               
                star.image = UIImage(named: "starY")
                favoriteBtn.setTitle("Delete From Favorite", for: .normal)
                
                //alert user that the repo Successfully added to favorite list
                let alert = UIAlertController(title: "Favorite list", message: "Successfully addded to your favorite list!", preferredStyle: UIAlertControllerStyle.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
                
            }
            else
            {
                //alert user that the repo not added to favorite list
                let alert = UIAlertController(title: "Error", message: "Couldn't add to your favorite list, please try again", preferredStyle: UIAlertControllerStyle.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
            
        else if(favoriteBtn.currentTitle == "Delete From Favorite")
        {
            if(self.newRepo?.deleteRepoFromLocalDb(repo: newRepo! ,database: ModelSql.instance?.database))!{
    
                star.image = UIImage(named: "star")
                favoriteBtn.setTitle("Add To Favorite", for: .normal)
                
                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                
                //alert user that the repo Successfully added to favorite list
                let alert = UIAlertController(title: "Favorite list", message: "Successfully deleted from favorite list!", preferredStyle: UIAlertControllerStyle.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
                
            }
            else
            {
                //alert user that the repo not added to favorite list
                let alert = UIAlertController(title: "Error", message: "Couldn't delete from favorite list, please try again", preferredStyle: UIAlertControllerStyle.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            
            
            
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}
