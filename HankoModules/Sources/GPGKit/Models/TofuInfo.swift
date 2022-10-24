//
//  TofuInfo.swift
//  GPGKit
//
//  Created by Lukas Romsicki on 2022-10-23.
//

import Foundation
import gpgme

public struct TofuInfo {
    public let validity: Int
    public let policy: TofuPolicy
    public let signatureCount: Int
    public let encryptionCount: Int
    public let firstSigned: Date
    public let lastSigned: Date
    public let firstEncrypted: Date
    public let lastEncrypted: Date
    public let description: String
}

extension TofuInfo {
    init(from raw: gpgme_tofu_info_t) {
        let pointee = raw.pointee

        self.validity = Int(pointee.validity)
        self.policy = .init(rawValue: Int(pointee.policy))!
        self.signatureCount = Int(pointee.signcount)
        self.encryptionCount = Int(pointee.encrcount)
        self.firstSigned = Date(timeIntervalSince1970: TimeInterval(pointee.signfirst))
        self.lastSigned = Date(timeIntervalSince1970: TimeInterval(pointee.signlast))
        self.firstEncrypted = Date(timeIntervalSince1970: TimeInterval(pointee.encrfirst))
        self.lastEncrypted = Date(timeIntervalSince1970: TimeInterval(pointee.encrlast))
        self.description = String(cString: pointee.description)
    }
}
