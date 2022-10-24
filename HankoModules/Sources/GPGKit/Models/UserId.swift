//
//  UserId.swift
//  GPGKit
//
//  Created by Lukas Romsicki on 2022-10-23.
//

import Foundation
import gpgme

public struct UserId {
    public let isRevoked: Bool
    public let isInvalid: Bool
    public let origin: KeyOrigin
    public let validity: Validity
    public let id: String
    public let name: String
    public let email: String
    public let comment: String
    public let signatures: [KeySignature]
    public let address: String?
    public let tofu: [TofuInfo]?
    public let lastUpdated: Date
    public let uidHash: String?
}

extension UserId {
    init(from raw: gpgme_user_id_t) {
        let pointee = raw.pointee

        self.isRevoked = pointee.revoked != 0
        self.isInvalid = pointee.invalid != 0
        self.origin = .init(rawValue: Int(pointee.origin))!
        self.validity = .init(from: pointee.validity)
        self.id = String(cString: pointee.uid)
        self.name = String(cString: pointee.name)
        self.email = String(cString: pointee.email)
        self.comment = String(cString: pointee.comment)

        var signature = pointee.signatures
        var signatureList: [KeySignature] = []

        while let unwrappedSignature = signature {
            signatureList.append(.init(from: unwrappedSignature))
            signature = unwrappedSignature.pointee.next
        }

        self.signatures = signatureList

        if let address = pointee.address {
            self.address = String(cString: address)
        } else {
            self.address = nil
        }

        if let firstTofu = pointee.tofu {
            var tofu: gpgme_tofu_info_t? = firstTofu
            var tofuList: [TofuInfo] = []

            while let unwrappedTofu = tofu {
                tofuList.append(.init(from: unwrappedTofu))
                tofu = unwrappedTofu.pointee.next
            }

            self.tofu = tofuList
        } else {
            self.tofu = nil
        }

        self.lastUpdated = Date(timeIntervalSince1970: TimeInterval(pointee.last_update))

        if let uidHash = pointee.uidhash {
            self.uidHash = String(cString: uidHash)
        } else {
            self.uidHash = nil
        }
    }
}
