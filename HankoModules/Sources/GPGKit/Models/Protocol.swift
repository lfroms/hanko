//
//  Protocol.swift
//  GPGKit
//
//  Created by Lukas Romsicki on 2022-10-23.
//

import gpgme

public enum `Protocol`: Int {
    case openPGP = 0
    case cms = 1
    case gpgConf = 2
    case assuan = 3
    case g13 = 4
    case uiServer = 5
    case spawn = 6
    case `default` = 254
    case unknown = 255
}

extension `Protocol` {
    init(from raw: gpgme_protocol_t) {
        self.init(rawValue: Int(raw.rawValue))!
    }

    var raw: gpgme_protocol_t {
        gpgme_protocol_t(rawValue: UInt32(rawValue))
    }
}
