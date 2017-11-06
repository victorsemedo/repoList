//
//  RepositoryTest.swift
//  TopJavaReposTests
//
//  Created by Victor tavares on 06/11/2017.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import XCTest
@testable import TopJavaRepos

class RepositoryTest: XCTestCase {

    private var repositories: RepositoriesResponse?

    override func setUp() {

        if let fileJsonUrl = Bundle(for: type(of: self)).url(forResource: "RepositoriesTest", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileJsonUrl)
                let jsonDecoder = JSONDecoder()
                repositories = try jsonDecoder.decode(RepositoriesResponse.self, from: data)
            } catch {
            }
        }
    }

    override func tearDown() {
        super.tearDown()
    }

    func testRepositories() {
        XCTAssert(repositories?.items.count == 2)
        XCTAssertEqual(repositories?.incompleteResults, false)
        XCTAssertEqual(repositories?.totalCount, 2)

        if let repository = repositories?.items[0] {
            XCTAssertEqual(repository.name, "RxJava")
            XCTAssertEqual(repository.fullName, "ReactiveX/RxJava2")
            XCTAssertEqual(repository.name, "RxJava")
            XCTAssertEqual(repository.description, "RxJava – Reactive Extensions for the JVM – a library for composing asynchronous and event-based programs using observable sequences for the Java VM.")
            XCTAssertEqual(repository.forks, 5014)
            XCTAssertEqual(repository.stars, 28462)

            XCTAssertEqual(repository.owner.login, "ReactiveX")
            XCTAssertEqual(repository.owner.avatarUrl, "https://avatars1.githubusercontent.com/u/6407041?v=4")
        } else {
            XCTFail("Pull Request should not be nil")
        }

    }

}
