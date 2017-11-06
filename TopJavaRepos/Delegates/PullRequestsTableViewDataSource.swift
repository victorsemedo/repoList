//
//  PullRequestsTableViewDataSource.swift
//  TopJavaRepos
//
//  Created by Victor Tavares on 04/11/17.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import UIKit

class PullRequestsTableViewDataSource: NSObject, UITableViewDataSource {
    
    var showOpened = true
    
    var openedPullRequests:[PullRequest] = [PullRequest]()
    
    var closedPullRequests:[PullRequest] = [PullRequest]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showOpened {
            return self.openedPullRequests.count
        }else {
            return self.closedPullRequests.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var pull:PullRequest?
        let pullCell = tableView.dequeueReusableCell(withIdentifier: "PullRequestCell", for: indexPath) as! PullRequestTableViewCell
        
        if showOpened {
            pull = self.openedPullRequests[indexPath.row]
        }else {
            pull = self.closedPullRequests[indexPath.row]
        }
        
        pullCell.uilblTitle?.text = pull?.title
        pullCell.uilblFullName?.text = pull?.fullName
        pullCell.uilblBody?.text = pull?.body
        pullCell.uilblUserName?.text = pull?.user.login
        
        if let avatarUrl = pull?.user.avatarUrl {
            let imageUrl = URL(string: avatarUrl)
            pullCell.uiimgAvatar.sd_setShowActivityIndicatorView(true)
            pullCell.uiimgAvatar.sd_setImage(with: imageUrl) { (image, error, cacheType, url) in
                pullCell.uiimgAvatar.sd_setShowActivityIndicatorView(false)
            }
        }
        
        return pullCell
    }
    
}
