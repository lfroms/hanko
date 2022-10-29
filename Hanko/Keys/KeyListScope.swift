//
//  KeyListScope.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2022-10-29.
//

enum KeyListScope: Equatable {
    case `public`
    case secret
}

extension KeyListScope: CustomStringConvertible {
    var description: String {
        switch self {
            case .public:
                return "Public Keys"
            case .secret:
                return "Secret Keys"
        }
    }
}
