//
//  UserID.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-26.
//

struct UserID: Equatable, Hashable {
    let name: String
    let email: String
    let comment: String
    let validity: Validity
    let hashId: String

    // TODO: Disabled state.
}

extension UserID {
    init(from record: Record) throws {
        let metadata = record.properties[9]

        self.name = metadata
            .removingRegexMatches(pattern: "<([^>]+)>|\\((.*)\\)")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        self.email = metadata.substrings(matching: "<([^>]+)>")
            .first?
            .removingRegexMatches(pattern: "<|>")
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? .empty

        self.comment = metadata.substrings(matching: "\\((.*?)\\)")
            .first?
            .removingRegexMatches(pattern: "\\(|\\)")
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? .empty

        self.validity = Validity(rawValue: record.properties[1]) ?? .unknown
        self.hashId = record.properties[7]
    }
}
