//
//  RepositoriesUIViewController.swift
//  TopJavaRepos
//
//  Created by Victor Tavares on 03/11/17.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import UIKit
import RxSwift

class RepositoriesViewController: UITableViewController, DisplayError {

    private var repoDataSource = RepositoriesTableViewDataSource()
    
    private var repoDelegate =  RepositoriesTableViewDelegate()
    
    var selectedRow: Int?
    
    let viewModel = RepositoriesViewModel()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpObservables()
        showActivityIndicator()
        viewModel.fetchRepositories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setUpTableView() {
        repoDelegate.parentVC = self
        tableView.dataSource = repoDataSource
        tableView.delegate = repoDelegate
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func setUpObservables() {
        viewModel.repositoryList.subscribe(onNext: { (repositories) in
            self.dismissActivityIndicator()
            self.repoDataSource.repositories = repositories ?? [Repository]()
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.error.subscribe(onNext: { (error) in
            if let error = error {
                self.onError(error)
            }
        }).disposed(by: disposeBag)
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
        if segue.identifier == "showPullRequestsSegueID",
            let pullRequestsVC = segue.destination as? PullRequestsViewController,
            let selectedRow = self.selectedRow,
            repoDataSource.repositories.count > selectedRow {
            let repository = repoDataSource.repositories[selectedRow]
            let viewModel = PullRequestsViewModel(repository: repository)
            pullRequestsVC.viewModel = viewModel
            pullRequestsVC.parentVC = self
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }
}
