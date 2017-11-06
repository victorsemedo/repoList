//
//  GitHubJavaServiceTest.swift
//  TopJavaReposTests
//
//  Created by Victor Tavares on 06/11/17.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import XCTest
@testable import TopJavaRepos

class GitHubJavaServiceTest: XCTestCase {
    
    var service:GitHubJavaService = GitHubJavaService()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchRepository() {
        self.service.fetchRepositories(page: 1) { (result) in
            switch result {
            case .success(let repositories):
                XCTAssert(repositories.count == 30)
            case .error( _):
                XCTAssert(false)
            }
        }
     }
    
    func testFetchPullRequests() {
        let user = User(login: "HannahMitt", avatarUrl: "")
        let repository = Repository(name: "HomeMirror", fullName: nil, description: nil, forks: 0, stars: 0, owner: user)
        self.service.fetchRepositoryPullRequests(repository: repository, state: PullRequestState.open.rawValue, page: 1) { (result) in
            switch result {
            case .success(let pullRequests):
                XCTAssertNotNil(pullRequests)
            case .error( _):
                XCTAssert(false)
            }
        }
    }
    
    func testCountPullRequests() {
        let user = User(login: "HannahMitt", avatarUrl: "")
        let repository = Repository(name: "HomeMirror", fullName: nil, description: nil, forks: 0, stars: 0, owner: user)
        self.service.countRepositoryPullRequests(repository: repository, state: PullRequestState.open.rawValue) { (result) in
            switch result {
            case .success(let pullRequests):
                XCTAssertNotNil(pullRequests)
            case .error( _):
                XCTAssert(false)
            }
        }
    }
        
}
