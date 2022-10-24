//
//  Key+FormattedProperties.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2022-10-23.
//

import GPGKit

extension Key {
    var formattedProperties: [KeyProperty] {
        var properties: [KeyProperty] = []

        guard let primaryKey = subkeys.first else {
            return []
        }

        properties.append(.init(name: "ID", value: primaryKey.id))
        properties.append(.init(name: "Type", value: isSecret ? "Secret & Public" : "Public"))
        properties.append(.init(name: "Length", value: primaryKey.length.description))
        properties.append(.init(name: "Algorithm", value: primaryKey.algorithm.description))
        properties.append(.init(name: "Fingerprint", value: fingerprint.formattedIntoGroupsOfFour))
        properties.append(.init(name: "Created", value: lastUpdate.formatted(date: .abbreviated, time: .standard)))

        properties.append(.init(name: "Expires", value: primaryKey.expires.formatted(date: .abbreviated, time: .standard)))

        properties.append(.init(name: "Validity", value: "\(ownerTrust)"))

        if let cardId = primaryKey.cardNumber {
            properties.append(.init(name: "Card", value: cardId))
        }

        return properties
    }
}
