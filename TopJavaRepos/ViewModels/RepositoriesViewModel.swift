//
//  RepositoriesViewModel.swift
//  TopJavaRepos
//
//  Created by Victor Semedo on 12/11/19.
//  Copyright © 2019 VSemedo. All rights reserved.
//

import Foundation
import RxCocoa

class RepositoriesViewModel: GitHubDependencyInjected {
    
    var repositoryList = BehaviorRelay<[Repository]?>(value: nil)
    
    var error = BehaviorRelay<String?>(value: nil)

    private var currentPage = 0
    
    func fetchRepositories() {
        currentPage += 1
        dependencyContainer.service.fetchRepositories(page: currentPage) { (result) in
            switch result {
            case .success(let repositories):
                if var currentList = self.repositoryList.value {
                    currentList.append(contentsOf: repositories)
                    self.repositoryList.accept(currentList)
                } else {
                    self.repositoryList.accept(repositories)
                }
            case .error(let error):
                self.currentPage -= 1
                self.error.accept(error.localizedDescription)
            }
        }
    }
    
}

