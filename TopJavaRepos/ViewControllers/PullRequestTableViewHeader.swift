//
//  TSRRepoTableViewHeaderView.swift
//  TopSwiftRepos
//
//  Created by Victor tavares on 08/05/17.
//  Copyright © 2017 Victor Tavares. All rights reserved.
//

import UIKit

class PullRequestTableViewHeader: UITableViewHeaderFooterView {
    
    var vcParent:PullRequestsViewController!
    
    let selectedColor = UIColor(red: 213.0/255.0, green: 149.0/255.0, blue: 53.0/255.0, alpha: 1.0)
    let defaultColor = UIColor.black

    @IBOutlet weak var uiBtnOpened: UIButton!
    
    @IBOutlet weak var uiBtnClosed: UIButton!
    
    @IBAction func showOpenedPullRequests(_ sender: Any) {
        self.uiBtnOpened.setTitleColor(selectedColor, for: .normal)
        self.uiBtnClosed.setTitleColor(defaultColor, for: .normal)
        
    }
    
    @IBAction func showClosedPullRequests(_ sender: Any) {
        self.uiBtnOpened.setTitleColor(defaultColor, for: .normal)
        self.uiBtnClosed.setTitleColor(selectedColor, for: .normal)
    }
    
}
