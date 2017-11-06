//
//  GitHubService.swift
//  TopJavaRepos
//
//  Created by Victor Tavares on 05/11/17.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}

typealias RepositoriesReturnFunc = (Result<[Repository]>) -> Void

typealias PullResquestsReturnFunc = (Result<[PullRequest]>) -> Void

typealias CountPullResquestsReturnFunc = (Result<Int>) -> Void

protocol GitHubService {
    
    func fetchRepositories(page: Int, callback: @escaping RepositoriesReturnFunc)
    
    func fetchRepositoryPullRequests(repository: Repository, state: String?, page: Int, callback: @escaping PullResquestsReturnFunc)
    
    func countRepositoryPullRequests(repository: Repository, state: String?, callback: @escaping CountPullResquestsReturnFunc)

}

struct GitHubServiceError: Error {
    
}


