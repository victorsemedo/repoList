//
//  PullRequestsViewController.swift
//  TopJavaRepos
//
//  Created by Victor Tavares on 03/11/17.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import UIKit
import SVProgressHUD
import RxSwift

class PullRequestsViewController: UITableViewController, DisplayError, GitHubDependencyInjected {
    
    var viewModel: PullRequestsViewModel?
    
    var parentVC: RepositoriesViewController?
    
    var error: Error?
    
    private var pullDataSource = PullRequestsTableViewDataSource()
    
    private var pullDelegate = PullRequestsTableViewDelegate()
    
    let disposeBag = DisposeBag()

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
        setUpObservables()
        showProgress()
        viewModel?.countPullRequests()
        viewModel?.fetchPullRequests(withState: PullRequestState.open)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpTableView() {
        self.tableView.dataSource = pullDataSource
        self.tableView.delegate = pullDelegate
        self.tableView.tableFooterView = UIView()
        let nib = UINib(nibName: "PullRequestTableViewHeader", bundle: nil)
        self.tableView.register(nib, forHeaderFooterViewReuseIdentifier:"PullRequestTableViewHeader")
        pullDelegate.parentVC = self
        self.navigationItem.title = viewModel?.repository.name
    }
    
    func setUpObservables() {
        viewModel?.openedPR.subscribe(onNext: { (pullRequests) in
            self.pullDataSource.openedPullRequests = pullRequests ?? [PullRequest]()
            self.dissmissProgress()
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel?.closedPR.subscribe(onNext: { (pullRequests) in
            self.pullDataSource.closedPullRequests = pullRequests ?? [PullRequest]()
            self.dissmissProgress()
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel?.countPR.subscribe(onNext: { (count) in
            self.pullDelegate.opened = count.0
            self.pullDelegate.closed = count.1
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel?.error.subscribe(onNext: { (error) in
            if let error = error {
                self.onError(error)
            }
        }).disposed(by: disposeBag)
    }
    
    func showOpenedPullRequests(_ show: Bool) {
        self.pullDataSource.showOpened = show
        
        if self.pullDataSource.closedPullRequests.count == 0 {
            viewModel?.fetchPullRequests(withState: PullRequestState.closed)
        } else {
            self.tableView.reloadData()
        }
    }
    
    func showProgress(_ count: Int = 1){
        showLoadingCount += count
    }
    
    func dissmissProgress(_ count: Int = 1){
        showLoadingCount -= count
    }
}
