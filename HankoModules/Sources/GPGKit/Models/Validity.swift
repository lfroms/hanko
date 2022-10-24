//
//  Validity.swift
//  GPGKit
//
//  Created by Lukas Romsicki on 2022-10-23.
//

import gpgme

public enum Validity: Int {
    case unknown = 0
    case undefined = 1
    case never = 2
    case marginal = 3
    case full = 4
    case ultimate = 5
}

extension Validity {
    init(from raw: gpgme_validity_t) {
        self.init(rawValue: Int(raw.rawValue))!
    }
}
