//
//  RepositoriesTableViewCell.swift
//  TopJavaRepos
//
//  Created by Victor Tavares on 03/11/17.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import UIKit

class RepositoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var uilblRepoName: UILabel!
    
    @IBOutlet weak var uilblRepoDescription: UILabel!
    
    @IBOutlet weak var uilblStar: UILabel!
    
    @IBOutlet weak var uilblFork: UILabel!
    
    @IBOutlet weak var uilblUsername: UILabel!
    
    @IBOutlet weak var uilblFullName: UILabel!
    
    @IBOutlet weak var uiimgAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
