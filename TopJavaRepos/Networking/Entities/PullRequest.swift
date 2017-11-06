//
//  PullRequest.swift
//  TopJavaRepos
//
//  Created by Victor Tavares on 05/11/17.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import Foundation

struct PullRequest: Codable {
    let title: String?
    let body: String?
    let state: String?
    let fullName: String?
    let htmlUrl: String?
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case title
        case body
        case state
        case fullName = "full_name"
        case htmlUrl = "html_url"
        case user = "user"
    }
}
