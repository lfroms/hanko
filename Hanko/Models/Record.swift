//
//  Record.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-26.
//

struct Record: Hashable, Equatable {
    let data: String

    init(data: String) {
        self.data = data
    }

    var properties: [String] {
        data.components(separatedBy: ":")
    }

    var type: RecordType {
        RecordType(rawValue: properties[0]) ?? .unknown
    }
}
