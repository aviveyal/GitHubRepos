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
    var repoList = [Repo]()
    
    //spinner and activity indicator initialize
    var activityIndicator :UIActivityIndicatorView = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator("Loading repositories") //start an activity indicator
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("reload"), object: nil, queue: nil) { notification in
            self.RepoTableView?.reloadData() //reload table after data received
            self.activityIndicator.stopAnimating() //stop the activity insicator
            self.effectView.removeFromSuperview() // remove from view
        }
        RepoTableView.delegate = self
        RepoTableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rowSelected"{
         if let destinationVC = segue.destination as? RepoDetailsVC {
        //dest.rowTitle = myRowsArray[path.row].title
        if let indexPath = RepoTableView.indexPathForSelectedRow {
            print(indexPath)
            print(self.repoList[indexPath.row].repoName)
            destinationVC.repoNameSTR = self.repoList[indexPath.row].repoName
            }
        }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return self.repoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoViewCell") as! RepoViewCell
        
        cell.name.text = self.repoList[indexPath.row].repoName
        cell.owner.text = self.repoList[indexPath.row].userName
        cell.desc.text = self.repoList[indexPath.row].description
        cell.stars.text = String(self.repoList[indexPath.row].stars)
        //let url = URL(string: (self.repoList[indexPath.row].avatar) )
        //cell.avatar.setImageWith(url!)
        AvatarDownload.instance.getImageForAvataer(urlStr: self.repoList[indexPath.row].avatar, callback: { (image) in
            cell.avatar.image = image
        })
        
        
        return cell
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
