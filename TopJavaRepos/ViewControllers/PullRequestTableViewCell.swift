//
//  PullRequestTableViewCell.swift
//  TopJavaRepos
//
//  Created by Victor Tavares on 03/11/17.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import UIKit

class PullRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var uilblTitle: UILabel!
    
    @IBOutlet weak var uilblBody: UILabel!
    
    @IBOutlet weak var uilblUserName: UILabel!
    
    @IBOutlet weak var uilblFullName: UILabel!
    
    @IBOutlet weak var uiimgAvatar: UIImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
