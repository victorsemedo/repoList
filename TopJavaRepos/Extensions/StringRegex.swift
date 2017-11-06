//
//  StringRegExp.swift
//  TopJavaRepos
//
//  Created by Victor Tavares on 06/11/17.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import Foundation

extension String {
    
    func matches(for regex: String, in text: String) throws -> [String] {
        let regex = try NSRegularExpression(pattern: regex)
        let results = regex.matches(in: text,
                                    range: NSRange(text.startIndex..., in: text))
        return results.map {
            String(text[Range($0.range, in: text)!])
        }
    }

    
}
