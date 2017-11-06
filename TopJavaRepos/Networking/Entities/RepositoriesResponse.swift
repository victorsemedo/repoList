//
//  RepositoriesResponse.swift
//  TopJavaRepos
//
//  Created by Victor Tavares on 05/11/17.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import Foundation

struct RepositoriesResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
    
}
