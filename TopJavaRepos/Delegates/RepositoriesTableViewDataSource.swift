//
//  RepositoriesTableViewDataSource.swift
//  TopJavaRepos
//
//  Created by Victor Tavares on 04/11/17.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import UIKit
import SDWebImage

class RepositoriesTableViewDataSource: NSObject, UITableViewDataSource {
    
    var repositories = [Repository]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repoCell = tableView.dequeueReusableCell(withIdentifier: "RepositorieCell", for: indexPath) as! RepositoriesTableViewCell
        let repo = repositories[indexPath.row]
        
        repoCell.uilblRepoName?.text = repo.name
        repoCell.uilblRepoDescription?.text = repo.description
        repoCell.uilblUsername?.text = repo.owner.login
        repoCell.uilblFullName?.text = repo.fullName
        repoCell.uilblStar.text = "\(repo.stars)"
        repoCell.uilblFork.text = "\(repo.forks)"
        
        let imageUrl = URL(string: repo.owner.avatarUrl)
        repoCell.uiimgAvatar.sd_setShowActivityIndicatorView(true)
        repoCell.uiimgAvatar.sd_setImage(with: imageUrl) { (image, error, cacheType, url) in
            repoCell.uiimgAvatar.sd_setShowActivityIndicatorView(false)
        }
        
        return repoCell
    }    
}
