//
//  Validity+CustomStringConvertible.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2022-10-23.
//

import GPGKit

extension Validity: CustomStringConvertible {
    public var description: String {
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
        case .unknown:
            return "Unknown"
        }
    }
}
