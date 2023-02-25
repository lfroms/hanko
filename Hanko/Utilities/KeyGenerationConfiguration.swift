//
//  KeyGenerationConfiguration.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2022-10-29.
//

import Foundation
import GPGKit

struct KeyGenerationConfiguration {
    let keyType: KeyAlgorithm
    let keyLength: KeyLength
    let keyUsage: [KeyUsage]
    let curve: Curve?
    let fullName: String
    let email: String
    let comment: String
    let expirationDate: Date?

    var stringRepresentation: String {
        var output: [String] = [
            "<GnupgKeyParms format=\"internal\">",
            format(key: "Key-Type", value: keyType.rawValue),
            format(key: "Key-Length", value: keyLength.rawValue),
            format(key: "Name-Real", value: fullName),
            format(key: "Name-Email", value: email),
//            format(key: "Subkey-Type", value: "default")
        ]
        
        if !keyUsage.isEmpty {
            output.append(format(key: "Key-Usage", value: keyUsage.map { $0.rawValue }.joined(separator: ",")))
        }

        if let curve = curve {
            output.append(format(key: "Key-Curve", value: curve.rawValue))
        }

        if !comment.isEmpty {
            output.append(format(key: "Name-Comment", value: comment))
        }

        if let expirationDate = expirationDate {
            output.append(format(key: "Expire-Date", value: 0))
        }

        output.append("</GnupgKeyParms>")
//        output.append("%commit")
print(output.joined(separator: "\n"))
        return output.joined(separator: "\n")
    }

    private func format<T>(key: String, value: T) -> String {
        return "\(key): \(value)"
    }
}
