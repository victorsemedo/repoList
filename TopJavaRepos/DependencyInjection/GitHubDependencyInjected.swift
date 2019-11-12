//
//  GitHubDependencyInjected.swift
//  TopJavaRepos
//
//  Created by Victor Semedo on 12/11/19.
//  Copyright © 2019 VSemedo. All rights reserved.
//

import Foundation

struct GitHubDependencyInjectionMap {
    
    static var dependecyContainer: GitHubDependencyContainer = GitHubDependencyContainer()
    
}

protocol GitHubDependencyInjected {
    
    var dependencyContainer: GitHubDependencyContainer { get }
    
}

extension GitHubDependencyInjected {
    
    var dependencyContainer: GitHubDependencyContainer {
        get {
            return GitHubDependencyInjectionMap.dependecyContainer
        }
    }
}

