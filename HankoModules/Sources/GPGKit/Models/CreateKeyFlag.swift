//
//  CreateKeyFlag.swift
//  GPGKit
//
//  Created by Lukas Romsicki on 2022-10-23.
//

public enum CreateKeyFlag {
    case sign
    case encrypt
    case certify
    case authenticate
    case noPassword
    case selfSigned
    case noStore
    case returnPublicKey
    case returnSecretKey
    case force
    case noExpiration
}

extension CreateKeyFlag {
    var value: UInt32 {
        switch self {
            case .sign:
                return 1 << 0
            case .encrypt:
                return 1 << 1
            case .certify:
                return 1 << 2
            case .authenticate:
                return 1 << 3
            case .noPassword:
                return 1 << 7
            case .selfSigned:
                return 1 << 8
            case .noStore:
                return 1 << 9
            case .returnPublicKey:
                return 1 << 10
            case .returnSecretKey:
                return 1 << 11
            case .force:
                return 1 << 12
            case .noExpiration:
                return 1 << 13
        }
    }
}
