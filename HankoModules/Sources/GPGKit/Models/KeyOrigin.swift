//
//  KeyOrigin.swift
//  GPGKit
//
//  Created by Lukas Romsicki on 2022-10-23.
//

public enum KeyOrigin: Int {
    case unknown = 0
    case keyServer = 1
    case dane = 3
    case wkd = 4
    case url = 5
    case file = 6
    case `self` = 7
    case other = 31
}
