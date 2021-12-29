//
//  String+Substrings.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-27.
//

import Foundation

extension String {
    func substrings(matching pattern: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let results = regex.matches(
                in: self,
                range: NSRange(startIndex..., in: self)
            )

            return results.map {
                String(self[Range($0.range, in: self)!])
            }

        } catch {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
