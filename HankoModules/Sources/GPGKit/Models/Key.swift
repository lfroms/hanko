//
//  Key.swift
//  GPGKit
//
//  Created by Lukas Romsicki on 2022-10-23.
//

import Foundation
import gpgme

public struct Key {
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
    public let origin: KeyOrigin
    public let `protocol`: Protocol
    public let issuerSerial: String?
    public let issuerName: String?
    public let chainId: String?
    public let ownerTrust: Validity
    public let subkeys: [Subkey]
    public let uids: [UserId]
    public let keyListMode: KeyListMode
    public let fingerprint: String
    public let lastUpdate: Date
}

extension Key {
    init(from raw: gpgme_key_t) {
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
        self.origin = .init(rawValue: Int(pointee.origin))!
        self.protocol = .init(from: pointee.protocol)
        
        if let issuerSerial = pointee.issuer_serial {
            self.issuerSerial = String(cString: issuerSerial)
        } else {
            self.issuerSerial = nil
        }
        
        if let issuerName = pointee.issuer_name {
            self.issuerName = String(cString: issuerName)
        } else {
            self.issuerName = nil
        }
        
        if let chainId = pointee.chain_id {
            self.chainId = String(cString: chainId)
        } else {
            self.chainId = nil
        }
        
        self.ownerTrust = .init(from: pointee.owner_trust)
        
        var subkey = pointee.subkeys
        var subkeyList: [Subkey] = []

        while let unwrappedSubkey = subkey {
            subkeyList.append(.init(from: unwrappedSubkey))
            subkey = unwrappedSubkey.pointee.next
        }
        
        self.subkeys = subkeyList
        
        var uid = pointee.uids
        var uidList: [UserId] = []

        while let unwrappedUid = uid {
            uidList.append(.init(from: unwrappedUid))
            uid = unwrappedUid.pointee.next
        }
        
        self.uids = uidList
        // TODO: keylist_mode can be a bitwise-or value
        self.keyListMode = .init(from: pointee.keylist_mode)!
        self.fingerprint = String(cString: pointee.fpr)
        self.lastUpdate = Date(timeIntervalSince1970: TimeInterval(pointee.last_update))
    }
}
