//
//  Validity.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-27.
//

enum Validity: String, Hashable, Equatable {
    case undefined = "q"
    case never = "n"
    case marginal = "m"
    case full = "f"
    case ultimate = "u"
    case invalid = "i"
    case revoked = "r"
    case expired = "e"
    case disabled = "d"
    case unknown
    
    var name: String {
        switch self {
        case .undefined:
            return "Undefined"
        case .never:
            return "Never"
        case .marginal:
            return "Marginal"
        case .full:
            return "Full"
        case .ultimate:
            return "Ultimate"
        case .invalid:
            return "Invalid"
        case .revoked:
            return "Revoked"
        case .expired:
            return "Expired"
        case .disabled:
            return "Disabled"
        case .unknown:
            return "Unknown"
        }
    }
}
