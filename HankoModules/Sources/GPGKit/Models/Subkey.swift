//
//  Subkey.swift
//  GPGKit
//
//  Created by Lukas Romsicki on 2022-10-23.
//

import Foundation
import gpgme

public struct Subkey {
    public let isRevoked: Bool
    public let isExpired: Bool
    public let isDisabled: Bool
    public let isInvalid: Bool
    public let canEncrypt: Bool
    public let canSign: Bool
    public let canCertify: Bool
    public let isSecret: Bool
    public let canAuthenticate: Bool
    public let isQualified: Bool
    public let isCardKey: Bool
    public let isDeVs: Bool
    public let algorithm: KeyAlgorithm
    public let length: Int
    public let id: String
    public let fingerprint: String
    public let timestamp: Date
    public let expires: Date
    public let cardNumber: String?
    public let curveName: String?
    public let keyGrip: String?
}

extension Subkey {
    init(from raw: gpgme_subkey_t) {
        let pointee = raw.pointee

        self.isRevoked = pointee.revoked != 0
        self.isExpired = pointee.expired != 0
        self.isDisabled = pointee.disabled != 0
        self.isInvalid = pointee.invalid != 0
        self.canEncrypt = pointee.can_encrypt != 0
        self.canSign = pointee.can_sign != 0
        self.canCertify = pointee.can_certify != 0
        self.isSecret = pointee.secret != 0
        self.canAuthenticate = pointee.can_authenticate != 0
        self.isQualified = pointee.is_qualified != 0
        self.isCardKey = pointee.is_cardkey != 0
        self.isDeVs = pointee.is_de_vs != 0
        self.algorithm = .init(from: pointee.pubkey_algo)
        self.length = Int(pointee.length)
        self.id = String(cString: pointee.keyid)
        self.fingerprint = String(cString: pointee.fpr)
        self.timestamp = Date(timeIntervalSince1970: TimeInterval(pointee.timestamp))
        self.expires = Date(timeIntervalSince1970: TimeInterval(pointee.expires))

        if let cardNumber = pointee.card_number {
            self.cardNumber = String(cString: cardNumber)

        } else {
            self.cardNumber = nil
        }

        if let curve = pointee.curve {
            self.curveName = String(cString: curve)
        } else {
            self.curveName = nil
        }

        if let keyGrip = pointee.keygrip {
            self.keyGrip = String(cString: keyGrip)
        } else {
            self.keyGrip = nil
        }
    }
}
