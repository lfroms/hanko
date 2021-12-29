//
//  Capabilities.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-27.
//

struct Capabilities: Hashable, Equatable {
    private(set) var sign: Bool = false
    private(set) var encrypt: Bool = false
    private(set) var certify: Bool = false
    private(set) var authenticate: Bool = false

    private(set) var anySign: Bool = false
    private(set) var anyEncrypt: Bool = false
    private(set) var anyCertify: Bool = false
    private(set) var anyAuthenticate: Bool = false

    private(set) var disabled: Bool = false

    let string: String

    init(from string: String) {
        self.string = string

        string.forEach { character in
            switch character {
            case "e":
                encrypt = true
            case "E":
                anyEncrypt = true
            case "s":
                sign = true
            case "S":
                anySign = true
            case "c":
                certify = true
            case "C":
                anyCertify = true
            case "a":
                authenticate = true
            case "A":
                anyAuthenticate = true
            case "D":
                disabled = true
            default:
                break
            }
        }
    }
}
