//
//  PullRequestsViewModel.swift
//  TopJavaRepos
//
//  Created by Victor Semedo on 12/11/19.
//  Copyright © 2019 VSemedo. All rights reserved.
//

import Foundation
import RxCocoa

class PullRequestsViewModel: GitHubDependencyInjected {
    
    let repository: Repository
    
    var openedPR = BehaviorRelay<[PullRequest]?>(value: nil)

    var closedPR = BehaviorRelay<[PullRequest]?>(value: nil)
    
    var countPR = BehaviorRelay<(Int, Int)>(value: (0, 0))

    var error = BehaviorRelay<String?>(value: nil)

    private var currentOpenedPage = 0
    
    private var currentClosedPage = 0
    
    init(repository: Repository) {
       self.repository = repository
    }
    
    func countPullRequests() {
        self.countPullRequests(withState: .open)
        self.countPullRequests(withState: .closed)
    }
    
    func fetchPullRequests(withState state: PullRequestState) {
        var page = 0
        switch state {
        case .open:
            currentOpenedPage += 1
            page = currentOpenedPage
        case .closed:
            currentClosedPage += 1
            page = currentClosedPage
        }
        
        self.dependencyContainer.service.fetchRepositoryPullRequests(repository: repository, state: state.rawValue, page: page) { (result) in
            switch result {
            case .success(let pullRequests):
                self.updatePullRequests(pullRequests, forState: state)
            case .error(let error):
                self.error.accept(error.localizedDescription)
            }
        }
    }
}


private extension PullRequestsViewModel {
    
    func countPullRequests(withState state: PullRequestState) {
        self.dependencyContainer.service.countRepositoryPullRequests(repository: repository, state: state.rawValue, callback: { (result) in
            let currentCount = self.countPR.value
            switch result {
            case .success(let count):
                if state == .open {
                    self.countPR.accept((count, currentCount.1))
                } else {
                    self.countPR.accept((currentCount.0, count))
                }
            case .error(let error):
                self.error.accept(error.localizedDescription)
            }
        })
    }
    
    
    func updatePullRequests(_ pullRequests: [PullRequest], forState state: PullRequestState) {
        switch state {
        case .open:
            if var currentList = self.openedPR.value {
                currentList.append(contentsOf: pullRequests)
                self.openedPR.accept(currentList)
            } else {
                self.openedPR.accept(pullRequests)
            }
        case .closed:
            if var currentList = self.closedPR.value {
                currentList.append(contentsOf: pullRequests)
                self.closedPR.accept(currentList)
            } else {
                self.closedPR.accept(pullRequests)
            }
        }
    }
    
}
