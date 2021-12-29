//
//  String+RemovingRegexMatches.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-27.
//

import Foundation

extension String {
    func removingRegexMatches(pattern: String, replaceWith: String = "") -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let range = NSRange(location: 0, length: count)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceWith)
        } catch {
            return self
        }
    }
}
