//
//  PullRequestsTableViewDelegate.swift
//  TopJavaRepos
//
//  Created by Victor Tavares on 04/11/17.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import UIKit

class PullRequestsTableViewDelegate: NSObject, UITableViewDelegate {

    var opened: Int = 0
    
    var closed: Int = 0
    
    var parentVC: PullRequestsViewController?

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier:"PullRequestTableViewHeader") as? PullRequestTableViewHeader {
            header.uiBtnOpened.setTitle("\(opened) " + NSLocalizedString("STR_OPENED", comment: ""), for:.normal)
            header.uiBtnClosed.setTitle("/\(closed) " + NSLocalizedString("STR_CLOSED", comment: ""), for:.normal)
            header.parentVC = parentVC
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let datasource = tableView.dataSource as? PullRequestsTableViewDataSource {
            let rowCount = tableView.numberOfRows(inSection: indexPath.section)
            
            if (datasource.showOpened && rowCount < opened) ||
               (!datasource.showOpened && rowCount > opened){
                if indexPath.row == rowCount - 1 {
                    parentVC?.fetchPullRequests()
                }
            }
        }
    }
    
}
