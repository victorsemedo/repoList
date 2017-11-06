//
//  RepositoriesTableViewDataSourceTest.swift
//  TopJavaReposTests
//
//  Created by Victor tavares on 06/11/2017.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import XCTest
@testable import TopJavaRepos

class RepositoriesTableViewDataSourceTest: XCTestCase {

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
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RepositoriesViewController") as! RepositoriesViewController

        let datasource = RepositoriesTableViewDataSource()

        if let items = repositories?.items {
            datasource.repositories = items
            viewController.tableView.dataSource = datasource
            viewController.tableView.reloadData()
            let count = datasource.tableView(viewController.tableView, numberOfRowsInSection: 0)
            XCTAssertEqual(count, 2)

            if let cell = datasource.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? RepositoriesTableViewCell {
                XCTAssertNotNil(cell.uilblFork.text)
                XCTAssertNotNil(cell.uilblFullName.text)
                XCTAssertNotNil(cell.uilblRepoName.text)
                XCTAssertNotNil(cell.uilblStar.text)
                XCTAssertNotNil(cell.uilblRepoDescription.text)
            } else {
                XCTFail("RepositoriesTableViewCell should not be nil")
            }
        } else {
            XCTFail("Repositories should not be nil")
        }
    }

}

