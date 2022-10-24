//
//  KeyAlgorithm+CustomStringConvertible.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2022-10-23.
//

import GPGKit

extension KeyAlgorithm: CustomStringConvertible {
    public var description: String {
        switch self {
        case .rsa:
            return "RSA"
        case .rsaEncrypt:
            return "RSA (Encrypt Only)"
        case .rsaSign:
            return "RSA (Sign Only)"
        case .elgamalEncrypt:
            return "Elgamal (Encrypt Only)"
        case .dsa:
            return "DSA"
        case .ecdh:
            return "ECDH"
        case .ecdsa:
            return "ECDSA"
        case .elgamal:
            return "Elgamal"
        case .eddsa:
            return "ED DSA"
        case .ecc:
            return "ECC"
        }
    }
}
