//
//  TSRRepoTableViewHeaderView.swift
//  TopSwiftRepos
//
//  Created by Victor tavares on 08/05/17.
//  Copyright © 2017 Victor Tavares. All rights reserved.
//

import UIKit

class PullRequestTableViewHeader: UITableViewHeaderFooterView {
    
    var parentVC:PullRequestsViewController?

    @IBOutlet weak var uiBtnOpened: UIButton!
    
    @IBOutlet weak var uiBtnClosed: UIButton!
    
    @IBAction func showOpenedPullRequests(_ sender: Any) {
        self.parentVC?.showOpenedPullRequests(true)
        changeSelectedButton(selected: uiBtnOpened, deselected: uiBtnClosed)
    }
    
    @IBAction func showClosedPullRequests(_ sender: Any) {
        self.parentVC?.showOpenedPullRequests(false)
        changeSelectedButton(selected: uiBtnClosed, deselected: uiBtnOpened)
    }
    
    func changeSelectedButton(selected: UIButton, deselected: UIButton) {
        let selectedColor = UIColor(red: 213.0/255.0, green: 149.0/255.0, blue: 53.0/255.0, alpha: 1.0)
        selected.setTitleColor(selectedColor, for: .normal)
        deselected.setTitleColor(UIColor.black, for: .normal)
    }
    
}
