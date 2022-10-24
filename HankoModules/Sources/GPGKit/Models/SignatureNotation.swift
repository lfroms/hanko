//
//  SignatureNotation.swift
//  GPGKit
//
//  Created by Lukas Romsicki on 2022-10-23.
//

import gpgme

public struct SignatureNotation {
    public let name: String?
    public let value: String
    public let nameLength: Int
    public let valueLength: Int
    // TODO: Incomplete implementation, bitwise OR.
//    public let flags: SignatureNotationFlag
    public let isHumanReadable: Bool
    public let isCritical: Bool
}

extension SignatureNotation {
    init(from raw: gpgme_sig_notation_t) {
        let pointee = raw.pointee

        if let name = pointee.name {
            self.name = String(cString: name)
        } else {
            self.name = nil
        }

        self.value = String(cString: pointee.value)
        self.nameLength = Int(pointee.name_len)
        self.valueLength = Int(pointee.value_len)
//        self.flags = SignatureNotationFlag(rawValue: Int(pointee.flags))!
        self.isHumanReadable = pointee.human_readable != 0
        self.isCritical = pointee.critical != 0
    }
}
