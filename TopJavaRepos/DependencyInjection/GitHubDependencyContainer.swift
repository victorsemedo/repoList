//
//  GitHubDependencyContainer.swift
//  TopJavaRepos
//
//  Created by Victor Semedo on 12/11/19.
//  Copyright © 2019 VSemedo. All rights reserved.
//

import Foundation

class GitHubDependencyContainer {
    
    var service: GitHubService
    
    init() {
        self.service = GitHubJavaService()
    }
}

