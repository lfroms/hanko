//
//  KeyLength.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2022-10-29.
//

enum KeyLength: Int {
    case short = 2048
    case medium = 3072
    case long = 4096
}

extension KeyLength: CaseIterable {}
