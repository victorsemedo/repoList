//
//  RepositoriesUIViewController.swift
//  TopJavaRepos
//
//  Created by Victor Tavares on 03/11/17.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import UIKit

class RepositoriesViewController: UITableViewController, DisplayError {

    private var repoDataSource = RepositoriesTableViewDataSource()
    
    private var repoDelegate =  RepositoriesTableViewDelegate()
    
    private var currentPage = 0
    
    var selectedRow: Int?
    
    let service = GitHubJavaService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        fetchRepositories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setUpTableView() {
        repoDelegate.parentVC = self
        self.tableView.dataSource = repoDataSource
        self.tableView.delegate = repoDelegate
        self.tableView.tableFooterView = UIView()
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    
    func fetchRepositories() {
        showActivityIndicator()
        currentPage += 1
        service.fetchRepositories(page: currentPage) { (result) in
            self.dismissActivityIndicator()
            switch result {
            case .success(let repositories):
                self.repoDataSource.repositories.append(contentsOf: repositories)
                self.tableView.reloadData()
            case .error(let error):
                self.currentPage -= 1
                self.onError(error.localizedDescription)
            }
        }
    }
    
    func showActivityIndicator() {
        if let spinner = self.tableView.tableFooterView as? UIActivityIndicatorView {
            spinner.startAnimating()
            spinner.isHidden = false
        } else {
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
        }
    }
    
    func dismissActivityIndicator() {
        if let spinner = self.tableView.tableFooterView as? UIActivityIndicatorView {
            spinner.stopAnimating()
            spinner.isHidden = true
        }
    }
}

extension RepositoriesViewController {
    
    // MARK: -  UIStoryboardSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPullRequestsSegueID" {
            let pullRequestsVC = (segue.destination as! PullRequestsViewController)
            pullRequestsVC.repository = repoDataSource.repositories[self.selectedRow!]
            pullRequestsVC.parentVC = self
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }
}
