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
        let newRepo = Repo(repoName: repoNameSTR, userName: userNameSTR, language: languageSTR, stars: Int(starsSTR)!, avatar: avatarSTR, forks: Int(forksSTR)!, date: createdSTR, description: descriptionSTR, link: urlSTR)
        if(newRepo.addRepoToLocalDb(database: ModelSql.instance?.database)){
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    

}
