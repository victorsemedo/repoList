//
//  File.swift
//  TopJavaRepos
//
//  Created by Victor Tavares on 05/11/17.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import Foundation

enum GitHubEndpoint: String {
    case repositories = "https://api.github.com/search/repositories"
    case pullRequests = "https://api.github.com/repos/<user_login>/<repository>/pulls"
    
    static func pullRequestsEndpoint(repository: Repository) -> String {
        let endpoint = GitHubEndpoint.pullRequests.rawValue.replacingOccurrences(of: "<user_login>", with: repository.owner.login)
        return endpoint.replacingOccurrences(of: "<repository>" ,with: repository.name)
    }
}

enum PullRequestState: String {
    case open
    case closed
}
