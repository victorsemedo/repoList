//
//  RepositoriesTableViewDelegate.swift
//  TopJavaRepos
//
//  Created by Victor Tavares on 04/11/17.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import UIKit

class RepositoriesTableViewDelegate: NSObject, UITableViewDelegate {
    
    var parentVC: RepositoriesViewController?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:true)
        parentVC?.selectedRow = indexPath.row
        parentVC?.performSegue(withIdentifier: "showPullRequestsSegueID", sender: self)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rowCount = tableView.numberOfRows(inSection: indexPath.section)
        
        if indexPath.row == rowCount - 1 {
            parentVC?.viewModel.fetchRepositories()
        }
    }

}
