//
//  KeyListMode.swift
//  GPGKit
//
//  Created by Lukas Romsicki on 2022-10-23.
//

import gpgme

public enum KeyListMode {
    case local
    case extern
    case sigs
    case sigNotations
    case withSecret
    case withTofu
    case withKeygrip
    case ephemeral
    case validate
    case forceExtern
    case locate
    case locateExternal
}

extension KeyListMode {
    init?(from raw: gpgme_keylist_mode_t) {
        switch raw {
            case 1:
                self = .local
            case 2:
                self = .extern
            case 4:
                self = .sigs
            case 8:
                self = .sigNotations
            case 16:
                self = .withSecret
            case 32:
                self = .withTofu
            case 64:
                self = .withKeygrip
            case 128:
                self = .ephemeral
            case 256:
                self = .validate
            case 512:
                self = .forceExtern
            case 1|2:
                self = .local
            case 1|2|512:
                self = .locateExternal
            default:
                return nil
        }
    }
    
    var raw: gpgme_keylist_mode_t {
        switch self {
            case .local:
                return 1
            case .extern:
                return 2
            case .sigs:
                return 4
            case .sigNotations:
                return 8
            case .withSecret:
                return 16
            case .withTofu:
                return 32
            case .withKeygrip:
                return 64
            case .ephemeral:
                return 128
            case .validate:
                return 256
            case .forceExtern:
                return 512
            case .locate:
                return 1|2
            case .locateExternal:
                return 1|2|512
        }
    }
}
