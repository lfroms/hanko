//
//  Algorithm.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-27.
//

enum Algorithm: Int, Hashable, Equatable {
    case rsa = 1
    case rsaEncryptOnly = 2
    case rsaSignOnly = 3
    case elgamalEncryptOnly = 16
    case dsa = 17
    case ecdh = 18
    case ecdsa = 19
    case elgamal = 20
    case diffieHellman = 21
    case edDsa = 22

    var name: String {
        switch self {
        case .rsa:
            return "RSA"
        case .rsaEncryptOnly:
            return "RSA (Encrypt Only)"
        case .rsaSignOnly:
            return "RSA (Sign Only)"
        case .elgamalEncryptOnly:
            return "Elgamal (Encrypt Only)"
        case .dsa:
            return "DSA"
        case .ecdh:
            return "ECDH"
        case .ecdsa:
            return "ECDSA"
        case .elgamal:
            return "Elgamal"
        case .diffieHellman:
            return "Diffie Hellman"
        case .edDsa:
            return "ED DSA"
        }
    }
}
