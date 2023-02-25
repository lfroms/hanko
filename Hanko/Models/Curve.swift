//
//  Curve.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2022-10-29.
//

enum Curve: String {
    case ed25519
    case ed448
    case nistP256 = "NIST P-256"
    case nistP384 = "NIST P-384"
    case nistP521 = "NIST P-521"
    case brainpoolP256r1
    case brainpoolP384r1
    case brainpoolP512r1
    case secp256k1
}

extension Curve: CustomStringConvertible {
    var description: String {
        switch self {
            case .ed25519:
                return "Ed25519"
            case .ed448:
                return "Ed448"
            case .nistP256, .nistP384, .nistP521:
                return rawValue
            case .brainpoolP256r1:
                return "Brainpool P-256"
            case .brainpoolP384r1:
                return "Brainpool P-384"
            case .brainpoolP512r1:
                return "Brainpool P-512"
            case .secp256k1:
                return rawValue
        }
    }
}

extension Curve: CaseIterable {}
