//
//  Key+Hashable.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2022-10-23.
//

import GPGKit

extension Key: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(fingerprint)
    }

    public static func == (lhs: Key, rhs: Key) -> Bool {
        return lhs.fingerprint == rhs.fingerprint
    }
}
