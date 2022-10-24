//
//  PinEntryMode.swift
//  GPGKit
//
//  Created by Lukas Romsicki on 2022-10-23.
//

import gpgme

public enum PinEntryMode: Int {
    case `default` = 0
    case ask = 1
    case cancel = 2
    case error = 3
    case loopback = 4
}

extension PinEntryMode {
    var raw: gpgme_pinentry_mode_t {
        .init(rawValue: .init(rawValue))
    }
}
