//
//  KeyAlgorithm.swift
//  GPGKit
//
//  Created by Lukas Romsicki on 2022-10-23.
//

import gpgme

public enum KeyAlgorithm: Int {
    case rsa = 1
    case rsaEncrypt = 2
    case rsaSign = 3
    case elgamalEncrypt = 16
    case dsa = 17
    case ecc = 18
    case elgamal = 20
    case ecdsa = 301
    case ecdh = 302
    case eddsa = 303
}

extension KeyAlgorithm {
    init(from raw: gpgme_pubkey_algo_t) {
        self.init(rawValue: Int(raw.rawValue))!
    }
}
