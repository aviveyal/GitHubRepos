//
//  RepoViewCell.swift
//  GitHubRepos
//
//  Created by admin on 17/06/2018.
//  Copyright © 2018 Aviv Eyal. All rights reserved.
//

import UIKit

class RepoViewCell: UITableViewCell {

    
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var owner: UILabel!
    @IBOutlet weak var star: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
