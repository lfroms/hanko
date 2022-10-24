//
//  KeySignature.swift
//  GPGKit
//
//  Created by Lukas Romsicki on 2022-10-23.
//

import Foundation
import gpgme

public struct KeySignature {
    public let isRevoked: Bool
    public let isExpired: Bool
    public let isInvalid: Bool
    public let isExportable: Bool
    public let trustDepth: Int
    public let trustValue: Int
    public let publicKeyAlgorithm: KeyAlgorithm
    public let keyId: String
    public let timestamp: Date
    public let expires: Date
    // gpgme_error_t status;
    public let uid: String
    public let name: String
    public let email: String
    public let comment: String
    public let signatureClass: Int
    public let notations: [SignatureNotation]
    public let trustScope: String?
}

extension KeySignature {
    init(from raw: gpgme_key_sig_t) {
        let pointee = raw.pointee

        self.isRevoked = pointee.revoked != 0
        self.isExpired = pointee.expired != 0
        self.isInvalid = pointee.invalid != 0
        self.isExportable = pointee.exportable != 0
        self.trustDepth = Int(pointee.trust_depth)
        self.trustValue = Int(pointee.trust_value)
        self.publicKeyAlgorithm = .init(from: pointee.pubkey_algo)
        self.keyId = String(cString: pointee.keyid)
        self.timestamp = Date(timeIntervalSince1970: TimeInterval(pointee.timestamp))
        self.expires = Date(timeIntervalSince1970: TimeInterval(pointee.expires))
        self.uid = String(cString: pointee.uid)
        self.name = String(cString: pointee.name)
        self.email = String(cString: pointee.email)
        self.comment = String(cString: pointee.comment)
        self.signatureClass = Int(pointee.sig_class)

        var notation = pointee.notations
        var notationList: [SignatureNotation] = []

        while let unwrappedNotation = notation {
            notationList.append(.init(from: unwrappedNotation))
            notation = unwrappedNotation.pointee.next
        }

        self.notations = notationList

        self.trustScope = String(cString: pointee.trust_scope)
    }
}
