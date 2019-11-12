//
//  PullRequestsViewController.swift
//  TopJavaRepos
//
//  Created by Victor Tavares on 03/11/17.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import UIKit
import SVProgressHUD

class PullRequestsViewController: UITableViewController, DisplayError, GitHubDependencyInjected {
    
    var repository: Repository?
    
    var parentVC: RepositoriesViewController?
    
    var error: Error?
    
    private var pullDataSource = PullRequestsTableViewDataSource()
    
    private var pullDelegate = PullRequestsTableViewDelegate()
    
    private var currentOpenedPage = 0

    private var currentClosedPage = 0
    
    private var showLoadingCount = 0 {
        didSet {
            if oldValue == 0 && showLoadingCount == 1 {
                SVProgressHUD.show(withStatus: NSLocalizedString("STR_LOADING", comment:""))
            } else if showLoadingCount == 0 {
                SVProgressHUD.dismiss()
                
                if let error = error {
                    onError(error.localizedDescription)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        registerTableHeaderNib()
        countPullRequests()
        fetchPullRequests()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpTableView() {
        self.tableView.dataSource = pullDataSource
        self.tableView.delegate = pullDelegate
        self.tableView.tableFooterView = UIView()
        pullDelegate.parentVC = self
    }
    
    func registerTableHeaderNib() {
        let nib = UINib(nibName: "PullRequestTableViewHeader", bundle: nil)
        self.tableView.register(nib, forHeaderFooterViewReuseIdentifier:"PullRequestTableViewHeader")
    }
    
    func showOpenedPullRequests(_ show: Bool) {
        self.pullDataSource.showOpened = show
        
        if self.pullDataSource.closedPullRequests.count == 0 {
            fetchPullRequests()
        } else {
            self.tableView.reloadData()
        }
    }
    
    func showProgress(){
        showLoadingCount += 1
    }
    
    func dissmissProgress() {
        showLoadingCount -= 1
    }
    
    func countPullRequests() {
        if let repository = repository {
            self.showProgress()
            self.dependencyContainer.service.countRepositoryPullRequests(repository: repository, state: PullRequestState.open.rawValue, callback: { (result) in
                self.dissmissProgress()
                switch result {
                case .success(let count):
                    self.pullDelegate.opened = count
                    self.tableView.reloadData()
                case .error(let error):
                    self.error = error
                }
            })
            
            self.showProgress()
            self.dependencyContainer.service.countRepositoryPullRequests(repository: repository, state: PullRequestState.closed.rawValue, callback: { (result) in
                self.dissmissProgress()
                switch result {
                case .success(let count):
                    self.pullDelegate.closed = count
                    self.tableView.reloadData()
                case .error(let error):
                    self.error = error
                }
            })
        }
    }
    
    func fetchPullRequests() {
        var page = 0
        var state = PullRequestState.open.rawValue
        if self.pullDataSource.showOpened {
            currentOpenedPage += 1
            page = currentOpenedPage
        } else {
            currentClosedPage += 1
            page = currentClosedPage
            state = PullRequestState.closed.rawValue
        }
        
        if let repository = repository {
            self.showProgress()
            self.dependencyContainer.service.fetchRepositoryPullRequests(repository: repository,
                                                               state: state,
                                                               page: page) { (result) in
                self.dissmissProgress()
                switch result {
                case .success(let pullRequests):
                    if self.pullDataSource.showOpened {
                        self.pullDataSource.openedPullRequests.append(contentsOf: pullRequests)
                    } else {
                        self.pullDataSource.closedPullRequests.append(contentsOf: pullRequests)
                    }
                    self.tableView.reloadData()
                    
                case .error(let error):
                    self.error = error
                }
                
            }
        }
    }
}
