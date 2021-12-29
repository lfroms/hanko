//
//  Key.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-26.
//

import Foundation

class Key: Identifiable {
    let id: String
    let fingerprint: String
    let userIds: [UserID]
    let validity: Validity
    let length: Int
    let algorithm: Algorithm
    let creationDate: Date
    let expirationDate: Date?
    let capabilities: Capabilities
    let isSecret: Bool
    let cardId: String?

    // TODO: Expired state.

    var primaryUserId: UserID {
        // There must always be at least one.
        userIds[0]
    }

    init(from recordSet: RecordSet) throws {
        let primaryProperties = recordSet.primaryRecord.properties
        let subRecords = recordSet.subRecords

        let fingerprintRecord = subRecords.first { $0.type == .fingerprint }

        self.id = primaryProperties[4]
        self.fingerprint = fingerprintRecord!.properties[9]
        self.userIds = subRecords.filter { $0.type == .userId }.compactMap { try? UserID(from: $0) }
        self.validity = Validity(rawValue: primaryProperties[1]) ?? .unknown
        self.length = Int(primaryProperties[2]) ?? 0
        self.algorithm = Algorithm(rawValue: Int(primaryProperties[3])!)!
        self.creationDate = Date(timeIntervalSince1970: Double(primaryProperties[5])!)

        self.expirationDate = primaryProperties[6].isEmpty
            ? nil
            : Date(timeIntervalSince1970: Double(primaryProperties[6])!)

        self.capabilities = Capabilities(from: primaryProperties[11])

        self.isSecret = recordSet.primaryRecord.type == .secretKey
            || recordSet.primaryRecord.type == .secretSubkey

        let rawCardId = recordSet.primaryRecord.properties[14]
        self.cardId = rawCardId.isEmpty ? nil : rawCardId
    }
}

extension Key: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Key, rhs: Key) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Key {
    var formattedProperties: [KeyProperty] {
        var properties: [KeyProperty] = []

        properties.append(.init(name: "ID", value: id))
        properties.append(.init(name: "Type", value: isSecret ? "Secret & Public" : "Public"))
        properties.append(.init(name: "Length", value: "\(length)"))
        properties.append(.init(name: "Algorithm", value: algorithm.name))
        properties.append(.init(name: "Fingerprint", value: fingerprint.formattedIntoGroupsOfFour))
        properties.append(.init(name: "Created", value: creationDate.formatted(date: .abbreviated, time: .standard)))

        if let expirationDate = expirationDate {
            properties.append(.init(name: "Expires", value: expirationDate.formatted(date: .abbreviated, time: .standard)))
        } else {
            properties.append(.init(name: "Expires", value: "Never"))
        }

        properties.append(.init(name: "Validity", value: validity.name))
        properties.append(.init(name: "Capabilities", value: capabilities.string))

        if let cardId = cardId {
            properties.append(.init(name: "Card", value: cardId))
        }

        return properties
    }
}

struct KeyProperty: Equatable {
    let name: String
    let value: String
}
