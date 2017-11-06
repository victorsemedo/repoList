//
//  Repository.swift
//  TopJavaRepos
//
//  Created by Victor Tavares on 05/11/17.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import Foundation

struct Repository: Codable {
    let name: String
    let fullName: String?
    let description: String?
    let forks: Int
    let stars: Int
    let owner: User

    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
        case description
        case forks
        case stars = "stargazers_count"
        case owner
    }
    
}
