//
//  PullRequestTest.swift
//  TopJavaReposTests
//
//  Created by Victor tavares on 06/11/2017.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import XCTest
@testable import TopJavaRepos

class PullRequestTest: XCTestCase {

    private var pullRequests: [PullRequest]?

    override func setUp() {

        if let fileJsonUrl = Bundle(for: type(of: self)).url(forResource: "PullRequestsTest", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileJsonUrl)
                let jsonDecoder = JSONDecoder()
                pullRequests = try jsonDecoder.decode([PullRequest].self, from: data)
            } catch {
            }
        }
    }

    override func tearDown() {
        super.tearDown()
    }

    func testPullRequests() {
        XCTAssert(pullRequests?.count == 2)

        if let pullRequest = pullRequests?[0] {
            XCTAssertEqual(pullRequest.title, "#114 Added eip-aggregator")
            XCTAssertEqual(pullRequest.body, "New pattern - eip-aggregator. Added description, code, tests.")
            XCTAssertEqual(pullRequest.state, "open")
            XCTAssertNil(pullRequest.fullName)
            if let htmlUrl = pullRequest.htmlUrl {
                XCTAssertEqual(htmlUrl, "https://github.com/iluwatar/java-design-patterns/pull/663")
            } else {
                XCTFail("htmlUrl should not be nil")
            }

            XCTAssertEqual(pullRequest.user.login, "codinghog")
            XCTAssertEqual(pullRequest.user.avatarUrl, "https://avatars2.githubusercontent.com/u/868566?v=4")


        } else {
            XCTFail("Pull Request should not be nil")
        }

    }

}
